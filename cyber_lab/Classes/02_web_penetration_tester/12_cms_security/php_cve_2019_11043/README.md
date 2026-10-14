# Lab Target: PHP CVE-2019-11043

## Overview
- **Vulnerability**: CVE-2019-11043
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8567
- **Container Name**: `cyberlab_php_cve_2019_11043`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8567
[cyberlab_php_cve_2019_11043] (nginx:1)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/php_cve_2019_11043
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8567/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['Pi5HVQlxgdc', 'HeartBleed Vulnerability and Tmux Exploitation | CTF Walkthrough']
