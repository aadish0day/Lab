# Lab Target: PHP CVE-2024-2961

## Overview
- **Vulnerability**: CVE-2024-2961
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8566
- **Container Name**: `cyberlab_php_cve_2024_2961`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8566
[cyberlab_php_cve_2024_2961] (vulhub/php:8.3.4-apache)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/php_cve_2024_2961
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8566/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['PdEK4DCuxqY', 'Samba 3.5.0 - 4.6.4 Remote Code Execution (CVE-2017-7494)']
