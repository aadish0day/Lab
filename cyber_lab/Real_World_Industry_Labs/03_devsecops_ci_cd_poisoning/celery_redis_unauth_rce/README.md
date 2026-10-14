# Celery 3 Unauthenticated Redis Command Injection & Task RCE

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **Celery 3 Unauthenticated Redis Command Injection & Task RCE** (CWE-94).

* **Target Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/celery_redis_unauth_rce`
* **Default Port(s)**: `8229:6379`
* **CLI Shortcut**: `./lab start celery-unauth-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_celery_redis`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
Celery 3 unauthenticated Redis broker task injection leading to Python pickle deserialization RCE.

### Technical Root Cause
Celery 3 configurations used Python pickle as the default serializer, allowing anyone with access to the Redis broker to push malicious payloads into task queues.

---

## Defensive Remediation & Hardening
Use JSON serializer for Celery tasks, upgrade to Celery 4+, and protect Redis with authentication and firewall rules.

---

## Verified Video Walkthrough
* **Video Title**: [Django + Celery + Redis + Docker | Complete Setup & Background Task Tutorial](https://www.youtube.com/watch?v=3G0MxPNl2ek)
* **Direct URL**: https://www.youtube.com/watch?v=3G0MxPNl2ek
