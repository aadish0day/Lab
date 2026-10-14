# Lab Target: INETUTILS CVE-2026-24061

## Overview
- **Vulnerability**: CVE-2026-24061
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8626
- **Container Name**: `cyberlab_inetutils_cve_2026_24061`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8626
[cyberlab_inetutils_cve_2026_24061] (vulhub/inetutils:2.5)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/inetutils_cve_2026_24061
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8626/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=IrZOlqio0nw
