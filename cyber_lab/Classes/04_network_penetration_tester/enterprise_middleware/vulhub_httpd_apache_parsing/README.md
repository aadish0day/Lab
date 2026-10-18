# Lab Target: VULHUB_HTTPD_APACHE_PARSING

## Overview

- **Vulnerability**: Apache HTTP Server Multiviews Extension Parsing Vulnerability
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8832
- **Container Name**: `cyberlab_vulhub_httpd_apache_parsing`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8832
[cyberlab_vulhub_httpd_apache_parsing] (vulhub/httpd:2.4.10)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_httpd_apache_parsing
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8832/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=MiaEWNruYdI
