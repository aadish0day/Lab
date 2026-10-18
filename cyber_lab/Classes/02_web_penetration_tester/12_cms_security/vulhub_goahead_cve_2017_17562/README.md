# Lab Target: VULHUB_GOAHEAD_CVE_2017_17562

## Overview

- **Vulnerability**: GoAhead Embedded Server LD_PRELOAD CGI RCE (CVE-2017-17562)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8825
- **Container Name**: `cyberlab_vulhub_goahead_cve_2017_17562`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8825
[cyberlab_vulhub_goahead_cve_2017_17562] (vulhub/goahead:3.6.4)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_goahead_cve_2017_17562
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8825/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=w-eJM2Pc0KI
