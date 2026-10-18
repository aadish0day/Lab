# Lab Target: STRUTS2 S2-053

## Overview

- **Vulnerability**: S2-053
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8610
- **Container Name**: `cyberlab_struts2_s2_053`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8610
[cyberlab_struts2_s2_053] (vulhub/struts2:s2-053)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/struts2_s2_053
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8610/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['Zp04Gn7lsIU', 'Limit Overrun Race Conditions Lab | PortSwigger Web Academy']
