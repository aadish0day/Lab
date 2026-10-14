# Lab Target: FASTJSON 1.2.47-RCE

## Overview
- **Vulnerability**: 1.2.47-RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8578
- **Container Name**: `cyberlab_fastjson_1_2_47_rce`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8578
[cyberlab_fastjson_1_2_47_rce] (vulhub/fastjson:1.2.45)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/fastjson_1_2_47_rce
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8578/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['ST1glAWane0', 'Hacking pills #42: CVE-2023-49103 ownCloud critical information disclosure']
