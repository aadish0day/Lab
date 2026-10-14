# DFIR Forensics Suite: Volatility 3, YARA & CyberChef

## Overview
A complete Digital Forensics and Incident Response (DFIR) investigation workspace. Perform deep **RAM memory forensics with Volatility 3**, detect **process hollowing and reflective DLL injection**, execute **in-memory YARA pattern scans**, and deobfuscate multi-layered malware payloads using the browser-based **GCHQ CyberChef** engine.

- **Default Port / Access**:
  - CyberChef GUI: `http://localhost:8106`
  - Volatility 3 CLI: `cyberlab_dfir_volatility`
- **Shared Storage**:
  - Memory Dumps Directory: `Classes/06_vulnerability_management_and_threat_intel/dfir_forensics_suite/dumps`
  - YARA Rules Directory: `Classes/06_vulnerability_management_and_threat_intel/dfir_forensics_suite/rules`
- **Directory**: `Classes/06_vulnerability_management_and_threat_intel/dfir_forensics_suite`

---

## Architecture & Threat Investigation Workflow

```
       [ Suspicious Memory Dump / Raw Artifact (.raw, .vmem) ]
                                   |
         +-------------------------+-------------------------+
         |                                                   |
         v                                                   v
+-----------------------------+               +-----------------------------+
|    Volatility 3 Engine      |               |     GCHQ CyberChef          |
|  - pslist / psscan (hidden) |               |  - Port 8106 (Web Browser)  |
|  - malfind (injected code)  |               |  - Base64 / XOR decoding    |
|  - vadinfo / dlllist        |               |  - Gunzip / Deflate inflate |
|  - yarascan (YARA matching) |               |  - PowerShell deobfuscation |
+-----------------------------+               +-----------------------------+
```

### Core DFIR Concepts:
1. **Process Discovery (`pslist` vs `psscan`)**:
   - `windows.pslist`: Walks the active `ActiveProcessLinks` doubly-linked list.
   - `windows.psscan`: Scans raw memory pool tags for unlinked `EPROCESS` structures. Discrepancies reveal rootkits attempting process hiding.
2. **Detecting Injected Code (`malfind`)**:
   - Searches Virtual Address Descriptors (VAD) for memory regions marked `PAGE_EXECUTE_READWRITE` (`PAGE_X_RW`) that are not backed by any file on disk. This is the primary indicator of shellcode injection, reflective DLL loading, or process hollowing.
3. **In-Memory YARA Scanning (`vadyarascan`)**:
   - Compiles YARA signatures and matches them directly against process virtual memory space without extracting the entire process to disk.
4. **CyberChef Payload Deobfuscation**:
   - The Swiss Army Knife of data analysis. Quickly chain operations (From Base64, Remove null bytes, Decode text UTF-16LE, XOR with key, Gunzip) to uncover C2 domains, IP addresses, and embedded shellcode.

---

## How to Solve & Practice

### 1. Start the DFIR Suite
```bash
docker compose up -d
```
Open `http://localhost:8106` in your browser to access the CyberChef UI.

### 2. Practice Memory Forensics with Volatility 3
Place a Windows RAM dump (e.g. `memory.dmp` or `.raw`) into `./dumps`:

#### A. List Active & Hidden Processes:
```bash
# Standard process tree
docker exec -it cyberlab_dfir_volatility vol -f /dumps/memory.dmp windows.pstree

# Search for unlinked/hidden processes
docker exec -it cyberlab_dfir_volatility vol -f /dumps/memory.dmp windows.psscan
```

#### B. Hunt for Injected Code & Process Hollowing (`malfind`):
```bash
docker exec -it cyberlab_dfir_volatility vol -f /dumps/memory.dmp windows.malfind
```
Look for output blocks containing:
- Protection: `PAGE_EXECUTE_READWRITE`
- Hex dump starting with `4d 5a` (`MZ` header) or typical shellcode bytes (`fc e8 ...`).

#### C. Inspect Loaded DLLs and Network Sockets:
```bash
# Check loaded modules for suspicious process PID
docker exec -it cyberlab_dfir_volatility vol -f /dumps/memory.dmp windows.dlllist --pid <PID>

# Check active C2 connections associated with the process
docker exec -it cyberlab_dfir_volatility vol -f /dumps/memory.dmp windows.netscan
```

### 3. Scan Memory Using YARA Signatures
Use the pre-configured rules in `/rules` or write custom signatures:
```bash
docker exec -it cyberlab_dfir_volatility vol -f /dumps/memory.dmp windows.vadyarascan --yara-file /rules/detect_injection.yar
```

### 4. Payload Deobfuscation in CyberChef (Port 8106)
Navigate to `http://localhost:8106`.

#### Example Challenge: Deobfuscating Malicious PowerShell Command
Given an obfuscated PowerShell dropper string:
```
JABzAD0ATgBlAHcALQBPAGIAagBlAGMAdAAgAEkATwAuAE0AZQBtAG8AcgB5AFMAdAByAGUAYQBtACgAWwBDAG8AbgB2AGUAcgB0AF0AOgA6AEYAcgBvAG0AQgBhAHMAZQA2ADQAUwB0AHIAaQBuAGcAKAAiSDA0c0lBQ04vY3drQ0FBUzVzNFR5Y1d2b0R3QUEiKSk=
```
**Recipe in CyberChef**:
1. Drag **From Base64** into the Recipe pane.
2. Drag **Decode text** (Encoding: `UTF-16LE (1200)`) to resolve Windows PowerShell Unicode strings.
3. Observe the inner base64 payload and apply **Gunzip** / **Decompress** to reveal the C2 IP address and beacon configuration!

---

## YouTube Walkthroughs & Solving Guides

- [DFIRScience - Introduction to Memory Forensics with Volatility 3](https://www.youtube.com/watch?v=Uk3DEgY5Ue8)
- [Taylor Walton - Volatility 3 Will Change How You Hunt Malware (Full Tutorial)](https://www.youtube.com/watch?v=R1X8V9yy_Y4)
- [Embee Research - Advanced CyberChef Operations for Malware Analysis and Deobfuscation](https://www.youtube.com/watch?v=CIg4TXFJRK0)
- [Chris Sanders - CyberChef Course Sample Video: The Power of CyberChef](https://www.youtube.com/watch?v=tOCIc2R_xmU)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
