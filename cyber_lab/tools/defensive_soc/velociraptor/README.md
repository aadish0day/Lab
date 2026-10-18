# Velociraptor Live Endpoint Triage & Digital Forensics Suite

## Overview

Perform enterprise-scale digital forensics, live endpoint visibility, and proactive threat hunting using **Velociraptor**. Rather than copying entire disk images over slow networks, Velociraptor queries endpoints directly using the declarative **Velociraptor Query Language (VQL)**. Rapidly hunt for persistence mechanisms, extract forensic artifacts ($MFT, Shimcache, Amcache, Windows Event Logs, systemd units), execute memory YARA scans, and collect forensic triage packages in minutes.

- **Default Port / Access**:
  - Velociraptor Web GUI: `https://localhost:8114` (HTTPS with self-signed certificate; accept browser warning)
  - Default Credentials:
    - Username: `admin`
    - Password: `admin`
  - Container Name: `cyberlab_velociraptor`
- **Shared Storage**:
  - Configuration: `Classes/06_vulnerability_management_and_threat_intel/velociraptor_endpoint_triage/config`
  - Data Store: `Classes/06_vulnerability_management_and_threat_intel/velociraptor_endpoint_triage/datastore`
  - Custom Artifacts: `Classes/06_vulnerability_management_and_threat_intel/velociraptor_endpoint_triage/custom_artifacts`
- **Directory**: `Classes/06_vulnerability_management_and_threat_intel/velociraptor_endpoint_triage`

---

## Endpoint Forensics Architecture & Flow

```
                      [ Velociraptor Web GUI ]
                       https://localhost:8114
                                 |
                                 v
                 +-------------------------------+
                 |      Velociraptor Server      |
                 |     (cyberlab_velociraptor)   |
                 | - VQL Artifact Repository     |
                 | - Hunt Dispatch & Scheduling  |
                 | - File Vault & Crypto Store   |
                 +---------------+---------------+
                                 |
                 gRPC / TLS Encrypted Communications (Port 8000)
                                 |
        +------------------------+------------------------+
        |                                                 |
        v                                                 v
+-----------------------------+             +-----------------------------+
|    Linux Target Endpoint    |             |   Windows Target Endpoint   |
| - systemd & cron persistence|             | - $MFT & USN Journal parser |
| - proc memory YARA scanner  |             | - Shimcache / Amcache exec  |
| - /var/log auth & bash_hist |             | - Autoruns & Scheduled Tasks|
+-----------------------------+             +-----------------------------+
```

---

## Velociraptor Query Language (VQL) Deep Dive

VQL is an expressive SQL-like query language that treats operating system components (processes, file systems, registry keys, raw disk sectors, memory buffers) as virtual tables.

### Basic VQL Syntax Structure:

```sql
SELECT Column1, Column2, Function(Column3) AS Alias
FROM PluginName(Param1=Value1, Param2=Value2)
WHERE Condition
ORDER BY Column1
LIMIT 50
```

### Key VQL Constructs:

1. **`LET` Expressions**: Define variables, subqueries, or reusable statement blocks:
   ```sql
   LET SuspectHashes = ("d41d8cd98f00b204e9800998ecf8427e", "e3b0c44298fc1c149afbf4c8996fb924")
   ```
2. **Plugins as Data Sources**:
   - `glob()`: Match file paths using filesystem wildcards.
   - `pslist()`: Enumerate live process identifiers, parent PIDs, command lines, and binary hashes.
   - `parse_evtx()`: Stream and filter Windows binary event logs.
   - `yara()`: Scan files or raw process virtual memory against YARA signature rules.
   - `upload()`: Securely upload collected artifacts or memory slices to the central server.

---

## Threat Hunting & Artifact Collection Modules

### 1. Persistence Hunting

Adversaries maintain survivability across system reboots by establishing persistence hooks:

- **Windows Autoruns & Run Keys**:
  - Artifact: `Windows.Sys.Autoruns`
  - Scans `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`, Startup folders, Winlogon, and browser helper objects.
- **Windows Scheduled Tasks**:
  - Artifact: `Windows.System.TaskScheduler`
  - Parses XML task definitions in `C:\Windows\System32\Tasks` to identify suspicious binaries running with `SYSTEM` privileges.
- **Linux systemd & Cron Persistence**:
  - Artifact: `Linux.Persistence.Systemd` and `Linux.Cron`
  - Inspects `/etc/systemd/system/`, `/lib/systemd/system/`, `/etc/cron*`, and `/var/spool/cron/crontabs/` for anomalous executables or netcat/bash reverse shells.

### 2. Evidence of Execution & Timelining ($MFT, Shimcache, Event Logs)

