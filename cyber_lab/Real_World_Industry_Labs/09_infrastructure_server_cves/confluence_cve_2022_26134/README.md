# Lab Target: CONFLUENCE CVE-2022-26134

## Overview

- **Vulnerability**: CVE-2022-26134
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8666
- **Container Name**: `cyberlab_confluence_cve_2022_26134`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8666
[cyberlab_confluence_cve_2022_26134] (vulhub/confluence:7.13.6)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/confluence_cve_2022_26134
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8666/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=U_z2OCAkoLk
