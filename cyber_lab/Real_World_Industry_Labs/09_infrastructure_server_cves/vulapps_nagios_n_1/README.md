# Lab Target: VULAPPS_NAGIOS_N_1

## Overview

- **Vulnerability**: Nagios Core Command Injection Root RCE Target
- **Target Category**: Practice Environment
- **Host Port**: http://localhost:8733
- **Container Name**: `cyberlab_vulapps_nagios_n_1`
- **Memory Ceiling**: 1024m

## Architecture & Data Flow

```
[Attacker Console / CLI]
       |
       v  HTTP Port 8733
[cyberlab_vulapps_nagios_n_1] (medicean/vulapps:n_nagios_1)
```

## Quick Start

```bash
cd Real_World_Industry_Labs/09_infrastructure_server_cves/vulapps_nagios_n_1
docker compose up -d
```

## Attack Verification

```bash
curl -i http://localhost:8733/
```

## Walkthrough & Video Reference

- **YouTube Walkthrough**: https://www.youtube.com/watch?v=bZGDrNmCRWo
