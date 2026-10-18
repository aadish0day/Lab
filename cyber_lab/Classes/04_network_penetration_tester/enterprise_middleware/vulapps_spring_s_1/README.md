# Lab Target: VULAPPS_SPRING_S_1

## Overview

- **Vulnerability**: Spring Framework SpEL Remote Code Execution Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8704
- **Container Name**: `cyberlab_vulapps_spring_s_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8704
[cyberlab_vulapps_spring_s_1] (medicean/vulapps:s_spring_1)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_spring_s_1
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8704/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=X4eRbHgRawI
