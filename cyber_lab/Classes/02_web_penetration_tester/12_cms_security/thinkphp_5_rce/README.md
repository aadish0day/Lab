# Lab Target: THINKPHP 5-RCE

## Overview

- **Vulnerability**: 5-RCE
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8560
- **Container Name**: `cyberlab_thinkphp_5_rce`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8560
[cyberlab_thinkphp_5_rce] (vulhub/thinkphp:5.0.20)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/thinkphp_5_rce
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8560/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: [ThinkPHP Exploit Analysis & RCE Walkthrough](https://www.youtube.com/watch?v=g0oc37-rVrE)
- **Technical Reference**: [Vulhub ThinkPHP 5.0.20 / 5.x RCE Analysis](https://vulhub.org/#/environments/thinkphp/5-rce/)
