# Lab Target: VULAPPS_MEMCACHED_CVE_2016_8706

## Overview
- **Vulnerability**: Memcached SASL Authentication Overflow Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8725
- **Container Name**: `cyberlab_vulapps_memcached_cve_2016_8706`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  HTTP Port 8725
[cyberlab_vulapps_memcached_cve_2016_8706] (medicean/vulapps:m_memcached_CVE-2016-8706)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulapps_memcached_cve_2016_8706
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8725/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=EpXabc1XdmM
