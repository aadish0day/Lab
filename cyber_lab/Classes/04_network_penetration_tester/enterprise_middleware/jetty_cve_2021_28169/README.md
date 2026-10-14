# Lab Target: JETTY CVE-2021-28169

## Overview
- **Vulnerability**: CVE-2021-28169
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8596
- **Container Name**: `cyberlab_jetty_cve_2021_28169`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8596
[cyberlab_jetty_cve_2021_28169] (vulhub/jetty:9.4.40)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/jetty_cve_2021_28169
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8596/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['WEiCTxaHw5k', 'Docker Privilege Escalation: Breaking Out of Containers & Exploiting Host Processes | Part 11']
