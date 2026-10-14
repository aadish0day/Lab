# Neo4j Cypher Injection Remote Code Execution (CVE-2021-34371)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Neo4j Cypher Injection Remote Code Execution (CVE-2021-34371)** (CVE-2021-34371).

* **Target Directory**: `Classes/04_network_penetration_tester/enterprise_middleware/neo4j_cypher_cve_2021_34371`
* **Default Port(s)**: `8265:7474`
* **CLI Shortcut**: `./lab start neo4j-cypher-sqli`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_neo4j_cypher`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Neo4j Cypher query injection leading to APOC procedure Java code execution.

### Technical Root Cause
Unchecked concatenation of untrusted input into Cypher graph queries allowed attackers to invoke dangerous procedures like apoc.load.json or apoc.export and achieve command execution.

---

## Defensive Remediation & Hardening
Use parameterized Cypher queries, disable dangerous APOC procedures, and upgrade Neo4j.

---

## Verified Video Walkthrough
* **Video Title**: [SQL to Cypher in 5 Minutes! Crash Course with Code Examples](https://www.youtube.com/watch?v=_Ifb4WCMVaw)
* **Direct URL**: https://www.youtube.com/watch?v=_Ifb4WCMVaw
