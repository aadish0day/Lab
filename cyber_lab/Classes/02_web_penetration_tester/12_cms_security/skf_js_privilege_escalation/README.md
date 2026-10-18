# Lab Target: SKF_JS_PRIVILEGE_ESCALATION

## Overview

- **Vulnerability**: OWASP-SKF Node.js Privilege Escalation Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8767
- **Container Name**: `cyberlab_skf_js_privilege_escalation`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8767
[cyberlab_skf_js_privilege_escalation] (blabla1337/owasp-skf-lab:js-privilege-escalation)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_js_privilege_escalation
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8767/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=RCJdPiogUIk
