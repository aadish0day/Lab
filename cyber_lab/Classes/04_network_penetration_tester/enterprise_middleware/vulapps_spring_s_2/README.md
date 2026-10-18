# Lab Target: VULAPPS_SPRING_S_2

## Overview

- **Vulnerability**: Spring Framework Data Commons RCE Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8705
- **Container Name**: `cyberlab_vulapps_spring_s_2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8705
[cyberlab_vulapps_spring_s_2] (medicean/vulapps:s_spring_2)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_spring_s_2
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8705/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=w-eJM2Pc0KI
