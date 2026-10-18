# PortSwigger Web Security Academy: Progression Roadmap (Easy to Very Hard)

This roadmap maps every PortSwigger Web Security Academy topic directly to offline Docker labs in your `cyber_lab` repository, organized strictly by progressive difficulty levels (**Apprentice / Practitioner / Expert**).

---

## 1. SQL Injection (`./lab start sqli` | Port 8086 & `./lab start juice-shop` | Port 3000)

- ** Easy (Apprentice)**:
- **Lab target**: SQLi-Labs Less 1-4 / Juice Shop Admin Login.
- **Techniques**: Error-based UNION injection, string concatenation, retrieving hidden data (`' OR 1=1--`).
- **Goal**: Bypass authentication and determine column count with `ORDER BY`.
- ** Medium (Practitioner)**:
- **Lab target**: SQLi-Labs Less 5-10 & Less 11-17 (POST/Header Injection).
- **Techniques**: Double query injection (`floor(rand(0)*2)`), Boolean-blind differential extraction, User-Agent & Cookie SQLi.
- **Goal**: Extract database schema and password hashes without inline query output.
- ** Hard (Expert)**:
- **Lab target**: SQLi-Labs Less 23-38 (Filter Bypasses) & Less 54-65 (Challenge Series).
- **Techniques**: Time-based blind injection with conditional delays (`IF(..., sleep(5), 0)`), WAF space/comment bypasses (`%a0`, `/*!UNION*/`), and second-order SQL injection.
- **Goal**: Sub-second automated extraction under strict character blacklists.

---

## 2. Client-Side Attacks: XSS, CSRF, CORS & Clickjacking (`./lab start client-bwapp` | Port 8085)

- ** Easy (Apprentice)**:
- **Lab target**: bWAPP (Security: Low) -> HTML Injection / Reflected XSS / Clickjacking.
- **Techniques**: Unencoded query parameters, iframe overlay with low opacity, GET-based CSRF without tokens.
- **Goal**: Pop `alert(document.domain)` and submit unauthorized profile changes.
- ** Medium (Practitioner)**:
- **Lab target**: bWAPP (Security: Medium) & Juice Shop (DOM XSS).
- **Techniques**: Stored XSS with filter bypass (`<img src=x onerror=...>`, uppercase variations), DOM-based sinks (`innerHTML`, `document.write`), CORS misconfigurations (`Access-Control-Allow-Origin: *` with credentials).
- **Goal**: Steal session cookies, hijack CORS authenticated responses, and bypass CSRF token validation when token is omitted.
- ** Hard (Expert)**:
- **Lab target**: bWAPP (Security: High) & `./lab start prototype-pollution` (Port 8096).
- **Techniques**: Content Security Policy (CSP) bypass via script gadgets/JSONP, DOM clobbering, and client-to-server prototype pollution.
- **Goal**: Exfiltrate CSRF-protected admin tokens via full DOM gadget exploitation.

---

## 3. Server-Side Template Injection (SSTI) (`./lab start ssti` | Port 8094)

- ** Easy (Apprentice)**:
- **Lab target**: SSTI Flask Target (`http://localhost:8094`).
- **Techniques**: Polyglot template detection: `${7*7}`, `{{7*7}}`, `<%= 7*7 %>`.
- **Goal**: Identify whether the engine is Jinja2, Twig, or Mako based on arithmetic reflection.
- ** Medium (Practitioner)**:
- **Lab target**: SSTI Flask Target.
- **Techniques**: Inspecting object properties: `{{ self.__class__ }}`, `{{ config.items() }}`.
- **Goal**: Read internal application secrets, secret keys, and configuration environment variables.
- ** Hard (Expert)**:
- **Lab target**: SSTI Flask Target.
- **Techniques**: Python MRO traversal and subclass indexing:
  `{{ ''.__class__.__mro__[1].__subclasses__() }}` -> locate `subprocess.Popen` or `warnings.catch_warnings` to invoke `os.popen`.
- **Goal**: Weaponize template evaluation into full unconstrained Remote Code Execution (RCE) on the server.

---

## 4. File Upload & Command Attacks (`./lab start uploads-lfi` | Port 8087)

- ** Easy (Apprentice)**:
- **Lab target**: DVWA (Security: Low) -> File Upload.
- **Techniques**: Uploading raw `.php` web shell without server-side validation.
- **Goal**: Direct code execution via `http://localhost:8087/hackable/uploads/shell.php?cmd=id`.
- ** Medium (Practitioner)**:
- **Lab target**: DVWA (Security: Medium) -> File Upload & LFI.
- **Techniques**: Bypassing client-side validation, tampering with `Content-Type: image/jpeg`, using alternate extensions (`.phtml`, `.php5`), null byte injections (`%00`), and path traversal via LFI wrappers (`php://filter`).
- **Goal**: Execute code when direct `.php` uploads are prohibited.
- ** Hard (Expert)**:
- **Lab target**: DVWA (Security: High / Impossible) & Polyglot Webshells.
- **Techniques**: Creating polyglot files (valid JPEG headers `\xFF\xD8\xFF\xE0` containing embedded PHP payloads), bypassing `exif_imagetype()`, and race conditions during temporary file upload processing.
- **Goal**: Achieve arbitrary code execution on hardened upload engines that re-encode image buffers.

---

## 5. Race Conditions & Concurrency (`./lab start race-condition` | Port 8097)

