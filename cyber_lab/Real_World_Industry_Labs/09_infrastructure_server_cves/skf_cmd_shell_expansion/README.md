# Lab Target: SKF_CMD_SHELL_EXPANSION

## Overview
- **Vulnerability**: OWASP-SKF Shell Parameter Expansion Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8855
- **Container Name**: `cyberlab_skf_cmd_shell_expansion`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8855
[cyberlab_skf_cmd_shell_expansion] (blabla1337/owasp-skf-lab:cmd-shell-expansion)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/skf_cmd_shell_expansion
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8855/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=-dc_vLdYEtA
