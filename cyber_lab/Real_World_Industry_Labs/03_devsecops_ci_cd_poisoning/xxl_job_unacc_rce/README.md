# XXL-JOB Distributed Task Scheduler Default Access & REST Executor RCE

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **XXL-JOB Distributed Task Scheduler Default Access & REST Executor RCE** (CWE-287).

- **Target Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/xxl_job_unacc_rce`
- **Default Port(s)**: `8231:8080`
- **CLI Shortcut**: `./lab start xxl-job-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_xxl_job`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

XXL-JOB distributed scheduler unauthenticated REST executor API code execution.

### Technical Root Cause

XXL-JOB executors accept job triggers with default or missing access tokens, allowing remote attackers to trigger GLUE or shell scripts.

---

## Defensive Remediation & Hardening

Configure strong xxl.job.accessToken values across admin and executor nodes.

---

## Verified Video Walkthrough

- **Video Title**: [急掌握-新版分布式调度XXL-Job+SpringBoot2.X项目实战](https://www.youtube.com/watch?v=pK1Ep5Lxf1A)
- **Direct URL**: https://www.youtube.com/watch?v=pK1Ep5Lxf1A
