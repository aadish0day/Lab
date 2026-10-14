# MISP Open Source Threat Intelligence & Sharing Platform

## Overview
Deploy and operate **MISP (Malware Information Sharing Platform)**, the global standard for Cyber Threat Intelligence (CTI) sharing, indicator correlation, and automated defensive rule generation. Ingest, structure, normalize, and contextualize Indicators of Compromise (IoCs), map malicious campaigns to **MITRE ATT&CK** techniques and threat actor profiles using **MISP Galaxies & Taxonomies**, ingest/export intelligence using **STIX 2.1 / TAXII**, and automatically generate actionable detection rules for **Suricata**, **Snort**, and **YARA**.

- **Default Port / Access**:
  - MISP Web GUI: `http://localhost:8115`
  - Default Credentials:
    - Username: `admin@admin.test`
    - Password: `admin` (You will be prompted to change on first login)
- **Container Stack**:
  - Web Frontend Proxy: `cyberlab_misp_web` (Port 8115)
  - Core Application Engine: `cyberlab_misp_core`
  - Modules & Expansion Worker: `cyberlab_misp_modules`
  - Relational Database: `cyberlab_misp_db` (MariaDB 10.11)
  - In-Memory Cache: `cyberlab_misp_redis` (Valkey / Redis)
- **Shared Storage**:
  - Sample STIX 2.1 Feeds: `Classes/06_vulnerability_management_and_threat_intel/misp_threat_intel/samples`
  - Application Configs: `Classes/06_vulnerability_management_and_threat_intel/misp_threat_intel/configs`
  - Logs: `Classes/06_vulnerability_management_and_threat_intel/misp_threat_intel/logs`
- **Directory**: `Classes/06_vulnerability_management_and_threat_intel/misp_threat_intel`

---

## Architecture & Threat Intel Pipeline

```
           [ Threat Intel Feeds / CIRCL / CISA / ISACs ]
                                  |
                                  v
              +---------------------------------------+
              |           MISP Web / API UI           |
              |          (cyberlab_misp_web)          |
              |          http://localhost:8115        |
              +-------------------+-------------------+
                                  |
                                  v
              +---------------------------------------+
              |           MISP Core Engine            |
              |          (cyberlab_misp_core)         |
              | - Indicator Ingestion & Normalization |
              | - Automated Correlation Engine        |
              | - STIX 2.1 / TAXII Server & Client    |
              | - Rule Exporter (Suricata, YARA, etc.)|
              +---------+-------------------+---------+
                        |                   |
            +-----------+--+             +--+------------+
            |              |             |               |
            v              v             v               v
     +--------------+ +----------+ +-----------+ +---------------+
     | MISP Modules | | MariaDB  | |  Valkey   | | Detection     |
     | Expansion &  | | Database | | Redis     | | Outpost:      |
     | Enrichment   | | (misp-db)| | (caching) | | Suricata/YARA |
     +--------------+ +----------+ +-----------+ +---------------+
```

---

## The Cyber Threat Intelligence (CTI) Lifecycle

```
       [ 1. Planning & Direction ]
       - Define PIRs (Priority Intelligence Requirements)
                  |
                  v
       [ 2. Collection & Ingestion ]
       - Open-source feeds, commercial feeds, sandbox dumps, internal incidents
                  |
                  v
       [ 3. Processing & Exploitation ]
       - Normalization, deduplication, translation into STIX 2.1 / MISP objects
                  |
                  v
       [ 4. Analysis & Production ]
       - Correlate indicators, tag with Taxonomies, attach Threat Actor Galaxies
                  |
                  v
       [ 5. Dissemination & Action ]
       - Push rules to SIEM/EDR/NIDS (Suricata/Snort/YARA), sync via TAXII
                  |
                  v
       [ 6. Feedback & Tuning ]
       - Evaluate detection fidelity, false positive rates, update Sightings
```

---

## Core MISP Concepts

### 1. Events, Attributes, and Objects
- **Event**: The top-level container describing an incident, campaign, or intelligence report. Contains metadata: date, threat level (High, Medium, Low), analysis status (Initial, Ongoing, Completed), and distribution rules (TLP:CLEAR, TLP:AMBER, TLP:RED).
- **Attribute**: An individual technical indicator within an event (e.g. `ip-dst: 198.51.100.25`, `domain: malicious-c2.net`, `sha256: 275a021bbf...`). Each attribute has an **IDS flag** (whether to export into NIDS/EDR rules).
- **Object**: A structured combination of related attributes following predefined schemas (e.g., `file` object with filename, md5, sha256, and size; `network-connection` object with src_ip, dst_ip, and dst_port).

### 2. Correlation Engine
When an analyst enters an attribute (e.g. an MD5 hash), MISP's correlation engine automatically links it to all past events across organizations sharing the same attribute. This instantly reveals if a newly observed indicator is part of an ongoing multi-year campaign by a tracked Advanced Persistent Threat (APT).

