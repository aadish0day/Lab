# Lab Target: CONFLUENCE CVE-2023-22515

## Overview

- **Vulnerability**: CVE-2023-22515
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8665
- **Container Name**: `cyberlab_confluence_cve_2023_22515`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8665
[cyberlab_confluence_cve_2023_22515] (vulhub/confluence:8.5.1)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/confluence_cve_2023_22515
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8665/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=KbaOay1yOH0
