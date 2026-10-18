# CMS Made Simple Authenticated Template Injection / RCE (CVE-2021-26120)

## Overview

CMS Made Simple (CMSMS) is an open-source PHP content management system. In versions 2.2.15 and prior (including 2.2.9.1), the Smarty template engine (versions before 3.1.39) contained an arbitrary code execution vulnerability (CVE-2021-26120) where an attacker with template/designer permissions could inject executable PHP code via an unexpected function name after `{function name=...}`.

In CMSMS versions prior to 2.2.9.1, unauthenticated attackers can chain CVE-2019-9053 (SQL injection) to extract administrator credentials/hashes or reset the password, and subsequently leverage CVE-2021-26120 to achieve remote code execution.

- **Primary Interface**: `http://localhost:8260`
- **Installation Wizard**: `http://localhost:8260/install.php`
- **Docker Shortcut**: `./lab start cmsms-object-rce`
- **Container Names**: `cyberlab_02_cmsms_deser_app` (App) and `cyberlab_02_cmsms_deser_db` (MySQL 5.7)
- **Database Credentials**: Host `db`, Database `cmsms`, User `root`, Password `root`
- **Source of Truth**: [Vulhub CVE-2021-26120](https://github.com/vulhub/vulhub/tree/master/cmsms/CVE-2021-26120)

---

## Service Architecture

- **Web Service (`cmsms`)**: Serves CMSMS 2.2.9.1 on host port `8260` (container port `80`).
- **Database (`db`)**: MySQL 5.7 database container with persistent volume `cmsms_deser_db_data:/var/lib/mysql`.

---

## Verification & Health Check

### 1. Validate Configuration

```bash
docker compose config -q
```

### 2. Start Services

```bash
docker compose up -d
```

### 3. Check Web Endpoints

```bash
# Check root response (redirects to install or login)
curl -i http://localhost:8260/

# Verify installer endpoint
curl -i http://localhost:8260/install.php
```

---

## Defensive Remediation

1. Upgrade CMS Made Simple to version 2.2.16 or newer.
2. Upgrade the underlying Smarty library to version 3.1.39 or newer.
3. Restrict admin console access using IP whitelisting and enforce strong administrator passwords.

---

## References

- [Vulhub CMSMS CVE-2021-26120 Environment](https://github.com/vulhub/vulhub/tree/master/cmsms/CVE-2021-26120)
- [NVD Advisory CVE-2021-26120](https://nvd.nist.gov/vuln/detail/CVE-2021-26120)
- [Source Incite Advisory & PoC](https://srcincite.io/pocs/cve-2021-26120.py.txt)
