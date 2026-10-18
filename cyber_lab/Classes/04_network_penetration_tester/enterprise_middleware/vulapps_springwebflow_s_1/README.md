# Lab Target: VULAPPS_SPRINGWEBFLOW_S_1

## Overview

- **Vulnerability**: Spring WebFlow SpEL Evaluation RCE Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8707
- **Container Name**: `cyberlab_vulapps_springwebflow_s_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8707
[cyberlab_vulapps_springwebflow_s_1] (medicean/vulapps:s_springwebflow_1)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_springwebflow_s_1
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8707/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=RCJdPiogUIk
