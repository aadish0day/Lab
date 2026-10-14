# Lab Target: SOLR REMOTE-STREAMING-FILEREAD

## Overview
- **Vulnerability**: REMOTE-STREAMING-FILEREAD
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8585
- **Container Name**: `cyberlab_solr_remote_streaming_fileread`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8585
[cyberlab_solr_remote_streaming_fileread] (vulhub/solr:8.8.1)
```

## Quick Start
```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/solr_remote_streaming_fileread
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8585/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['TOLKVejWzPs', 'CVE 2026 58076 Apache Airflow RCE']
