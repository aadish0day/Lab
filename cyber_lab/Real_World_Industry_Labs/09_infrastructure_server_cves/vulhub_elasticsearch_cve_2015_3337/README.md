# Lab Target: VULHUB_ELASTICSEARCH_CVE_2015_3337

## Overview

- **Vulnerability**: Elasticsearch Directory Traversal File Disclosure
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8721
- **Container Name**: `cyberlab_vulhub_elasticsearch_cve_2015_3337`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8721
[cyberlab_vulhub_elasticsearch_cve_2015_3337] (vulhub/elasticsearch:1.4.2)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulhub_elasticsearch_cve_2015_3337
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8721/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=vmSTJI3gFSg
