# PortSwigger Web Security Academy Lab: JWT Authentication Bypass via `jku` Header Injection

A faithful, Dockerized recreation of the official **PortSwigger Web Security Academy** lab:
**"JWT authentication bypass via jku header injection"**.

---

## 🎯 Lab Objective

> To solve the lab, modify your session token with a `jku` header pointing to your exploit server, access the admin panel at `/admin`, and delete the user `carlos`.

---

## 🌐 Running the Lab

```bash
docker compose up --build -d
```

This launches two interconnected services:

- **Victim Application**: [http://localhost:5000](http://localhost:5000)
- **Exploit Server**: [http://localhost:6000](http://localhost:6000)

---

## 🧭 Web Application Tour

### 1. Victim Portal (`http://localhost:5000`)

- **Live Status Banner**: Displays `LAB UNSOLVED` in real time, switching to `✓ CONGRATULATIONS, YOU SOLVED THE LAB!` with confetti once solved.
- **Storefront / Academy Articles**: Overview of security research and lab objectives.
- **Login (`/login`)**:
  - Test credentials:
    - User: `wiener` / `peter` (or `alice` / `password123`)
    - Target Victim: `carlos` / `montoya`
- **My Account (`/my-account`)**:
  - User details (email, API key, role `user`).
  - **Interactive JWT Inspector**: Color-coded view of Header (orange), Payload (purple), and Signature (cyan), highlighting the `jku` header parameter.
- **Admin Panel (`/admin`)**:
  - Denies access for standard users: `403 Forbidden - Admin interface only available if logged in as an administrator`.
  - Accessible when authenticated as `sub: administrator` / `role: admin`.
  - Contains the user management dashboard with the **"Delete user carlos"** button and CTF Flag.
- **Reset Button**: Easily reset the lab state at any time via the top header button or `POST /api/reset`.

---

### 2. Exploit Server (`http://localhost:6000`)

- **Attacker JWKS Configuration**:
  - One-click **"Generate New RSA Keypair"** button.
  - Live JSON editor serving `/evil-jwks.json`.
- **JWT Token Forger**:
  - Preset with `jku: http://attacker-jwks:6000/evil-jwks.json`, `sub: administrator`, `role: admin`.
  - One-click **"Sign & Forge JWT"** button using the attacker's RSA private key.
- **Exploit Delivery & Log Inspector**:
  - **"Deliver Exploit to Victim"** button automatically calls `/admin/delete?username=carlos`.
  - **"Copy Token"** and **"Copy Browser Console Command"** buttons to set the forged session cookie in your browser and explore `/admin` manually!
  - Real-time **Access Log** showing the victim application fetching keys from `/evil-jwks.json`.

---

## 💻 Solving via CLI

You can also solve the lab using the included exploit script:

```bash
# With python venv active:
python exploit/forge.py
```

Expected output:

```
[*] Generating attacker-controlled RSA keypair...
[*] Forging administrator JWT with malicious jku header...
[*] Accessing http://localhost:5000/admin with forged token (Status: 200)
[*] Deleting target user Carlos via /admin/delete?username=carlos (Status: 200)
============================================================
  CONGRATULATIONS! LAB SOLVED SUCCESSFULLY!
  FLAG: FLAG{jku_header_injection_jwt_auth_bypass}
============================================================
```

---

## 🔍 How the Vulnerability Works

1. A JSON Web Token (JWT) header can specify a `jku` (JWK Set URL) pointing to where the public key for verifying the signature is located.
2. The vulnerable application in `app/app.py` blindly trusts whatever URL is present in the `jku` header:

   ```python
   jku = unverified.get("jku")
   resp = requests.get(jku, timeout=4)  # <-- VULNERABLE: No allow-list check!
   jwk_set = resp.json()
   ```

3. An attacker can host their own JWKS on an exploit server (`http://attacker-jwks:6000/evil-jwks.json`), sign an administrator token with their private key, and set `jku` to their exploit server.
4. The server fetches the attacker's public key, verifies the attacker's signature as valid, and grants full administrator access!

---

## 🛡️ Remediation

1. **Strict URL Allow-listing**: If `jku` must be supported, validate it against an allowlist of trusted domains:

   ```python
   ALLOWED_JKU = ["https://auth.example.com/.well-known/jwks.json"]
   if jku not in ALLOWED_JKU:
       raise PermissionError("Untrusted JKU URL")
   ```

2. **Key Pinning**: Hard-code or pin the public keys server-side and ignore the header's `jku` parameter entirely for internal authentication tokens.
