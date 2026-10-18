# Lab Target: UWSGI UNACC

## Overview

- **Vulnerability**: UNACC
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8602
- **Container Name**: `cyberlab_uwsgi_unacc`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8602
[cyberlab_uwsgi_unacc] (nginx:1-alpine)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/uwsgi_unacc
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8602/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['Xg_8YXagHUA', 'AWS IAM Privilege Escalation: 5 Critical Policy Misconfigurations & Remediations']
