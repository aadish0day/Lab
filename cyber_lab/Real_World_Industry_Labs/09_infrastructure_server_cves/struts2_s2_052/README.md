# Lab Target: STRUTS2 S2-052

## Overview

- **Vulnerability**: S2-052
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8611
- **Container Name**: `cyberlab_struts2_s2_052`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8611
[cyberlab_struts2_s2_052] (vulhub/struts2:2.5.12-rest-showcase)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/struts2_s2_052
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8611/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['_Ifb4WCMVaw', 'SQL to Cypher in 5 Minutes! Crash Course with Code Examples']
