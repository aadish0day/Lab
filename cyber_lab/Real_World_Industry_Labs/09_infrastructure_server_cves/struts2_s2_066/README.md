# Lab Target: STRUTS2 S2-066

## Overview

- **Vulnerability**: S2-066
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8607
- **Container Name**: `cyberlab_struts2_s2_066`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8607
[cyberlab_struts2_s2_066] (vulhub/struts2:s2-066)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/struts2_s2_066
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8607/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['YZLnfjM3cg4', 'Confluence Security Exploit | CVE-2019-3395 | CVE-2019-3396']
