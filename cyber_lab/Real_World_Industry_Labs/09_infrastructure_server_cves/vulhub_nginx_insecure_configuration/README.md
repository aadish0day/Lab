# Lab Target: VULHUB_NGINX_INSECURE_CONFIGURATION

## Overview

- **Vulnerability**: Nginx Alias Path Traversal Insecure Configuration Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8791
- **Container Name**: `cyberlab_vulhub_nginx_insecure_configuration`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8791
[cyberlab_vulhub_nginx_insecure_configuration] (vulhub/nginx:insecure-configuration)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulhub_nginx_insecure_configuration
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8791/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=0CFWHjc4B-I
