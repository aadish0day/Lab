# Lab Target: CUPS-BROWSED CVE-2024-47177

## Overview

- **Vulnerability**: CVE-2024-47177
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8663
- **Container Name**: `cyberlab_cups_browsed_cve_2024_47177`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8663
[cyberlab_cups_browsed_cve_2024_47177] (vulhub/cups-browsed:2.0.1)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/cups_browsed_cve_2024_47177
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8663/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=NJ2TM4-id2w
