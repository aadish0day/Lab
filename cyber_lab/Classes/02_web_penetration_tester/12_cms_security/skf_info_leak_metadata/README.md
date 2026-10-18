# Lab Target: SKF_INFO_LEAK_METADATA

## Overview

- **Vulnerability**: OWASP-SKF Metadata Information Leakage Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8811
- **Container Name**: `cyberlab_skf_info_leak_metadata`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  Port 8811
[cyberlab_skf_info_leak_metadata] (blabla1337/owasp-skf-lab:info-leakeage-metadata)
```

## Quick Start

```bash
cd Classes/02_web_penetration_tester/12_cms_security/skf_info_leak_metadata
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8811/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=C-Uck0h5L9s
