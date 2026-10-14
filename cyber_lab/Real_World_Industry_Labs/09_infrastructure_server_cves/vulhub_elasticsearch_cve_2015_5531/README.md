# Lab Target: VULHUB_ELASTICSEARCH_CVE_2015_5531

## Overview
- **Vulnerability**: Elasticsearch Directory Traversal & Code Execution
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8720
- **Container Name**: `cyberlab_vulhub_elasticsearch_cve_2015_5531`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8720
[cyberlab_vulhub_elasticsearch_cve_2015_5531] (vulhub/elasticsearch:1.5.1)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulhub_elasticsearch_cve_2015_5531
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8720/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=F8K99Sn_dsM
