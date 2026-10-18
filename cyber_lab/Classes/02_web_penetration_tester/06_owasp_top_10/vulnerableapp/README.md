# OWASP VulnerableApp: Multi-Tiered Vulnerability Benchmark & Scanner Evaluation

## Overview

OWASP VulnerableApp, authored by SasanLabs under the OWASP umbrella, is a graduated vulnerability testing framework built on Spring Boot. Unlike traditional vulnerable apps designed purely for manual penetration testing, VulnerableApp is built to serve two dual purposes:

1. **Graduated Difficulty Progression**: Every single vulnerability category is implemented across discrete difficulty tiers (Level 1: trivial injection, Level 2: basic filtering, Level 3: regex filter bypass, Level 4: context-aware sanitization, Level 5: secure implementation).
2. **Scanner Scoring Testbed**: Structured endpoints specifically formulated to test the accuracy, false positive rate, and detection limits of automated DAST/SAST scanners (such as OWASP ZAP, Semgrep, and Trivy).

- **Primary Interface**: `http://localhost:8119`
- **Docker Shortcut**: `./lab start vulnerableapp`
- **Container Name**: `cyberlab_02_vulnerableapp`
- **RAM Footprint**: ~650 MB (Spring Boot runtime)

---

## Architecture & Technology Stack

```
+-------------------------------------------------------------+
|                 Client Browser / ZAP / Semgrep              |
+-------------------------------------------------------------+
                               |
                        HTTP Port 8119
                               v
+-------------------------------------------------------------+
|             VulnerableApp Container (Spring Boot)           |
|                                                             |
|  [Spring Web MVC Controller Architecture]                   |
|    - Tiered Vulnerability Facades (Levels 1 to 5)           |
|    - Contextual XSS Engines (HTML, Attribute, Script, Event)|
|    - Multi-Dialect SQL Injection (Raw JDBC, JPA, Hibernate) |
|    - Path Traversal, SSRF & XXE Vulnerability Endpoints     |
|                                                             |
|  [Embedded H2 Relational Database Engine]                   |
|    - In-Memory tables, user credentials, and orders         |
+-------------------------------------------------------------+
```

---

## Graduated Vulnerability Tiers & Attack Scenarios

### 1. Contextual Cross-Site Scripting (XSS)

VulnerableApp categorizes XSS across distinct injection contexts:

- **HTML Body Context**: Untrusted data reflected inside `<div>...</div>`.
- **Attribute Context**: Untrusted data reflected inside `<input value="...">` requiring quote breakout (`" onfocus="alert(1)`).
- **Script Context**: Data placed inside JavaScript variables (`var data = 'USER_INPUT';`), requiring script tag escapes or string literal closure (`'; alert(1); //`).
- **Levels 1 to 4**: Bypassing naive regex filters that replace `<script>` tags (case alteration `<sCrIpt>`, nested tags `<scr<script>ipt>`, or non-script tags `<img src=x onerror=alert(1)>`).

### 2. Multi-ORM SQL Injection (JDBC vs JPA vs Hibernate)

- **Tiered Scenarios**:
  - Level 1: Raw String Concatenation in JDBC statement (`Statement.executeQuery("SELECT ... " + id)`).
  - Level 2: Hibernate HQL injection through named parameters constructed insecurely.
  - Level 3: Blind Boolean and Time-based SQLi against Spring Data JPA repository queries.
- **Attack Walkthrough**:
  Target the user search endpoint at Level 1:
  ```bash
  curl -s "http://localhost:8119/vulnerableapp/sqli/level1?username=admin'+OR+'1'='1"
  ```

### 3. Server-Side Request Forgery (SSRF)

- **Tiered Scenarios**:
  - Level 1: Open HTTP client accepting any URL parameter.
  - Level 2: Blacklist filtering of `127.0.0.1` and `localhost` (bypassed via decimal notation `2130706433`, hex `0x7f000001`, or IPv6 `[::1]`).
  - Level 3: Whitelist domain checking vulnerable to subdomain spoofing or DNS rebinding.

### 4. Automated Scanner Verification Mode

VulnerableApp can be targeted directly with automated tools from `tools/analysis/devsecops-scanners`:

```bash
# Target VulnerableApp with OWASP ZAP baseline scanner
docker run --rm --network host ghcr.io/zaproxy/zaproxy:stable zap-baseline.py \
  -t http://localhost:8119
```

---

## Defensive Remediation & Hardening

1. **Context-Aware Output Encoding**:
   Use Spring / OWASP Java Encoder to encode according to the output sink:
   ```java
   String safeHtml = Encode.forHtml(userInput);
   String safeAttr = Encode.forHtmlAttribute(userInput);
   String safeJs = Encode.forJavaScript(userInput);
   ```
2. **Enforce Prepared Statements**:
   Always utilize parameterized query templates across JDBC, JPA, and Hibernate:
   ```java
   @Query("SELECT u FROM User u WHERE u.username = :username")
   List<User> findByUsername(@Param("username") String username);
   ```

---

## Video Walkthroughs & Technical References

- [OWASP Spotlight - Project 23 - OWASP VulnerableApp](https://www.youtube.com/watch?v=HRRTrnRgMjs)
- [SasanLabs VulnerableApp GitHub Repository](https://github.com/SasanLabs/VulnerableApp)
- [OWASP Secure Coding Practices Quick Reference](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)
