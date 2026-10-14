# Jenkins Stapler Web Framework ACL Bypass & Code Execution (CVE-2018-1000861)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Jenkins Stapler Web Framework ACL Bypass & Code Execution (CVE-2018-1000861)** (CVE-2018-1000861).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/jenkins_stapler_cve_2018_1000861`
* **Default Port(s)**: `8262:8080, 50004:50000`
* **CLI Shortcut**: `./lab start jenkins-stapler-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_jenkins_stapler`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Jenkins Stapler web framework method routing ACL bypass leading to Groovy script RCE.

### Technical Root Cause
Stapler routing invoked public methods on model classes based on URL paths. Attackers chained method access to reach DescriptorByName.descriptorByName and execute Groovy code without authentication.

---

## Defensive Remediation & Hardening
Upgrade Jenkins to 2.154 or LTS 2.138.3+.

---

## Verified Video Walkthrough
* **Video Title**: [Unauthenticated RCE Jenkins (CVE-2018-1000861)](https://www.youtube.com/watch?v=I6VhjRBNU2c)
* **Direct URL**: https://www.youtube.com/watch?v=I6VhjRBNU2c
