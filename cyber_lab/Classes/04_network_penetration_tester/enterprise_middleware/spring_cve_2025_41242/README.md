# Lab Target: SPRING CVE-2025-41242

## Overview
- **Vulnerability**: CVE-2025-41242
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8584
- **Container Name**: `cyberlab_spring_cve_2025_41242`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8584
[cyberlab_spring_cve_2025_41242] (vulhub/spring-boot-jetty:3.2.4)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/spring_cve_2025_41242
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8584/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['TA2h_kUqfhU', 'sqli-labs series part 2']
