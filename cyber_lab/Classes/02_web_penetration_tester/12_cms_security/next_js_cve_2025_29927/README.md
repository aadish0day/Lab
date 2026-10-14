# Lab Target: NEXT.JS CVE-2025-29927

## Overview
- **Vulnerability**: CVE-2025-29927
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8571
- **Container Name**: `cyberlab_next_js_cve_2025_29927`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8571
[cyberlab_next_js_cve_2025_29927] (vulhub/nextjs:15.2.2)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/next_js_cve_2025_29927
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8571/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['RC30YCI0c4I', 'Dimofinf cms Version 3.0.0 SQL Injection & XSS (Proof)']