- **$MFT (Master File Table) Analysis**:
  - Artifact: `Windows.NTFS.MFT`
  - Parses the raw NTFS `$MFT` directly via low-level disk access to recover deleted files, identify timestomping ($STANDARD_INFORMATION vs $FILE_NAME timestamps), and map attacker staging directories.
- **Shimcache (AppCompatCache) & Amcache**:
  - Artifact: `Windows.Registry.Shimcache` / `Windows.System.Amcache`
  - Reconstructs historical evidence of executed binaries even if the attacker deleted the executable from disk before triage.
- **Security Event Log Auditing**:
  - Artifact: `Windows.EventLogs.Security`
  - Hunts for Event ID **4624** (Successful Logon / Type 10 RDP, Type 3 Network), Event ID **4672** (Special Privileges Assigned), and Event ID **4688** (Process Creation with full CLI arguments).

### 3. In-Memory YARA Threat Hunting

Detect fileless malware, reflective DLL injection, and Cobalt Strike / Sliver beacons injected into memory:

- Artifact: `Generic.Detection.YARA.Process`
- Executes memory scans across running processes matching specified hex strings, regexes, or compiled YARA rules without suspending system operations.

---

## How to Solve & Practice

### 1. Launch the Velociraptor Server

```bash
docker compose up -d
```

Verify the container is healthy:

```bash
docker ps --filter "name=cyberlab_velociraptor"
```

### 2. Access the Web Management Console

1. Open your browser and navigate to:
   ```
   https://localhost:8114
   ```
2. Accept the self-signed TLS certificate warning.
3. Authenticate with:
   - **Username**: `admin`
   - **Password**: `admin`

### 3. Run VQL Queries in the Server Notebook

1. In the left navigation menu, click **Notebooks**.
2. Create a new notebook titled `Triage Investigation 01`.
3. Add a VQL query cell and execute:
   ```sql
   /* Enumerate active processes and their binary hashes */
   SELECT Pid, Ppid, Name, CommandLine, Exe,
          hash(file=Exe) AS Hashes
   FROM pslist()
   LIMIT 20
   ```
4. Click **Save** to view the live tabular results.

### 4. Create and Dispatch a Threat Hunt

1. Navigate to **Hunt Manager** in the left sidebar.
2. Click the **+ (New Hunt)** icon.
3. Provide a Hunt description (e.g. `Hunt for Suspicious systemd services`).
4. Select the artifact: `Linux.Sys.Services` or `Custom.Linux.Persistence.SystemdServices`.
5. Configure hunt parameters (e.g. specify path globs).
6. Click **Launch Hunt** and view results streamed in real-time as endpoints respond.

### 5. Execute VQL Directly from CLI

Query endpoint state directly using the CLI binary inside the container:

```bash
# Query active listening network sockets
docker exec -it cyberlab_velociraptor velociraptor query \
  "SELECT Pid, Name, Family, Type, Laddr, Raddr, Status FROM netstat() WHERE Status = 'LISTEN'"

# Enumerate users on the system
docker exec -it cyberlab_velociraptor velociraptor query \
  "SELECT Name, Uid, Gid, Directory, Shell FROM users()"

# Search for SUID root binaries on Linux
docker exec -it cyberlab_velociraptor velociraptor query \
  "SELECT OSPath, Mode, Size, Mtime FROM glob(globs='/usr/bin/**') WHERE Mode =~ '-rws' LIMIT 15"
```

---

## YouTube Walkthroughs & Solving Guides

- [BasisTech - Velociraptor: Dig Deeper with Mike Cohen [OSDFCon 2021]](https://www.youtube.com/watch?v=8AQFNAICajE)
- [Hank Hackerson - SOC Lvl 1 / EP.43 / VELOCIRAPTOR: Threat Hunting Using Velociraptor](https://www.youtube.com/watch?v=U9pLUVYq7Eo)
- [Velocidex Enterprises - Topic 04 Forensic Analysis Pt 1](https://www.youtube.com/watch?v=SD1_Ev-JqCs)
- [Velocidex Enterprises - Topic 03 VQL Fundamentals Pt 2](https://www.youtube.com/watch?v=tsmb_CuLVlE)
- [Black Hills Information Security - Rapid Windows Endpoint Investigations with Velociraptor & KAPE w/ Patterson](https://www.youtube.com/watch?v=rqEjxZph96c)
- [DFIRScience - Starting with Velociraptor Incident Response](https://www.youtube.com/watch?v=EA40rztSOd4)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Open bash inside the Velociraptor server container
docker exec -it cyberlab_velociraptor /bin/bash

# Stop this lab
docker compose down
```
