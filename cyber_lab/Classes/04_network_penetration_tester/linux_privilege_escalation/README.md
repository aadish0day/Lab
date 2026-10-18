# Linux Privilege Escalation Challenge Lab

## Overview

Gain root access on Linux through misconfigured SUID binaries, sudo privileges, cron jobs, and vulnerable kernel components.

- **Default Port / Access**: `Terminal / CLI`
- **Directory**: `Classes/04_network_penetration_tester/linux_privilege_escalation`

---

## How to Solve & Practice

1. Start the container: `docker compose up -d`
2. Access standard user shell: `docker exec -it cyberlab_04_linux_privesc /bin/bash` or `sh`.
3. Run LinPEAS / LinEnum enumeration script inside container: `curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | sh`.
4. Check sudo privileges: `sudo -l`.
5. Search for SUID binaries: `find / -perm -u=s -type f 2>/dev/null` and exploit using GTFOBins techniques.

---

## YouTube Walkthroughs & Solving Guides

- [Linux Privilege Escalation using LinPEAS Script](https://www.youtube.com/watch?v=ktL-ijmx8z0)
- [The Cyber Mentor - Linux Privilege Escalation Walkthrough](https://www.youtube.com/watch?v=vRMrk82Tvtk)
- [John Hammond - Wonderland Linux Privilege Escalation Techniques](https://www.youtube.com/watch?v=thQ3NQ5vpv4)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
