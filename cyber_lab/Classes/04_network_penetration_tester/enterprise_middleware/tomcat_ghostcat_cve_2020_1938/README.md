# Apache Tomcat Ghostcat AJP Protocol Arbitrary File Read & Inclusion (CVE-2020-1938)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Apache Tomcat Ghostcat AJP Protocol Arbitrary File Read & Inclusion (CVE-2020-1938)** (CVE-2020-1938).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/tomcat_ghostcat_cve_2020_1938`
* **Default Port(s)**: `8243:8080, 8244:8009`
* **CLI Shortcut**: `./lab start tomcat-ghostcat-ajp`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_tomcat_ghostcat`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Apache Tomcat Ghostcat AJP connector arbitrary file read and JSP inclusion.

### Technical Root Cause
The AJP connector implicitly trusted request attributes, allowing attackers to specify javax.servlet.include.request_uri and read web application files or include uploaded files as JSPs.

---

## Defensive Remediation & Hardening
Disable AJP Connector or upgrade Tomcat to 9.0.31, 8.5.51, 7.0.100 and set requiredSecret.

---

## Verified Video Walkthrough
* **Video Title**: [TryHackMe! Ghostcat CVE-2020-1938](https://www.youtube.com/watch?v=-Cy4u6fA3Os)
* **Direct URL**: https://www.youtube.com/watch?v=-Cy4u6fA3Os
