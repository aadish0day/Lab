# Lab Target: GRAFANA CVE-2024-9264

## Overview

- **Vulnerability**: CVE-2024-9264
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8643
- **Container Name**: `cyberlab_grafana_cve_2024_9264`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8643
[cyberlab_grafana_cve_2024_9264] (vulhub/grafana:11.0.0)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/grafana_cve_2024_9264
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8643/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=hgroDJHynMo
