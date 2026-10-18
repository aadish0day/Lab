# Lab Target: COLDFUSION CVE-2017-3066

## Overview

- **Vulnerability**: CVE-2017-3066
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8677
- **Container Name**: `cyberlab_coldfusion_cve_2017_3066`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8677
[cyberlab_coldfusion_cve_2017_3066] (vulhub/coldfusion:11u3)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/coldfusion_cve_2017_3066
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8677/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=l-auOrWEr88
