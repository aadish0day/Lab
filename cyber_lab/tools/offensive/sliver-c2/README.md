# Sliver C2: Modern Adversary Emulation Framework

## Overview

Professional Red Team Command & Control (C2) operations using BishopFox Sliver: Malleable HTTP beacons, process injection, and EDR evasion.

- **Default Port / Access**: `8889, 31337`
- **Directory**: `Real_World_Industry_Labs/09_c2_adversary_emulation/mythic_c2_framework`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d`
2. Enter the Sliver interactive server console: `docker exec -it cyberlab_realworld_sliver_c2 sliver-server`.
3. Generate an implant for target architecture: `generate --http 127.0.0.1:8889 --save /tmp/implant.bin`.
4. Start an HTTP listener: `http`.
5. Execute implant on target system and interact with incoming session: `sessions -i <ID>`.

---

## YouTube Walkthroughs & Solving Guides

- [Sliver C2 Framework Tutorial: Installation to Post-Exploitation](https://www.youtube.com/watch?v=i_rPATPFi4M)
- [John Hammond - How Hackers Use netsh.exe For Persistence & Code Execution (Sliver C2)](https://www.youtube.com/watch?v=lMihdys4jw8)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
