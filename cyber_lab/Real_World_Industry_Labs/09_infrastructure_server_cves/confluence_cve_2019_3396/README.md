# Lab Target: CONFLUENCE CVE-2019-3396

## Overview
- **Vulnerability**: CVE-2019-3396
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8668
- **Container Name**: `cyberlab_confluence_cve_2019_3396`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8668
[cyberlab_confluence_cve_2019_3396] (vulhub/confluence:6.10.2)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/confluence_cve_2019_3396
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8668/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=lrPPMDNpgdY
