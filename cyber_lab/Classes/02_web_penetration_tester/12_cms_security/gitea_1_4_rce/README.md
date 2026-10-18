# Lab Target: GITEA 1.4-RCE

## Overview

- **Vulnerability**: 1.4-RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8576
- **Container Name**: `cyberlab_gitea_1_4_rce`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8576
[cyberlab_gitea_1_4_rce] (vulhub/gitea:1.4.0)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/gitea_1_4_rce
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8576/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: ['SGRgLFlfRkM', 'DevSecOps Hashicorp Vault - 5- Vault Authentication Methods - AppRole /Token /UserPass | Rahul Kinge']
