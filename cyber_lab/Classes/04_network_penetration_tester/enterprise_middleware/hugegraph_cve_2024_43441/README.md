# Lab Target: HUGEGRAPH CVE-2024-43441

## Overview
- **Vulnerability**: CVE-2024-43441
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8599
- **Container Name**: `cyberlab_hugegraph_cve_2024_43441`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8599
[cyberlab_hugegraph_cve_2024_43441] (vulhub/hugegraph:1.3.0)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/hugegraph_cve_2024_43441
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8599/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['WnN6dbos5u8', 'Full Ethical Hacking Course - Beginner Network Penetration Testing (2019)']