### 3. MISP Taxonomies & Galaxies
- **Taxonomies**: Classification libraries used to tag events systematically:
  - **TLP (Traffic Light Protocol)**: `tlp:white`, `tlp:green`, `tlp:amber`, `tlp:red`.
  - **Admiralty Scale (Information Reliability)**: Source reliability (`A` to `F`) and information credibility (`1` to `6`).
  - **PAP (Permissible Actions Protocol)**: What actions recipients are authorized to take.
- **Galaxies & Clusters**: Deep contextual frameworks:
  - **Threat Actor**: Links events to known adversaries (e.g., APT28, Lazarus Group, FIN7).
  - **MITRE ATT&CK**: Maps indicators to tactics (`Initial Access`, `Execution`, `Command and Control`) and specific techniques (`T1059.001 - PowerShell`).

### 4. STIX 2.1 and TAXII 2.1 Standard
- **STIX (Structured Threat Information eXpression)**: An OASIS open-standard graph serialization format (`json`) defining Cyber Observables, Indicators, Attack Patterns, Malware, and Campaigns.
- **TAXII (Trusted Automated eXchange of Intelligence Information)**: The application-layer transport protocol for routing cyber threat intelligence over HTTPS REST APIs.

---

## How to Solve & Practice

### 1. Launch the MISP Intelligence Stack
```bash
docker compose up -d
```
Verify all containers are up and healthy:
```bash
docker ps --filter "name=cyberlab_misp_"
```

### 2. Log in to the MISP Web Console
1. Navigate to:
   ```
   http://localhost:8115
   ```
2. Log in using default administrator credentials:
   - **Email**: `admin@admin.test`
   - **Password**: `admin`
3. When prompted, establish your new administrator password.

### 3. Create a Threat Intelligence Event
1. Click **Events** -> **Add Event** in the top navigation bar.
2. Fill in the event metadata:
   - **Distribution**: This Community Only (or Connected Communities)
   - **Threat Level**: High
   - **Analysis**: Initial
   - **Event Info**: `Investigation - APT-PhantomSpider Loader Campaign`
3. Click **Submit**.

### 4. Add Indicators and Objects
1. Inside the created event, click **Add Attribute**:
   - **Category**: Network activity
   - **Type**: domain
   - **Value**: `c2-sync-telemetry.com`
   - **For Intrusion Detection System**: Checked (Yes)
2. Add another attribute:
   - **Category**: Payload delivery
   - **Type**: sha256
   - **Value**: `275a021bbfb6489e54d471899f7db9d1663fc695ec2fe2a2c4538aabf651fd0f`
   - **For Intrusion Detection System**: Checked (Yes)

### 5. Tag with Taxonomies & Attach Galaxies
1. Click **Add Tag** on the event header:
   - Select `tlp:amber`
   - Select `misp-galaxy:mitre-attack-pattern="Command and Scripting Interpreter - T1059"`
2. Notice the visual relationship graph that MISP renders automatically connecting the indicators to known threat clusters.

### 6. Export Actionable Detection Rules
Export the curated indicators into live detection rules for your sensor grid:
1. In the event view, click **Export**.
2. Select your target detection format:
   - **Suricata Rules**: Generates ready-to-deploy Suricata alert signatures matching DNS queries and HTTP Host headers.
   - **Snort Rules**: Exports classic Snort rule syntax.
   - **YARA Rules**: Exports file hash and string definitions.
   - **STIX 2.1 JSON**: Exports the event as a standard STIX 2.1 JSON bundle.
3. Compare the generated Suricata output with the custom rules authoring practiced in `Classes/03_network_security/suricata_evebox_soc`.

### 7. Import External STIX 2.1 Threat Feed
Import the provided sample STIX 2.1 bundle:
1. Navigate to **Events** -> **Import from**.
2. Select **Upload STIX 2.0 / 2.1 File**.
3. Select the file located at:
   `Classes/06_vulnerability_management_and_threat_intel/misp_threat_intel/samples/sample_stix21_threat_report.json`
4. Confirm import to see how MISP automatically reconstructs threat actors, relationships, and indicator objects.

---

## YouTube Walkthroughs & Solving Guides

- [CIRCL Luxembourg - MISP Training (3h): Threat Intelligence Introduction for Analysts and Security Professionals](https://www.youtube.com/watch?v=wNe_wshjQqU)
- [Adam Goss - What is MISP and How it is Used For Cyber Threat Intelligence?](https://www.youtube.com/watch?v=qj94WjkIQ1M)
- [Adam Goss - How to Use Threat Intelligence Feeds With MISP](https://www.youtube.com/watch?v=tu86szd5jYU)
- [Adam Goss - How to Export IOCs from MISP to Defend Against Threats](https://www.youtube.com/watch?v=Q33GgClBeCo)
- [Cyber With Khalifa - How to Install MISP Easily? Full Threat Intelligence Setup Guide](https://www.youtube.com/watch?v=yMLpkgrhHEY)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
