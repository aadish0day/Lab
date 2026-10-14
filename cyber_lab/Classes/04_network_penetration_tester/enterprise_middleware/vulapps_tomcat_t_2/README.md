# Lab Target: VULAPPS_TOMCAT_T_2

## Overview
- **Vulnerability**: Apache Tomcat Remote Code Execution Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8709
- **Container Name**: `cyberlab_vulapps_tomcat_t_2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8709
[cyberlab_vulapps_tomcat_t_2] (medicean/vulapps:t_tomcat_2)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_tomcat_t_2
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8709/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=o8IBMWr-drg
