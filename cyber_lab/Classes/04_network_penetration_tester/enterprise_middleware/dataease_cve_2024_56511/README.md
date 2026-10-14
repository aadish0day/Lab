# Lab Target: DATAEASE CVE-2024-56511

## Overview
- **Vulnerability**: CVE-2024-56511
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8659
- **Container Name**: `cyberlab_dataease_cve_2024_56511`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8659
[cyberlab_dataease_cve_2024_56511] (vulhub/dataease:2.10.3)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/dataease_cve_2024_56511
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8659/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=SN6EVIG4c-0
