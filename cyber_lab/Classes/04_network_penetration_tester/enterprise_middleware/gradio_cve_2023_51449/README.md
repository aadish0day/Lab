# Lab Target: GRADIO CVE-2023-51449

## Overview

- **Vulnerability**: CVE-2023-51449
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8645
- **Container Name**: `cyberlab_gradio_cve_2023_51449`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8645
[cyberlab_gradio_cve_2023_51449] (vulhub/gradio:4.10.0)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/gradio_cve_2023_51449
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8645/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=DqrBQbxLZmw
