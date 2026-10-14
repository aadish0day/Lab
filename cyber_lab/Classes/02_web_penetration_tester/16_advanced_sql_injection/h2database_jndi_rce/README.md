# H2 Database Web Console JNDI Injection RCE (CVE-2021-42392)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **H2 Database Web Console JNDI Injection RCE (CVE-2021-42392)** (CVE-2021-42392).

* **Target Directory**: `Classes/02_web_penetration_tester/16_advanced_sql_injection/h2database_jndi_rce`
* **Default Port(s)**: `8184:8080`
* **CLI Shortcut**: `./lab start h2database-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_h2database`
* **Upstream Image**: `vulhub/spring-with-h2database:2.0.204`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
H2 Database web console JNDI lookup injection similar to Log4Shell leading to remote code execution.

### Technical Root Cause
H2 Database web console in versions 1.1.100 through 2.0.204 permits unauthenticated remote connections. The driver parameter accepts an arbitrary `javax.naming.Context.lookup` call via LDAP or RMI URLs, resulting in remote class loading and execution.

---

## Defensive Remediation & Hardening
Upgrade H2 Database to version 2.0.206 or newer. Disable the H2 Console in production environments.

---

## Verified Video Walkthrough
* **Video Title**: [HackTheBox Hawk Walkthrough: FTP, Drupal Exploitation, and H2 Database RCE](https://www.youtube.com/watch?v=i3-N94T2hGk)
* **Direct URL**: https://www.youtube.com/watch?v=i3-N94T2hGk