- ** Easy (Apprentice)**:
- **Lab target**: Race Challenge (`http://localhost:8097`).
- **Techniques**: Understanding single-threaded execution vs multi-threaded redemption logic.
- **Goal**: Trigger normal single coupon consumption (`1/1 redeemed`).
- ** Medium (Practitioner)**:
- **Lab target**: Race Challenge with Burp Suite Turbo Intruder / Python script.
- **Techniques**: Sending 20–30 simultaneous requests using HTTP/1.1 pipelining or single-packet synchronization.
- **Goal**: Exploit Limit Overrun (Time-of-Check to Time-of-Use / TOCTOU) to redeem the coupon multiple times in the race window.
- ** Hard (Expert)**:
- **Lab target**: Multi-endpoint and multi-state race conditions (OAuth state reuse, transfer balance races, 2FA bypass races).
- **Techniques**: Aligning sub-millisecond execution windows with single-packet attack (HTTP/2 last-byte synchronization).
- **Goal**: Bypassing business logic and state validation across distributed microservices.

---

## 6. Prototype Pollution (`./lab start prototype-pollution` | Port 8096)

- ** Easy (Apprentice)**:
- **Lab target**: Node Prototype Target (`http://localhost:8096`).
- **Techniques**: Inspecting JSON endpoints and understanding JavaScript prototype inheritance.
- **Goal**: Identify recursive merge / clone functions (`_.merge`, `Object.assign`).
- ** Medium (Practitioner)**:
- **Lab target**: Node Prototype Target.
- **Techniques**: Polluting `Object.prototype` via `__proto__`:
  `{"__proto__": {"admin": true}}`.
- **Goal**: Elevate privileges application-wide and unlock the protected Admin Flag.
- ** Hard (Expert)**:
- **Lab target**: Server-Side Prototype Pollution (SSPP) to RCE.
- **Techniques**: Polluting child process options (`NODE_OPTIONS`, `shell`, `execArgv`) or template engine options (EJS/Pug prototype gadgets).
- **Goal**: Convert an in-memory prototype modification into remote system command execution.

---

## 7. Insecure Deserialization (`./lab start deserialization` | Port 8095)

- ** Easy (Apprentice)**:
- **Lab target**: CVE-2014-6271 & PHP Serialization targets.
- **Techniques**: Modifying serialized data attributes (e.g. `O:4:"User":2:{s:4:"name";s:5:"admin";s:7:"isAdmin";b:1;}`).
- **Goal**: Privilege escalation via direct tampering of serialized cookies.
- ** Medium (Practitioner)**:
- **Lab target**: PHP Object Injection & Python Pickle payloads.
- **Techniques**: Triggering magic methods (`__wakeup`, `__destruct`, `__toString`) and Python `__reduce__` shell execution.
- **Goal**: Arbitrary file creation/deletion through native object lifecycles.
- ** Hard (Expert)**:
- **Lab target**: Java Deserialization & PHPGGC Gadget Chains.
- **Techniques**: Generating ysoserial gadget chains (CommonsCollections / Spring) against raw binary serialized streams (`rO0AB...`).
- **Goal**: Remote Code Execution without application source code via third-party classpath dependencies.

---

## 8. Authentication & Access Control (`./lab start auth` | Port 8084 & `./lab start oauth-keycloak` | Port 8093)

- ** Easy (Apprentice)**:
- **Lab target**: Auth Lab (`http://localhost:8084`).
- **Techniques**: Insecure Direct Object References (IDOR): changing `?user_id=1` to `?user_id=2`, username enumeration via error responses.
- **Goal**: Access other users' profiles and confirm valid account names through response timings.
- ** Medium (Practitioner)**:
- **Lab target**: Auth Lab & Keycloak SSO.
- **Techniques**: 2FA bypass via broken logic (direct URL navigation), password reset token leakage in Referer headers, OAuth redirect URI manipulation.
- **Goal**: Hijack OAuth authorization codes and take over accounts without passwords.
- ** Hard (Expert)**:
- **Lab target**: Keycloak SSO & JWT Lab (`./lab start jwt`).
- **Techniques**: JWT `none` algorithm, signature stripping, JWK header injection, CVE-2023 OAuth IDOR race conditions, and SAML XML signature wrapping.
- **Goal**: Forge arbitrary administrative tokens valid across enterprise identity providers.

---

## 9. API Security: REST & GraphQL (`./lab start vampi` | Port 5000 & `./lab start dvga` | Port 5013)

- ** Easy (Apprentice)**:
- **Lab target**: VAmPI (REST API) & DVGA (GraphQL).
- **Techniques**: Endpoint enumeration via Swagger/OpenAPI docs (`/docs`, `/api/swagger.json`), GraphQL introspection query extraction.
- **Goal**: Map complete schema, queries, and mutations without authentication.
- ** Medium (Practitioner)**:
- **Lab target**: VAmPI & crAPI (`./lab start crapi` | Ports 8888, 8025).
- **Techniques**: Broken Object Level Authorization (BOLA/IDOR), Broken Object Property Level Authorization (Mass Assignment), GraphQL alias batching.
- **Goal**: Overwrite user objects with admin attributes (`"is_admin": true`) and bypass rate limits with aliases.
- ** Hard (Expert)**:
- **Lab target**: DVGA & crAPI.
- **Techniques**: GraphQL Circular Query Resource Exhaustion (DoS), Server-Side Request Forgery via webhooks/PDF generators, and JWT secret cracking via public APIs.
- **Goal**: Crash backend GraphQL engines and recover database credentials through microservice interaction.
