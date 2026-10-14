# PHPMailer msgHTML Local File Disclosure Vulnerability (CVE-2017-5223)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **PHPMailer msgHTML Local File Disclosure Vulnerability (CVE-2017-5223)** (CVE-2017-5223).

* **Target Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/phpmailer_cve_2017_5223`
* **Default Port(s)**: `8218:80`
* **CLI Shortcut**: `./lab start phpmailer-file-disclosure`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_phpmailer_5223`
* **Upstream Image**: `vulhub/phpmailer:5.2.20`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
PHPMailer msgHTML method path evaluation allowing unauthenticated attackers to attach arbitrary local files.

### Technical Root Cause
PHPMailer versions prior to 5.2.22 allow attackers sending HTML emails with `<img>` tags pointing to relative or local file paths (`<img src="/etc/passwd">`) to automatically attach those files into the outgoing message body.

---

## Defensive Remediation & Hardening
Upgrade PHPMailer to version 5.2.22 or newer. Enforce strict `basedir` checks in `msgHTML()`.

---

## Verified Video Walkthrough
* **Video Title**: [Arbitrary File Read... As a Service](https://www.youtube.com/watch?v=4teLzdM26l4)
* **Direct URL**: https://www.youtube.com/watch?v=4teLzdM26l4
