# Lab Target: VULHUB_PHPMAILER_CVE_2017_5223

## Overview
- **Vulnerability**: PHPMailer Local File Disclosure Target (CVE-2017-5223)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8762
- **Container Name**: `cyberlab_vulhub_phpmailer_cve_2017_5223`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8762
[cyberlab_vulhub_phpmailer_cve_2017_5223] (vulhub/phpmailer:5.2.21)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_phpmailer_cve_2017_5223
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8762/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=__65_GFERKs
