# Lab Target: VULAPPS_OPENSSL_HEARTBLEED

## Overview
- **Vulnerability**: OpenSSL Heartbleed TLS Memory Disclosure (CVE-2014-0160)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8794
- **Container Name**: `cyberlab_vulapps_openssl_heartbleed`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8794
[cyberlab_vulapps_openssl_heartbleed] (medicean/vulapps:o_openssl_heartbleed_CVE-2014-0160)
```

## Quick Start
```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulapps_openssl_heartbleed
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8794/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=0tyerVP9R98
