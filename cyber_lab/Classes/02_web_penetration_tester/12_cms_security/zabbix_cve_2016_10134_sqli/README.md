# Zabbix - CVE-2016-10134-SQLi

## Overview
- **Vulnerability ID**: CVE-2016-10134
- **Application**: Zabbix
- **Port Allocation**: Port 8518
- **CLI Shortcut**: `./lab start zabbix-cve-2016-10134-sqli`

## Vulnerability Description
Zabbix web front-end latest.php parameter SQL injection vulnerability allowing password hash extraction.

## Quick Start
```bash
# Start target environment
./lab start zabbix-cve-2016-10134-sqli

# View container status
./lab status

# Open interactive shell inside target
./lab shell zabbix-cve-2016-10134-sqli
```

## Verification & Exploitation
```bash
curl http://localhost:8518/
```

## Video Walkthrough
- Walkthrough: [Zabbix CVE-2016-10134-SQLi Security Assessment Walkthrough](https://www.youtube.com/watch?v=F8K99Sn_dsM)
