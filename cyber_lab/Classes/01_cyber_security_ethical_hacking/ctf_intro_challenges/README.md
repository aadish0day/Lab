# CTFd Platform & Capture The Flag Practice

## Overview
Host and solve Capture The Flag (CTF) challenges across cryptography, forensics, reverse engineering, and web.

- **Default Port / Access**: `8000`
- **Directory**: `Classes/01_cyber_security_ethical_hacking/ctf_intro_challenges`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d`
2. Navigate to `http://localhost:8000` to complete the initial setup wizard (admin username, password, CTF title).
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
docker compose down
```
