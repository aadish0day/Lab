# Lab Target: PYTHON PIL-CVE-2018-16509

## Overview
- **Vulnerability**: PIL-CVE-2018-16509
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8563
- **Container Name**: `cyberlab_python_pil_cve_2018_16509`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8563
[cyberlab_python_pil_cve_2018_16509] (vulhub/ghostscript:9.23-with-flask)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/python_pil_cve_2018_16509
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8563/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['PL73BoQxe2c', ' Interactive Playground to Learn Kubernetes and Cloud Native Security - Madhu Akula']
