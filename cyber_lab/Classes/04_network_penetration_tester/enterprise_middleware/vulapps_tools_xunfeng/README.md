# Lab Target: VULAPPS_TOOLS_XUNFENG

## Overview

- **Vulnerability**: Xunfeng Security Vulnerability Scanner Practice Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8719
- **Container Name**: `cyberlab_vulapps_tools_xunfeng`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8719
[cyberlab_vulapps_tools_xunfeng] (medicean/vulapps:tools_xunfeng)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulapps_tools_xunfeng
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8719/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=Jf3ZeL7lGog
