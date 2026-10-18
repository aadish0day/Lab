# Lab Target: VULAPPS_MEMCACHED_CVE_2016_8704

## Overview

- **Vulnerability**: Memcached Append Command Heap Overflow Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8723
- **Container Name**: `cyberlab_vulapps_memcached_cve_2016_8704`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8723
[cyberlab_vulapps_memcached_cve_2016_8704] (medicean/vulapps:m_memcached_CVE-2016-8704)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulapps_memcached_cve_2016_8704
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8723/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=HM3Z-I998b4
