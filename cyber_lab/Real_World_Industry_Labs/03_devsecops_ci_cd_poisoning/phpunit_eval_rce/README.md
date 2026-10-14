# PHPUnit eval-stdin.php Remote Code Execution (CVE-2017-9841)

## Laboratory Overview
This laboratory provides an isolated, production-grade practice target for studying **PHPUnit eval-stdin.php Remote Code Execution (CVE-2017-9841)** (CVE-2017-9841).

* **Target Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/phpunit_eval_rce`
* **Default Port(s)**: `8188:80`
* **CLI Shortcut**: `./lab start phpunit-eval-rce`

---

## Architecture & Service Map
* **Container Name**: `cyberlab_phpunit`
* **Upstream Image**: `vulhub/phpunit:5.6.2`
* **Network Mode**: Bridge (Isolated Docker network)
* **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics
PHPUnit vulnerability where eval-stdin.php executes arbitrary PHP code sent in the HTTP request body.

### Technical Root Cause
PHPUnit before 4.8.28 and 5.x before 5.6.3 ships a development helper script `vendor/phpunit/phpunit/src/Util/PHP/eval-stdin.php` that executes raw input from standard input via `eval()`, accessible over HTTP if exposed publicly.

---

## Defensive Remediation & Hardening
Do not expose `vendor/` directories via web servers. Update PHPUnit to modern releases.

---

## Verified Video Walkthrough
* **Video Title**: [Recon to RCE: Exploiting CVE-2017-9841 via PHPUnit (Hind Cyber Ghost)](https://www.youtube.com/watch?v=9N6jqM2PI1M)
* **Direct URL**: https://www.youtube.com/watch?v=9N6jqM2PI1M
