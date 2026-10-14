# Lab Target: SKF_SQLI_NODE

## Overview
- **Vulnerability**: OWASP-SKF Node.js SQL Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8728
- **Container Name**: `cyberlab_skf_sqli_node`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8728
[cyberlab_skf_sqli_node] (blabla1337/owasp-skf-lab:sqli_node)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_sqli_node
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8728/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=-2_EUSTcfx4
