# Adminer Arbitrary File Read (CVE-2021-43008)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Adminer Arbitrary File Read via LOAD DATA LOCAL INFILE** (CVE-2021-43008).

- **Target Directory**: `Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/adminer_arbitrary_file_read`
- **Default Port(s)**: `8189:80`
- **CLI Shortcut**: `./lab start adminer-ssrf`
- **Source of Truth**: [Vulhub Adminer Arbitrary File Read](https://github.com/vulhub/vulhub/tree/master/adminer/vuln)

---

## Architecture & Service Map

- **Container Name**: `cyberlab_02_adminer_fileread`
- **Upstream Image**: `vulhub/adminer:4.6.2`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 400 MB RAM limit

---

## Vulnerability Mechanics

Adminer database management tool arbitrary file read via server connection and MySQL `LOAD DATA LOCAL INFILE`.

### Technical Root Cause

Adminer 4.6.2 connects to arbitrary remote MySQL servers specified by the client. An attacker-controlled rogue MySQL server can respond to the connection with a `LOAD DATA LOCAL INFILE` request, causing Adminer's PHP MySQL client to transmit local server files (such as `/etc/passwd`) back to the rogue server.

---

## Verification & Health Check

### 1. Validate Configuration

```bash
docker compose config -q
```

### 2. Start Services

```bash
docker compose up -d
```

### 3. Check Adminer Web Interface

```bash
curl -i http://localhost:8189/
```

---

## Defensive Remediation & Hardening

1. Upgrade Adminer to version 4.8.1 or later.
2. Restrict database connectivity to localhost or trusted internal networks.
3. Disable `mysqli.allow_local_infile` in `php.ini`.

---

## Verified Video Walkthrough

- **Video Title**: [Arbitrary File Read... As a Service](https://www.youtube.com/watch?v=4teLzdM26l4)
- **Direct URL**: https://www.youtube.com/watch?v=4teLzdM26l4
