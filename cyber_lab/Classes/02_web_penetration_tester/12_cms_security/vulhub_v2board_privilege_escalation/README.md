# Lab Target: VULHUB_V2BOARD_PRIVILEGE_ESCALATION

## Overview

- **Vulnerability**: v2board 1.6.1 Password Reset Privilege Escalation
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8824
- **Container Name**: `cyberlab_vulhub_v2board_privilege_escalation`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8824
[cyberlab_vulhub_v2board_privilege_escalation] (vulhub/v2board:1.6.1)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/vulhub_v2board_privilege_escalation
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8824/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=X4eRbHgRawI
