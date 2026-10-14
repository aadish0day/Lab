# Lab Target: VULHUB_NODE_CVE_2017_14849

## Overview
- **Vulnerability**: Node.js Express Framework Directory Traversal Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8729
- **Container Name**: `cyberlab_vulhub_node_cve_2017_14849`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8729
[cyberlab_vulhub_node_cve_2017_14849] (vulhub/node:8.5.0)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulhub_node_cve_2017_14849
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8729/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=1OvVwZgqnlo
