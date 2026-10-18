# Lab Target: VULAPPS_BASH_SHELLSHOCK2

## Overview

- **Vulnerability**: GNU Bash Shellshock Incomplete Parser Patch RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8731
- **Container Name**: `cyberlab_vulapps_bash_shellshock2`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8731
[cyberlab_vulapps_bash_shellshock2] (medicean/vulapps:b_bash_shellshock2)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulapps_bash_shellshock2
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8731/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=0CFWHjc4B-I
