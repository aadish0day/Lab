# Active Directory & LDAP Enumeration Lab

## Overview

Lightweight containerized LDAP server (GLAuth) configured with domain accounts, groups, and service users for enumeration practice.

- **Default Port / Access**: `3893`
- **Directory**: `Classes/04_network_penetration_tester/active_directory_goad_ldap`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d`
2. Perform anonymous LDAP bind and search: `ldapsearch -H ldap://localhost:3893 -x -b "dc=lab,dc=local" "(objectclass=*)"`
3. Enumerate domain users and service accounts (`svc_sql`, `administrator`).
4. Run password spraying attacks against domain accounts using Hydra or CrackMapExec/NetExec.
5. Practice Kerberoasting and AS-REP roasting fundamentals (see README for full GOAD setup).

---

## YouTube Walkthroughs & Solving Guides

- [Breaching Game Of Active Directory (GOAD) Part 1](https://www.youtube.com/watch?v=zqiSAap3QDs)
- [Game Of Active Directory - Attack and Detect AD Attacks](https://www.youtube.com/watch?v=XjgxQ6gHfyU)
- [How To Install Game Of Active Directory with Elastic EDR](https://www.youtube.com/watch?v=96UzSrie_r8)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
