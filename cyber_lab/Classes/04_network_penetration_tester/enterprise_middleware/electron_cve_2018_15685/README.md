# Lab Target: ELECTRON CVE-2018-15685

## Overview
- **Vulnerability**: CVE-2018-15685
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8655
- **Container Name**: `cyberlab_electron_cve_2018_15685`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8655
[cyberlab_electron_cve_2018_15685] (vulhub/electron:wine)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/electron_cve_2018_15685
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8655/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=In-XF5sY1Yo
