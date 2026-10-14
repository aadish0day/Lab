# JWT Security & Token Exploitation Lab (jwt_tool)

## Overview
Analyze, crack, and forge JSON Web Tokens: `none` algorithm bypass, HMAC key brute-forcing, and JWK/JKU header injection.

- **Default Port / Access**: `Terminal / CLI`
- **Directory**: `Classes/02_web_penetration_tester/23_jwt_attacks/jwt_security_lab`

---

## How to Solve & Practice

1. Start the container: `docker compose up -d`
2. Enter the workspace: `docker exec -it cyberlab_02_jwt_lab /bin/bash` or `python3 /jwt_tool/jwt_tool.py`.
3. Crack weak HMAC secret: `python3 jwt_tool.py <TOKEN> -C -d /wordlists/rockyou.txt`.
4. Exploit the `none` algorithm vulnerability: `python3 jwt_tool.py <TOKEN> -X a` to forge admin privileges.
5. Tamper with token claims and re-sign with a spoofed key.

---

## YouTube Walkthroughs & Solving Guides

- [Intigriti - Hacker Tools: JWT_Tool Walkthrough](https://www.youtube.com/watch?v=ZGarKE9KTAY)
- [CryptoCat - Introduction to JWT Attacks](https://www.youtube.com/watch?v=GIq3naOLrTg)
- [Three New Attacks Against JSON Web Tokens](https://www.youtube.com/watch?v=mJ6BQ5eFkG4)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
