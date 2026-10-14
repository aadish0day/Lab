# Lab Target: PHP 8.1-BACKDOOR

## Overview
- **Vulnerability**: 8.1-BACKDOOR
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8569
- **Container Name**: `cyberlab_php_8_1_backdoor`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8569
[cyberlab_php_8_1_backdoor] (vulhub/php:8.1-backdoor)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/php_8_1_backdoor
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8569/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['QLqHMMcBXuQ', 'SSTI Complete Lab Breakdown: Basic server-side template injection']
