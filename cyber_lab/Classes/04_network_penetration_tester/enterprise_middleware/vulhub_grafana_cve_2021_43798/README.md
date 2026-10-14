# Lab Target: VULHUB_GRAFANA_CVE_2021_43798

## Overview
- **Vulnerability**: Grafana Plugin Directory Traversal & Arbitrary File Read
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8833
- **Container Name**: `cyberlab_vulhub_grafana_cve_2021_43798`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8833
[cyberlab_vulhub_grafana_cve_2021_43798] (vulhub/grafana:8.3.0)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_grafana_cve_2021_43798
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8833/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Hv8H7ZgNdi4
