# Lab Target: LOG4J CVE-2021-44228

## Overview
- **Vulnerability**: CVE-2021-44228
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8593
- **Container Name**: `cyberlab_log4j_cve_2021_44228`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8593
[cyberlab_log4j_cve_2021_44228] (vulhub/solr:8.11.0)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/log4j_cve_2021_44228
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8593/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['VckaMBA3XRw', 'SomeDayPWN: CVE-2015-1427 Proof of Concept']
