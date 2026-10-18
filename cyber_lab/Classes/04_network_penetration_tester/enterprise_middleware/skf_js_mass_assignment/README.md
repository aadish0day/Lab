# Lab Target: SKF_JS_MASS_ASSIGNMENT

## Overview

- **Vulnerability**: OWASP-SKF Node.js Mass Assignment Vulnerability Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8788
- **Container Name**: `cyberlab_skf_js_mass_assignment`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8788
[cyberlab_skf_js_mass_assignment] (blabla1337/owasp-skf-lab:js-mass-assignment)
```

## Quick Start

```bash
cd Classes/04_network_penetration_tester/enterprise_middleware/skf_js_mass_assignment
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8788/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=-2_EUSTcfx4
