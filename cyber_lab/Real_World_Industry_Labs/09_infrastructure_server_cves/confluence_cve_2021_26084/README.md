# Lab Target: CONFLUENCE CVE-2021-26084

## Overview

- **Vulnerability**: CVE-2021-26084
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8667
- **Container Name**: `cyberlab_confluence_cve_2021_26084`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8667
[cyberlab_confluence_cve_2021_26084] (vulhub/confluence:7.4.10)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/confluence_cve_2021_26084
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8667/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=DWnTxHpA61I
