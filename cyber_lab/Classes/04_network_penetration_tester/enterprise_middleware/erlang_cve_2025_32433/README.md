# Lab Target: ERLANG CVE-2025-32433

## Overview
- **Vulnerability**: CVE-2025-32433
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8653
- **Container Name**: `cyberlab_erlang_cve_2025_32433`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8653
[cyberlab_erlang_cve_2025_32433] (vulhub/erlang:27.3.2-with-ssh)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/erlang_cve_2025_32433
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8653/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=wACOKEivJyU
