# Lab Target: VULAPPS_TOOLS_ANT

## Overview

- **Vulnerability**: Ant Vulnerability Assessment System Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8796
- **Container Name**: `cyberlab_vulapps_tools_ant`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8796
[cyberlab_vulapps_tools_ant] (medicean/vulapps:tools_ant)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulapps_tools_ant
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8796/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=iR39Kaez_eM
