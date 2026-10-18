# Lab Target: SPARK UNACC

## Overview

- **Vulnerability**: UNACC
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8613
- **Container Name**: `cyberlab_spark_unacc`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8613
[cyberlab_spark_unacc] (vulhub/spark:2.3.1)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/spark_unacc
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8613/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['_jtYqsb-nOU', 'Creating Shellcode in C and x64 Assembly']
