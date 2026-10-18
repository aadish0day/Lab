# Lab Target: VULHUB_GITLAB_CVE_2021_22205

## Overview

- **Vulnerability**: GitLab ExifTool Workhorse Arbitrary Code Execution (CVE-2021-22205)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8822
- **Container Name**: `cyberlab_vulhub_gitlab_cve_2021_22205`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8822
[cyberlab_vulhub_gitlab_cve_2021_22205] (vulhub/gitlab:13.10.2)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_gitlab_cve_2021_22205
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8822/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=__65_GFERKs
