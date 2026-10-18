# Lab Target: SKF_SSRF_URL_REDIRECTION

## Overview

- **Vulnerability**: OWASP-SKF SSRF via Open URL Redirection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8841
- **Container Name**: `cyberlab_skf_ssrf_url_redirection`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8841
[cyberlab_skf_ssrf_url_redirection] (blabla1337/owasp-skf-lab:ssrf-url-redirection)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_ssrf_url_redirection
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8841/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=vmSTJI3gFSg
