# DVWA Web Fundamentals: Intro XSS & SQL Injection

## Overview
Understand foundational web vulnerabilities: Reflected/Stored Cross-Site Scripting (XSS) and Authentication Bypass via SQLi.

- **Default Port / Access**: `8083`
- **Directory**: `Classes/01_cyber_security_ethical_hacking/web_basics_dvwa`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d`
2. Browse to `http://localhost:8083` and click 'Create / Reset Database'. Login with `admin` / `password`.
3. Navigate to 'DVWA Security' and set difficulty to 'Low'.
4. XSS (Reflected): Enter `<script>alert(document.cookie)</script>` into the input form.
5. SQL Injection: Enter `' OR '1'='1` in the User ID input to dump all database users and hashes.

---

## YouTube Walkthroughs & Solving Guides

- [SQL Injection for Beginners (DVWA Walkthrough)](https://www.youtube.com/watch?v=aYFZp80eOb0)
- [InsiderPhD - DVWA Brute Force Walkthrough](https://www.youtube.com/watch?v=SWzxoK6DAE4)
- [InsiderPhD - DVWA Cross Site Request Forgery (CSRF) Walkthrough](https://www.youtube.com/watch?v=Nfb9E8MJv6k)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
