# Zabbix - CVE-2017-2824-RCE

## Overview
- **Vulnerability ID**: CVE-2017-2824
- **Application**: Zabbix
- **Port Allocation**: Port 8519
- **CLI Shortcut**: `./lab start zabbix-cve-2017-2824-rce`

## Vulnerability Description
Zabbix active proxy trapper command execution vulnerability resulting in remote system takeover.

## Quick Start
```bash
# Start target environment
./lab start zabbix-cve-2017-2824-rce

# View container status
./lab status

# Open interactive shell inside target
./lab shell zabbix-cve-2017-2824-rce
```

## Verification & Exploitation
```bash
curl http://localhost:8519/
```

## Video Walkthrough
- Walkthrough: [Zabbix CVE-2017-2824-RCE Security Assessment Walkthrough](https://www.youtube.com/watch?v=FBWpX8icMMo)
