# Container Breakout, Kubernetes & Cloud Metadata Lab

## Overview

Break out of isolated containers onto the underlying host VM by exploiting privileged flags, mounted Docker sockets, and Linux capabilities.

- **Default Port / Access**: `Terminal / CLI`
- **Directory**: `Real_World_Industry_Labs/02_cloud_k8s_container_escape/badrobot_k8s_escape`

---

## How to Solve & Practice

> [!NOTE]
> **Safety Design**: To prevent accidental damage or exposure to your host machine's root filesystem, this lab mounts an isolated `./sandbox:/sandbox` directory rather than the operator's raw host root (`/`). This safely simulates container escape and host filesystem inspection without danger to the host.

1. Start the container:
   ```bash
   docker compose up -d
   ```
2. Enter container shell:
   ```bash
   docker exec -it cyberlab_realworld_container_escape sh
   ```
3. Check privileges & capabilities:
   ```bash
   # Check effective Linux capabilities (note CAP_SYS_ADMIN and full permit mask)
   cat /proc/1/status | grep Cap
   ```
4. Safe Host Escape Simulation:
   - Inspect the simulated host filesystem mounted safely at `/sandbox`:
     ```bash
     ls -la /sandbox
     cat /sandbox/flag.txt
     ```
   - In real-world enterprise environments, attackers with `CAP_SYS_ADMIN` or `--privileged` exploit raw host block devices (e.g. `mkdir -p /mnt/host && mount /dev/sda1 /mnt/host`) or abuse `cgroups v1 release_agent` notification scripts to execute arbitrary commands outside the container boundary. Here, `/sandbox` provides a secure testbed to simulate post-breakout inspection.

---

## YouTube Walkthroughs & Solving Guides

- [John Hammond - Docker Containers: How Hackers Can ESCAPE Them in Seconds](https://www.youtube.com/watch?v=giXlSlFLKwA)
- [AppSecEngineer - Docker Privilege Escalation: Breaking Out of Containers](https://www.youtube.com/watch?v=WEiCTxaHw5k)
- [David Bombal - How to Exploit Docker Containers with a Volume Mount Attack](https://www.youtube.com/watch?v=bHAdqnaRX0s)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
