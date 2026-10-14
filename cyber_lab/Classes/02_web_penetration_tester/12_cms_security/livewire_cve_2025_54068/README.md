# Lab Target: LIVEWIRE CVE-2025-54068

## Overview
- **Vulnerability**: CVE-2025-54068
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8624
- **Container Name**: `cyberlab_livewire_cve_2025_54068`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8624
[cyberlab_livewire_cve_2025_54068] (vulhub/livewire:3.6.3)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/livewire_cve_2025_54068
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8624/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=j082gL5o5yQ
