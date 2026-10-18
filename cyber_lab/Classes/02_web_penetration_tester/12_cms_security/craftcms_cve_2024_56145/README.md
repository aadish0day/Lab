# Lab Target: CRAFTCMS CVE-2024-56145

## Overview

- **Vulnerability**: CVE-2024-56145
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8638
- **Container Name**: `cyberlab_craftcms_cve_2024_56145`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8638
[cyberlab_craftcms_cve_2024_56145] (vulhub/craftcms:5.5.1.1)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/craftcms_cve_2024_56145
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8638/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=PHe0jWGXjiI
