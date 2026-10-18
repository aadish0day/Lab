# IoT & Embedded Firmware Reverse Engineering Lab

## Overview

Extract, unpack, and analyze embedded router/camera firmware images with `binwalk`, find backdoors, and emulate MIPS/ARM binaries.

- **Default Port / Access**: `Terminal / CLI`
- **Directory**: `Real_World_Industry_Labs/10_iot_firmware_hardware_hacking/firmadyne_emulation`

---

## How to Solve & Practice

1. Start the analysis container: `docker compose up -d`
2. Enter container shell: `docker exec -it cyberlab_realworld_iot_firmware bash`.
3. Install extraction tools: `apt update && apt install -y binwalk qemu-user-static squashfs-tools`.
4. Download sample vendor firmware (e.g. D-Link / TP-Link router bin).
5. Extract filesystem: `binwalk -eM firmware.bin`.
6. Search for backdoors and hardcoded credentials in `/etc/shadow`, `/etc/passwd`, and `/www` web directories.

---

## YouTube Walkthroughs & Solving Guides

- [Firmware Hacking: Simple Extraction with binwalk](https://www.youtube.com/watch?v=atOJFVQmY1Q)
- [How Hackers Reverse Engineer Firmware (Binwalk Tutorial)](https://www.youtube.com/watch?v=D2KEQH0dR-I)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
