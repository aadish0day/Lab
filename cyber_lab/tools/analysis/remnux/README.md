# REMnux Static Malware Analysis & Reverse Engineering Toolkit

## Overview
Perform static triage, capability identification, and binary reverse engineering using **REMnux** (the premier Linux toolkit curated by Lenny Zeltser and utilized in the **SANS FOR610: Reverse-Engineering Malware** curriculum). Safely analyze untrusted executables, malicious documents, scripts, and packed payloads in an isolated, dependency-complete Linux container environment without contaminating your host operating system.

- **Default Access**:
  - Interactive Terminal: `docker exec -it cyberlab_remnux bash`
  - Container Name: `cyberlab_remnux`
- **Shared Storage**:
  - Shared Samples Directory: `Classes/05_exploit_writing/remnux_malware_analysis/samples`
  - Container Working Directory: `/home/remnux/files`
- **Directory**: `Classes/05_exploit_writing/remnux_malware_analysis`

---

## Static Malware Analysis Workflow & Pipeline

```
                       [ Untrusted Sample / Binary ]
                                     |
                                     v
                      +------------------------------+
                      |   1. File Typing & Packing   |
                      |   - file, diec (Detect It    |
                      |     Easy), exiftool          |
                      +--------------+---------------+
                                     |
                                     v
                      +------------------------------+
                      | 2. Header & PE Structure     |
                      |   - pefile, readpe, pescan   |
                      |   - Sections, Imports, IAT   |
                      +--------------+---------------+
                                     |
                                     v
                      +------------------------------+
                      | 3. String Deobfuscation      |
                      |   - FLARE floss (decodes     |
                      |     tight strings & stack)   |
                      +--------------+---------------+
                                     |
                                     v
                      +------------------------------+
                      | 4. Capability Mapping        |
                      |   - Mandiant capa (ATT&CK    |
                      |     tactics & MBC mapping)   |
                      +--------------+---------------+
                                     |
                                     v
                      +------------------------------+
                      | 5. Document & Script Triage  |
                      |   - olevba, oledump, pdfid   |
                      +------------------------------+
```

---

## SANS FOR610 Core Tooling Reference

### 1. File Classification & Packing Detection (`diec`, `file`, `manalyze`)
- **`diec` (Detect It Easy CLI)**: Identifies file architectures, compilers (MSVC, GCC, Delphi, Go), linkers, crypters, and packers (UPX, Themida, VMProtect). Also calculates entropy per section (`.text`, `.data`, `.rsrc`): high entropy (> 7.0) indicates encryption or compression.
  ```bash
  diec sample.exe
  diec -e sample.exe   # Detailed entropy analysis per PE section
  ```

### 2. PE Structure & Import Address Table Parsing (`pefile`, `pedump`)
- **`pefile`**: Powerful Python library and CLI tool to parse Windows Portable Executable headers. Inspect imported DLLs (e.g., `kernel32.dll`, `ws2_32.dll`, `wininet.dll`) to infer malicious intent:
  - Process Injection: `VirtualAllocEx`, `WriteProcessMemory`, `CreateRemoteThread`.
  - Keylogging: `SetWindowsHookEx`, `GetAsyncKeyState`.
  - Anti-Debugging: `IsDebuggerPresent`, `CheckRemoteDebuggerPresent`.

### 3. Capability Mapping with Mandiant `capa`
- **Mandiant `capa`**: Automatically detects capabilities in executable files using community-curated rules mapped directly to the **MITRE ATT&CK** framework and the Malware Behavior Catalog (MBC):
  - Identifies anti-analysis tricks (anti-VM, anti-disassembly).
  - Flags C2 communication protocols (HTTP, raw TCP sockets, DNS queries).
  - Detects credential theft, registry persistence, and encryption algorithms (AES, RC4, RSA).
  ```bash
  capa sample.exe
  capa -v sample.exe    # Verbose output showing exact instruction offsets
  ```

