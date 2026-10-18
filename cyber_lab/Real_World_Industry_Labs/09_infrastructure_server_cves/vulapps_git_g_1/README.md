# Lab Target: VULAPPS_GIT_G_1

## Overview

- **Vulnerability**: Git Client Command Execution Target (CVE-2014-9390)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8739
- **Container Name**: `cyberlab_vulapps_git_g_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8739
[cyberlab_vulapps_git_g_1] (medicean/vulapps:g_git_1)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulapps_git_g_1
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8739/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=CuR2BXCE0LY
