# Lab Target: JOOMLA CVE-2023-23752

## Overview

- **Vulnerability**: CVE-2023-23752
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8573
- **Container Name**: `cyberlab_joomla_cve_2023_23752`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8573
[cyberlab_joomla_cve_2023_23752] (vulhub/joomla:4.2.7)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/joomla_cve_2023_23752
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8573/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['RHbAmxnIDeY', 'CVE 2017 9791 Apache Struts2 S2 048 remote code execution vulnerability']
