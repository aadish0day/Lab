# Lab Target: VULHUB_HUGEGRAPH_CVE_2024_27348

## Overview
- **Vulnerability**: Apache HugeGraph Gremlin Gremlin Server RCE (CVE-2024-27348)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8827
- **Container Name**: `cyberlab_vulhub_hugegraph_cve_2024_27348`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8827
[cyberlab_vulhub_hugegraph_cve_2024_27348] (vulhub/hugegraph:1.0.0)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_hugegraph_cve_2024_27348
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8827/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=RCJdPiogUIk
