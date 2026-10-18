# Lab Target: SHOWDOC 3.2.5-SQLI

## Overview

- **Vulnerability**: 3.2.5-SQLI
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8615
- **Container Name**: `cyberlab_showdoc_3_2_5_sqli`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8615
[cyberlab_showdoc_3_2_5_sqli] (vulhub/showdoc:3.2.4)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/showdoc_3_2_5_sqli
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8615/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['_tHFVfFqG6k', 'A Deep Dive into AWS IAM Privilege Escalation Attacks: Defenders’ Edition 2022']
