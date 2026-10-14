# Lab Target: ELASTICSEARCH WOOYUN-2015-110216

## Overview
- **Vulnerability**: WOOYUN-2015-110216
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8660
- **Container Name**: `cyberlab_elasticsearch_wooyun_2015_110216`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8660
[cyberlab_elasticsearch_wooyun_2015_110216] (vulhub/elasticsearch:1.5.1-with-tomcat)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/elasticsearch_wooyun_2015_110216
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8660/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=QLqHMMcBXuQ
