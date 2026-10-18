# Apache Solr RemoteStreaming Arbitrary Local File Disclosure

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache Solr RemoteStreaming Arbitrary Local File Disclosure** (Apache Solr RemoteStreaming).

- **Target Directory**: `Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/solr_remote_streaming`
- **Default Port(s)**: `8217:8983`
- **CLI Shortcut**: `./lab start solr-streaming-fileread`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_solr_streaming`
- **Upstream Image**: `vulhub/solr:8.8.1`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Apache Solr unauthenticated local file disclosure via enabled stream.url and stream.body features.

### Technical Root Cause

When Solr ConfigAPI enables `solr.stream.url=true`, an attacker can send requests to `/solr/<core>/select` specifying `stream.url=file:///etc/passwd` to stream local server files into search result responses.

---

## Defensive Remediation & Hardening

Disable `solr.stream.url` and `solr.stream.body` in `solrconfig.xml`. Restrict access to administrative endpoints.

---

## Verified Video Walkthrough

- **Video Title**: [Apache Solr remote code execution](https://www.youtube.com/watch?v=dPEsjj3eONU)
- **Direct URL**: https://www.youtube.com/watch?v=dPEsjj3eONU
