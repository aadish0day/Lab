# Lab Target: TOMCAT CVE-2026-34486

## Overview
- **Vulnerability**: CVE-2026-34486
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8583
- **Container Name**: `cyberlab_tomcat_cve_2026_34486`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8583
[cyberlab_tomcat_cve_2026_34486] (vulhub/tomcat:9.0.116)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/tomcat_cve_2026_34486
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8583/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['Sr7QEHl7rpU', 'CVE-2023-32315 Openfire admin console path traversal exploit demo']
