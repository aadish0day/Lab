# Lab Target: GRADIO CVE-2024-1561

## Overview

- **Vulnerability**: CVE-2024-1561
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8644
- **Container Name**: `cyberlab_gradio_cve_2024_1561`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8644
[cyberlab_gradio_cve_2024_1561] (vulhub/gradio:4.12.0)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/gradio_cve_2024_1561
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8644/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=NHfWRQAMb5s
