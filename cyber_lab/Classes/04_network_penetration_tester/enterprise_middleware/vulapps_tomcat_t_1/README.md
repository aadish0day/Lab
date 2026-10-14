# Lab Target: VULAPPS_TOMCAT_T_1

## Overview
- **Vulnerability**: Apache Tomcat Session Deserialization Practice Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8708
- **Container Name**: `cyberlab_vulapps_tomcat_t_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8708
[cyberlab_vulapps_tomcat_t_1] (medicean/vulapps:t_tomcat_1)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_tomcat_t_1
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8708/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=B7p8dIB7bFg
