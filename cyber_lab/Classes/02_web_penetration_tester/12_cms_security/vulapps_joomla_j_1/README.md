# Lab Target: VULAPPS_JOOMLA_J_1

## Overview

- **Vulnerability**: Joomla com_content SQL Injection Practice Environment
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8697
- **Container Name**: `cyberlab_vulapps_joomla_j_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8697
[cyberlab_vulapps_joomla_j_1] (medicean/vulapps:j_joomla_1)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulapps_joomla_j_1
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8697/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=W4MXUnZB2jc
