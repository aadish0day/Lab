# Lab Target: ROCKETMQ CVE-2023-37582

## Overview
- **Vulnerability**: CVE-2023-37582
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8616
- **Container Name**: `cyberlab_rocketmq_cve_2023_37582`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8616
[cyberlab_rocketmq_cve_2023_37582] (vulhub/rocketmq:5.1.0)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/rocketmq_cve_2023_37582
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8616/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: ['aOU9DbRWw2k', '[日本語: Japanese] Apache Struts2 S2-032 CVE-2016-3081 DMI RCE Metasploit Demo']
