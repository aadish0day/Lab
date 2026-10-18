# Lab Target: CGI CVE-2016-5385

## Overview

- **Vulnerability**: CVE-2016-5385
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8679
- **Container Name**: `cyberlab_cgi_cve_2016_5385`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8679
[cyberlab_cgi_cve_2016_5385] (nginx:1)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/cgi_cve_2016_5385
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8679/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=I5XAN_pkfIY
