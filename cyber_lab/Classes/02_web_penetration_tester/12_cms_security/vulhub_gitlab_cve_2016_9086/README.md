# Lab Target: VULHUB_GITLAB_CVE_2016_9086

## Overview
- **Vulnerability**: GitLab Project Import Directory Traversal Target (CVE-2016-9086)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8823
- **Container Name**: `cyberlab_vulhub_gitlab_cve_2016_9086`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow
```
[Attacker Console / CLI]
       |
       v  Port 8823
[cyberlab_vulhub_gitlab_cve_2016_9086] (vulhub/gitlab:8.13.0)
```

## Quick Start
```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_gitlab_cve_2016_9086
docker compose up -d
```

## Attack Verification
```bash
curl -i http://localhost:8823/
```

## Walkthrough & Video Reference
- **YouTube Walkthrough**: https://www.youtube.com/watch?v=eWEgUcHPle0
