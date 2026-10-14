# Lab Target: SKF_CMD_PATH_TRAVERSAL

## Overview
- **Vulnerability**: OWASP-SKF Command Injection with Path Traversal Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8854
- **Container Name**: `cyberlab_skf_cmd_path_traversal`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8854
[cyberlab_skf_cmd_path_traversal] (blabla1337/owasp-skf-lab:cmd-path-traversal)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_cmd_path_traversal
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8854/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=0tyerVP9R98
