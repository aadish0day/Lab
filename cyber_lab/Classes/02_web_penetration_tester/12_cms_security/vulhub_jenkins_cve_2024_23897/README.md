# Lab Target: VULHUB_JENKINS_CVE_2024_23897

## Overview

- **Vulnerability**: Jenkins CLI Arbitrary File Read Target (CVE-2024-23897)
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8820
- **Container Name**: `cyberlab_vulhub_jenkins_cve_2024_23897`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8820
[cyberlab_vulhub_jenkins_cve_2024_23897] (vulhub/jenkins:2.441)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_jenkins_cve_2024_23897
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8820/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=9UAQ1VzSq8Q
