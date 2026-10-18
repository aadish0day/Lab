# Lab Target: XSTREAM CVE-2021-21351

## Overview

- **Vulnerability**: CVE-2021-21351
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8601
- **Container Name**: `cyberlab_xstream_cve_2021_21351`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8601
[cyberlab_xstream_cve_2021_21351] (vulhub/xstream:1.4.15)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/xstream_cve_2021_21351
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8601/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['XJvpC-p4qKM', 'CVE-2016-4437 shiro-exploit']
