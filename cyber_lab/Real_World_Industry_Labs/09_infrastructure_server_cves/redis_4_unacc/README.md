# Lab Target: REDIS 4-UNACC

## Overview

- **Vulnerability**: 4-UNACC
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8618
- **Container Name**: `cyberlab_redis_4_unacc`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8618
[cyberlab_redis_4_unacc] (vulhub/redis:4.0.14)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/redis_4_unacc
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8618/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['aRwxsn9ZEQw', 'Metasploit Framework basics on Kali Linux - Owning a Windows Server']