### 4. Advanced String Deobfuscation with FLARE `floss`
- **FLARE `floss` (FireEye / Mandiant)**: Unlike standard `strings` which only extracts ASCII/Unicode text stored in plaintext, `floss` uses emulation to identify and decrypt:
  - **Stack Strings**: Strings constructed character-by-character on the stack at runtime.
  - **Tight Strings**: Encoded strings inside small loops (XOR, subtraction).
  - **Decoded Strings**: Identifies custom decoding routines and extracts outputs automatically.
  ```bash
  floss sample.exe
  floss --only=stack sample.exe   # Extract stack strings only
  ```

### 5. Malicious Document Macro Analysis (`olevba`, `oledump`)
- **`olevba` (oletools)**: Parses Microsoft Office documents (`.doc`, `.xls`, `.docm`, `.xlsm`, `.rtf`) and extracts Visual Basic for Applications (VBA) macros:
  - Flags auto-execution triggers (`AutoOpen`, `Workbook_Open`, `Document_Open`).
  - Identifies dangerous API calls (`WScript.Shell`, `ShellExecute`, `URLDownloadToFile`).
  - Flags obfuscation patterns (Hex decoding, `Chr()`, `StrReverse`, base64).
  ```bash
  olevba sample.docm
  olevba sample_macro.vba
  ```

---

## How to Solve & Practice

### 1. Launch the REMnux Analysis Container
```bash
docker compose up -d
```
Check that `cyberlab_remnux` is running:
```bash
docker ps --filter "name=cyberlab_remnux"
```

### 2. Enter the Interactive REMnux Terminal
Attach to the container's interactive shell:
```bash
docker exec -it cyberlab_remnux bash
```
You will be placed inside `/home/remnux/files`, which mounts your host's `./samples` directory.

### 3. Practice Macro Analysis with `olevba`
Analyze the included sample macro:
```bash
olevba sample_macro.vba
```
Observe the output table generated by `olevba`:
- **AutoExec**: Flags `AutoOpen` and `Document_Open`.
- **Suspicious**: Flags `WScript.Shell`, execution calls, and encoded strings.
- **Hex/Base64 Dumps**: Provides decoded command lines.

### 4. Analyzing Windows PE Executables
Place any sample `.exe` or `.dll` into `./samples` on your host, then run inside the container:

#### A. Detect Packing and Compiler Information:
```bash
diec suspicious_sample.exe
```

#### B. Extract Plaintext & Obfuscated Stack Strings:
```bash
floss suspicious_sample.exe > strings_report.txt
cat strings_report.txt | grep -E "(http|powershell|cmd|password|C:\\)"
```

#### C. Automatically Map Malware Capabilities:
```bash
capa suspicious_sample.exe
```
Examine the MITRE ATT&CK breakdown:
- Defense Evasion: Obfuscated Files or Information
- Discovery: System Network Configuration Discovery
- Execution: Command and Scripting Interpreter

#### D. Python-based Header Analysis (`pefile`):
```bash
python3 -c '
import pefile
pe = pefile.PE("suspicious_sample.exe")
for entry in pe.DIRECTORY_ENTRY_IMPORT:
    print("[+] DLL:", entry.dll.decode())
    for imp in entry.imports:
        if imp.name:
            print("    ->", imp.name.decode())
'
```

---

## YouTube Walkthroughs & Solving Guides

- [Dr Josh Stroschein - How Do You Handle Malware Safely? Start By Learning the REMnux VM!](https://www.youtube.com/watch?v=BluBQd9-Fc8)
- [Dr Josh Stroschein -  Malware Mondays Episode 05 - Using CAPA to identify capabilities in executable files](https://www.youtube.com/watch?v=iiTNc2yEjXM)
- [Dr Josh Stroschein -  Malware Mondays Episode 04 - Identifying Strings with FLOSS and Looking for Signs of Obfuscation](https://www.youtube.com/watch?v=5p9qMzRynvQ)
- [SANS Digital Forensics and Incident Response - capa: Automatically Identify Malware Capabilities w/ Ballenthin & Moritz Raabe - SANS DFIR Summit](https://www.youtube.com/watch?v=cbmMstmsq9c)
- [Tech Raj - Malware Analysis for Beginners with REMnux!](https://www.youtube.com/watch?v=_80fpeY-_AI)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Open interactive bash in REMnux
./lab shell remnux

# Stop this lab
docker compose down
```
