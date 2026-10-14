# Lab Target: VULAPPS_SPRINGBOOT_S_1

## Overview
- **Vulnerability**: SpringBoot Actuator Jolokia Remote Code Execution Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8706
- **Container Name**: `cyberlab_vulapps_springboot_s_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8706
[cyberlab_vulapps_springboot_s_1] (medicean/vulapps:s_springboot_1)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_springboot_s_1
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8706/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=QjPFjd8GJWY
