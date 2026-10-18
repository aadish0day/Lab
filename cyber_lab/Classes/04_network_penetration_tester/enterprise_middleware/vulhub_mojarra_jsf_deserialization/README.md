# Lab Target: VULHUB_MOJARRA_JSF_DESERIALIZATION

## Overview

- **Vulnerability**: Mojarra JSF ViewState Deserialization RCE Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8774
- **Container Name**: `cyberlab_vulhub_mojarra_jsf_deserialization`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8774
[cyberlab_vulhub_mojarra_jsf_deserialization] (vulhub/mojarra:2.1.29)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/vulhub_mojarra_jsf_deserialization
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8774/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=2jVNXLMYEqM
