# Lab Target: VULHUB_JUPYTER_NOTEBOOK_RCE

## Overview
- **Vulnerability**: Jupyter Notebook Unauthorized Access RCE Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8763
- **Container Name**: `cyberlab_vulhub_jupyter_notebook_rce`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8763
[cyberlab_vulhub_jupyter_notebook_rce] (vulhub/jupyter:notebook-rce)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_jupyter_notebook_rce
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8763/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=eWEgUcHPle0
