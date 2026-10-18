# Lab Target: GOTENBERG CVE-2026-40281

## Overview

- **Vulnerability**: CVE-2026-40281
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8646
- **Container Name**: `cyberlab_gotenberg_cve_2026_40281`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8646
[cyberlab_gotenberg_cve_2026_40281] (vulhub/gotenberg:8.30.1)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/gotenberg_cve_2026_40281
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8646/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=KY58WcX7OZ4
