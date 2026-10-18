# MITRE Caldera: Cyber Adversary Emulation Platform

## Overview

Automated adversary emulation platform built directly on the **MITRE ATT&CK® framework**. Caldera enables security teams, red teams, and purple teams to systematically test enterprise defenses, validate SIEM/EDR detection rules, and emulate realistic advanced persistent threat (APT) campaigns using intelligent software agents.

- **Default Port / Access**: `http://localhost:8888`
- **Default Credentials**:
  - Red Operator: `red` / `admin`
  - Blue Defender: `blue` / `admin`
  - Administrator: `admin` / `admin`
- **Agent C2 Contacts**:
  - HTTP Beacon: `http://localhost:8888`
  - TCP Contact: Port `7010`
  - UDP Contact: Port `7011`
  - WebSocket Contact: Port `7012`
- **Directory**: `Real_World_Industry_Labs/09_c2_adversary_emulation/mitre_caldera`

---

## Architecture & Core Concepts

```
       +--------------------------------------------------------+
       |                  MITRE CALDERA CORE                    |
       |  Web UI (8888) | REST API | Planners | Stockpile Repo  |
       +---------------------------+----------------------------+
                                   | C2 Beaconing (HTTP/TCP/WS)
             +---------------------+---------------------+
             |                                           |
             v                                           v
   +-------------------+                       +-------------------+
   | Target Machine 1  |                       | Target Machine 2  |
   | Sandcat (54ndc47) |                       | Sandcat (54ndc47) |
   | T1082 / T1059.004 |                       | T1016 / T1033     |
   +-------------------+                       +-------------------+
```

1. **Abilities**: Atomic implementation of a specific ATT&CK technique (e.g., `T1082 - System Information Discovery`). Each ability contains platform-specific payloads (bash, sh, PowerShell, cmd) and cleanup instructions.
2. **Adversary Profiles**: Curated collections of abilities sequenced to mimic known threat actors (e.g., APT29, FIN6, Hunter, Discovery).
3. **Sandcat Agent (`54ndc47`)**: The default cross-platform compiled Go agent that runs on targets, sends periodic heartbeat beacons to Caldera, downloads tasking, executes commands, and ships stdout/stderr back.
4. **Operations**: Coordinated execution campaigns linking an Adversary Profile, targeted Agent groups, an autonomous execution Planner (e.g., atomic, batch, bucket), and automated fact-collection logic.

---

## How to Solve & Practice

### 1. Launch Caldera

```bash
docker compose up -d
```

Navigate to `http://localhost:8888` in your browser and log in with username `red` and password `admin`.

### 2. Deploy a Sandcat Agent (`54ndc47`)

In the Caldera navigation bar:

1. Navigate to **Agents** -> **Deploy an Agent**.
2. Select `sandcat (54ndc47)`.
3. Choose the target operating system (e.g., `Linux`).
4. Set the **App app.contact.http** field to `http://127.0.0.1:8888` (or your host IP).
5. Copy the generated deployment one-liner and execute it in a terminal on the target system:
   ```bash
   server="http://127.0.0.1:8888"; \
   curl -s -X POST -H "file:sandcat.go" "$server/file/download" > /tmp/sandcat; \
   chmod +x /tmp/sandcat; \
   /tmp/sandcat -server "$server" -group red
   ```
6. Return to **Agents** in the web dashboard; you will see the active agent reporting its PID, hostname, privilege level, and heartbeat interval.

### 3. Explore Abilities & Adversary Profiles

- Click on **Profiles** in the left sidebar.
- Inspect the built-in **Discovery** profile: notice how techniques map directly to ATT&CK tactics (Reconnaissance, Discovery, Execution).
- Clone or create a new profile called `Lab-Discovery-Test` and add:
  - `Identify active users` (T1033)
  - `View network configuration` (T1016)
  - `System Information Discovery` (T1082)

### 4. Launch an Autonomous Operation

1. Click on **Operations** -> **Create Operation**.
2. Enter an operation name: `OP-EVAL-01`.
3. Select the **Adversary**: `Lab-Discovery-Test` (or `Discovery`).
4. Select the **Agent Group**: `red`.
5. Under **Autonomous**, select `Run autonomously` with the `atomic` or `batch` planner.
6. Check **Auto-cleanup** to ensure commands revert modifications upon completion.
7. Click **Start**.

### 5. Monitor and Analyze Results

- Watch the live operation graph execute abilities sequentially.
- Click on completed steps (green nodes) to inspect:
  - Executed payload string.
  - Standard output and exit codes.
  - Learned facts (e.g., hostnames, network interfaces, usernames) automatically parsed into Caldera's fact store.
- Download the generated ATT&CK Coverage layer JSON and visualize it in the [ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/).

---

## YouTube Walkthroughs & Solving Guides

- [HackerSploit - Red Team Adversary Emulation With Caldera](https://www.youtube.com/watch?v=EIHLXWnK1Dw)
- [MyDFIR - Cybersecurity Tool - Caldera (Red & Blue Team)](https://www.youtube.com/watch?v=Z9QdgD8dG24)
- [The MITRE Corporation - CALDERA Tutorial & Operation Planning](https://www.youtube.com/watch?v=GukTj-i3UDg)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
