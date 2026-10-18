# Lab Target: GITLAB CVE-2026-85706

## Overview

- **Vulnerability**: CVE-2026-85706
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8647
- **Container Name**: `cyberlab_gitlab_cve_2026_85706`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8647
[cyberlab_gitlab_cve_2026_85706] (vulhub/gitlab:19.3.1)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/gitlab_cve_2026_85706
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8647/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=K7XBQWAZdZ4
