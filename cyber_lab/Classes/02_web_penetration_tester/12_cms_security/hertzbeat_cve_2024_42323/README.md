# Lab Target: HERTZBEAT CVE-2024-42323

## Overview
- **Vulnerability**: CVE-2024-42323
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8629
- **Container Name**: `cyberlab_hertzbeat_cve_2024_42323`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8629
[cyberlab_hertzbeat_cve_2024_42323] (vulhub/hertzbeat:1.4.4)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/hertzbeat_cve_2024_42323
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8629/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=mX3MtC6psJA
