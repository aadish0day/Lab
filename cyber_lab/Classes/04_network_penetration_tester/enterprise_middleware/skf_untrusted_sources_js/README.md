# Lab Target: SKF_UNTRUSTED_SOURCES_JS

## Overview

- **Vulnerability**: OWASP-SKF Untrusted Script Source Injection Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8714
- **Container Name**: `cyberlab_skf_untrusted_sources_js`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8714
[cyberlab_skf_untrusted_sources_js] (blabla1337/owasp-skf-lab:untrusted-sources-js)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_untrusted_sources_js
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8714/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=2jVNXLMYEqM
