# CTFd Platform & Capture The Flag Practice

## Overview

Host and solve Capture The Flag (CTF) challenges across cryptography, forensics, reverse engineering, and web.

- **Direct Port / Access**: `http://localhost:8000` (CTFd App)
- **Proxy Port / Access**: `http://localhost:80` (Nginx Reverse Proxy)
- **Directory**: `Classes/01_cyber_security_ethical_hacking/ctf_intro_challenges`

---

## Architecture

This lab runs the complete production-grade CTFd stack:

- **`ctfd`**: Core CTFd application server running Gunicorn/Flask (`ctfd/ctfd:latest`) on port `8000`.
- **`db`**: MariaDB 10.11 database for persistent user, challenge, and submission tracking (`.data/mysql`).
- **`cache`**: Redis 4 for session caching and rate-limiting (`.data/redis`).
- **`nginx`**: Reverse proxy server with buffering, large uploads, and Server-Sent Events (`/events`) stream handling on port `80`.
- **`permissions`**: Alpine container ensuring correct ownership (`UID 1001`) on upload and log directories.

---

## How to Solve & Practice

1. Start the lab from repository root:
   ```bash
   ./lab start ctfd
   # or from this directory:
   docker compose up -d
   ```
2. Navigate to `http://localhost:8000` (or `http://localhost:80`) to complete the initial setup wizard (admin username, password, CTF title).
3. Explore challenge categories: Web, Crypto, Forensics, Reverse Engineering.
4. Practice submitting flag tokens in standard format: `CTF{...}`.

---

## YouTube Walkthroughs & Solving Guides

- [John Hammond - Running CTFs with Docker (VirSecCon CTF Recap)](https://www.youtube.com/watch?v=nuX7IRY5Pz8)
- [LiveOverflow - How To Learn Hacking With CTFs](https://www.youtube.com/watch?v=Lus7aNf2xDg)
- [Host CTF with CTFd in Google Cloud Platform Setup Guide](https://www.youtube.com/watch?v=ZPDEnY7ttpM)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
./lab stop ctfd
# or
docker compose down
```
