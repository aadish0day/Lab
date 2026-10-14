# Vulnerability Management & Threat Intelligence Lab (DefectDojo)

## Overview
Practice real-world vulnerability management, ingestion of scan reports from Nessus, Acunetix, Qualys, and CVSS severity triage (Obsidian Topic: *Vulnerability Management and Threat Intelligence*).

- **Default Port / Access**: `http://localhost:8098`
- **Container Name**: `cyberlab_defectdojo_server`
- **Shortcut**: `./lab start threat-intel`

---

## Lab Objectives

1. **Ingest Vulnerability Scans**:
   Export `.nessus`, Nmap XML, or Nikto/Burp XML scans from your Kali / Nessus VM and import them directly into DefectDojo.

2. **Deduplication & Correlation**:
   Watch how DefectDojo maps raw findings to CVE / CWE identifiers and groups duplicate vulnerabilities across scan runs.

3. **CVSS v3.1 Scoring & Remediation SLAs**:
   Assign CVSS metrics, track remediation workflows, and verify false-positive suppression rules.

---

## YouTube Walkthroughs & Solving Guides
- [Cyber Wolf - DefectDojo: Open-Source Vulnerability Management Made Easy](https://www.youtube.com/watch?v=eYX4fktYmzc)
- [Whitespots - How to Work with DefectDojo for DevSecOps](https://www.youtube.com/watch?v=_uFOIf1BUwU)
