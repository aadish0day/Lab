# OWASP Juice Shop (Modern Web Vulnerabilities)

## Overview
The gold standard modern vulnerable web application (Angular, Express, Node.js, SQLite) with a built-in gamified Score Board.

- **Default Port / Access**: `3000`
- **Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/juice_shop`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d` and open `http://localhost:3000`.
2. Find the hidden Score Board by inspecting client-side Angular JS bundles or navigating to `/#/score-board`.
3. Login as admin via SQL Injection: enter `' OR 1=1--` in the login email field.
4. Confidential document leak: download sensitive files via directory traversal in the FTP assets folder.
5. DOM XSS: Trigger persistent payloads in the customer feedback or search bar.

---

## YouTube Walkthroughs & Solving Guides

- [TryHackMe OWASP Juice Shop - Full Walkthrough](https://www.youtube.com/watch?v=Ju3Wc6S0GhM)
- [Juiceshop - Insecure OWASP Webshop Walkthrough](https://www.youtube.com/watch?v=RYzbA72sbv8)
- [Broken Authentication and SQL Injection | OWASP Juice Shop](https://www.youtube.com/watch?v=W4MXUnZB2jc)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
