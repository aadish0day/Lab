# Jenkins CLI Java Deserialization Remote Code Execution (CVE-2017-1000353)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Jenkins CLI Java Deserialization Remote Code Execution (CVE-2017-1000353)** (CVE-2017-1000353).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/jenkins_cve_2017_1000353`
* **Default Port(s)**: `8261:8080, 50003:50000`
* **CLI Shortcut**: `./lab start jenkins-signedobject-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_jenkins_353`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Jenkins CLI SignedObject two-stage deserialization unauthenticated RCE.

### Technical Root Cause
Jenkins remoting protocol processed Java serialized objects over the CLI HTTP endpoint. Attackers bypassed blacklist filters by nesting gadget chains inside java.security.SignedObject.

---

## Defensive Remediation & Hardening
Upgrade Jenkins to 2.57 or LTS 2.46.2 and disable CLI remoting over HTTP.

---

## Verified Video Walkthrough
* **Video Title**: [Jenkins CVE-2024-23897: From File Read to Full RCE on CI/CD Infrastructure](https://www.youtube.com/watch?v=6m58tAkw0FQ)
* **Direct URL**: https://www.youtube.com/watch?v=6m58tAkw0FQ
