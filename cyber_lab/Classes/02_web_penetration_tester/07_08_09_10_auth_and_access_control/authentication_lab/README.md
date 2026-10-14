# Attacking Authentication & Broken Access Control Lab

## Overview
Practice brute-forcing logins, password reset logic flaws, session hijacking, cookie tampering, and IDOR.

- **Default Port / Access**: `8084`
- **Directory**: `Classes/02_web_penetration_tester/07_08_09_10_auth_and_access_control/authentication_lab`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d` and open `http://localhost:8084`.
2. Brute Force: Send login POST request to Burp Intruder or Hydra using standard wordlists (`rockyou.txt`).
3. Session Management: Analyze session cookie entropy and test session fixation upon login.
4. Insecure Direct Object Reference (IDOR): Change user account IDs or profile parameter numbers to view other users' data.
5. Client-Side Control Bypass: Modify hidden input parameters or disable JavaScript validation to bypass form restrictions.

---

## YouTube Walkthroughs & Solving Guides

- [Authentication Vulnerabilities | Complete Guide (Rana Khalil)](https://www.youtube.com/watch?v=mox6DL4zK7I)
- [Broken Access Control | Complete Guide (Rana Khalil)](https://www.youtube.com/watch?v=_jz5qFWhLcg)
- [NahamSec - Insecure Direct Object Reference / IDOR Explained](https://www.youtube.com/watch?v=bCUqio4gNu4)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
