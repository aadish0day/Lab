# Metabase GeoJSON Endpoint Arbitrary Local File Inclusion (CVE-2021-41277)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Metabase GeoJSON Endpoint Arbitrary Local File Inclusion (CVE-2021-41277)** (CVE-2021-41277).

- **Target Directory**: `Classes/02_web_penetration_tester/06_owasp_top_10/metabase_cve_2021_41277`
- **Default Port(s)**: `8215:3000`
- **CLI Shortcut**: `./lab start metabase-fileread`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_metabase_fileread`
- **Upstream Image**: `vulhub/metabase:0.40.4`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Metabase unauthenticated local file disclosure via custom GeoJSON map file URL parameters.

### Technical Root Cause

In Metabase before versions 0.40.5 and 1.40.5, the `/api/geojson` endpoint allows unauthenticated users to pass custom URL paths beginning with `file://` or path traversal characters to read any local file readable by the Metabase server process.

---

## Defensive Remediation & Hardening

Upgrade Metabase to version 0.40.5, 1.40.5, or newer. Restrict access to internal APIs.

---

## Verified Video Walkthrough

- **Video Title**: [Metabase | Local File Inclusion | LFI | CVE-2021-41277](https://www.youtube.com/watch?v=7jXCBgmOG-M)
- **Direct URL**: https://www.youtube.com/watch?v=7jXCBgmOG-M
