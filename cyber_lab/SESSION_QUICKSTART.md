# CyberLab Session Quickstart & System Architecture

This file serves as the **master state document** for your `cyber_lab` environment. When starting a new session or pairing with an AI assistant, refer to this guide for architecture, port mappings, VM sizing, and operational rules.

---

## System & Hardware Baseline

* **Host Machine**: Bare-Metal Linux, AMD Ryzen 7 6800HS (8 Cores, 16 Threads), 14 GiB RAM available (~9 GiB free).
* **VMware Inventory (`/home/aadish/vmware/`)**:
 * `kali`: Attacker VM (4 GB RAM, 2 vCPUs)
 * `Nessus`: Dedicated Vulnerability Scanner (4 GB RAM, 4 vCPUs)
 * `wazuh-4.14.6`: Dedicated SIEM/SOC Appliance (4 GB RAM, 2 vCPUs)
 * `Windows 10 x64`: Target/Active Directory client (4 GB RAM, 4 vCPUs)
 * `Metasploitable`: Target VM (512 MB RAM, 2 vCPUs)
* **Docker Host Sizing Rule**: Run Docker targets **on-demand** (`./lab start <shortcut>`). Never run all 500 labs simultaneously on a 14 GB RAM host.

---

## Repository Architecture

The repository is partitioned into three distinct functional areas:

1. **`Classes/`** — Syllabus-driven practice targets (Ethical Hacking, Web Pentesting, Network Targets, Exploit Writing).
2. **`Real_World_Industry_Labs/`** — Modern offensive domains (Cloud/K8s escapes, CI/CD supply chain, OAuth2/Vault, Web3 EVM, IoT).
3. **`tools/`** — **Dedicated Tooling Suite**:
 * `tools/network/`: Zeek, Snort, Suricata + EveBox.
 * `tools/offensive/`: Sliver C2, MITRE Caldera, Gophish, Interactsh OOB, JWT-Tool.
 * `tools/defensive_soc/`: Cowrie Honeypot, Velociraptor, MISP CTI, DefectDojo.
 * `tools/analysis/`: REMnux Malware Toolkit, DFIR CyberChef + Volatility 3, DevSecOps Scanner Pipeline.

---

## CLI Quick Reference (`./lab`)

All containers and workspaces are managed through the central `./lab` CLI script in the repository root:

```bash
# List all 500 labs and shortcuts (501 entries)
./lab list

# Start a specific lab or tool
./lab start <shortcut>

# Open an interactive shell inside the container
./lab shell <shortcut>

# Check currently running containers and health
./lab status

# Stop a single lab or all running containers
./lab stop <shortcut>
./lab stop-all
```

---

## Master Shortcut & Port Reference

### Tools (`tools/`)
| Shortcut | Path | Port / Access | Description |
| :--- | :--- | :--- | :--- |
| `zeek` | `tools/network/zeek` | `Port 3003` | Zeek NSM + In-browser Web Wireshark |
| `suricata` | `tools/network/suricata` | `Port 8113` | Suricata Next-Gen NIDS/NIPS + EveBox Web Console |
| `snort` | `tools/network/snort` | `Host Mode` | Snort 2 signature-based packet engine |
| `c2-sliver` | `tools/offensive/sliver-c2` | `Ports 8889, 31337` | BishopFox Sliver C2 adversary emulation framework |
| `c2-caldera` | `tools/offensive/caldera` | `Port 8888` | MITRE Caldera automated ATT&CK execution |
| `phish-gophish` | `tools/offensive/gophish` | `Ports 3333, 8092` | Gophish Red Team phishing platform |
| `oob` | `tools/offensive/interactsh-oob` | `Ports 8090, 5354` | ProjectDiscovery Interactsh OOB callback server |
| `jwt` | `tools/offensive/jwt-tool` | `Terminal` | JWT token forge and cracking workspace |
| `cowrie` | `tools/defensive_soc/cowrie` | `Ports 2223, 2324` | Cowrie SSH/Telnet deception honeypot |
| `velociraptor`| `tools/defensive_soc/velociraptor`| `Port 8114` | Rapid7 Velociraptor live endpoint VQL forensics |
| `misp` | `tools/defensive_soc/misp` | `Port 8115` | MISP Cyber Threat Intelligence platform |
| `threat-intel` | `tools/defensive_soc/defectdojo` | `Port 8098` | DefectDojo vulnerability management platform |
| `remnux` | `tools/analysis/remnux` | `Terminal` | SANS FOR610 REMnux malware analysis toolkit |
| `dfir` | `tools/analysis/dfir-cyberchef` | `Port 8106` | CyberChef + Volatility 3 + YARA suite |
| `scanner-pipeline` | `tools/analysis/devsecops-scanners`| `Port 8102` | Semgrep + Trivy + Gitleaks automated scanning stack |

### Web & API Penetration Testing (`Classes/02_web_penetration_tester/`)
* **Progression Guide**: Refer to [`Classes/02_web_penetration_tester/PORTSWIGGER_ROADMAP.md`](Classes/02_web_penetration_tester/PORTSWIGGER_ROADMAP.md) for Apprentice Practitioner Expert exercises.

| Shortcut | Port | Vulnerability / Topic Focus |
| :--- | :--- | :--- |
| `juice-shop` | `Port 3000` | OWASP Juice Shop Modern Top 10 |
| `sqli` | `Port 8086` | Advanced SQLi-Labs (UNION, Error, Blind, Time) |
| `ssti` | `Port 8094` | Jinja2 / Flask Template Injection to RCE |
| `deserialization` | `Port 8095` | Insecure Deserialization (Python Pickle / PHP) |
| `prototype-pollution` | `Port 8096` | Node.js Server-Side Prototype Pollution (`__proto__`) |
| `race-condition` | `Port 8097` | Concurrency Limit Overrun (Turbo Intruder target) |
| `smuggling` | `Port 8108` | HTTP Request Smuggling (CL.TE / TE.CL Desync) |
| `wordpress` | `Port 8107` | Vulnerable WordPress CMS (`wpscan`, XML-RPC, CVEs) |
| `railsgoat` | `Port 8109` | OWASP RailsGoat (Ruby on Rails MVC flaws) |
| `webgoat` | `Ports 8099, 9090` | OWASP WebGoat & WebWolf Java Enterprise Suite |
| `dvws` | `Ports 8102, 8103` | Damn Vulnerable Web Sockets (CSWSH & Socket frames) |
| `log4shell` | `Port 8104` | Log4Shell (CVE-2021-44228) JNDI LDAP lookup injection |
| `nosql` | `Port 3001` | MongoDB NoSQL operator injection |
| `client-bwapp` | `Port 8085` | bWAPP Client attacks (XSS, CSRF, Clickjacking) |
| `uploads-lfi` | `Port 8087` | File upload filter bypass & LFI/RFI PHP wrappers |
| `auth` | `Port 8084` | Broken Authentication & IDOR lab |
| `vampi` | `Port 5000` | Vulnerable REST API |
| `dvga` | `Port 5013` | Damn Vulnerable GraphQL API |
| `crapi` | `Ports 8888, 8025`| crAPI Cloud Microservices Architecture |
| `mutillidae` | `Port 8116` | OWASP Mutillidae II Web Pentest & ASVS Benchmark |
| `dvna` | `Port 8117` | Damn Vulnerable Node App (ReDoS, Prototype Pollution) |
| `vulnerableapp` | `Port 8119` | OWASP VulnerableApp Graduated Benchmark (L1-L5) |
| `drupalgeddon2` | `Port 8120` | Drupalgeddon 2 (CVE-2018-7600) Form API Injection RCE |
| `thinkphp-rce` | `Port 8131` | ThinkPHP 5.0.20 Controller Route RCE |
| `phpmyadmin-lfi` | `Port 8139` | phpMyAdmin 4.8.1 Authenticated LFI (CVE-2018-12613) |
| `solr-velocity` | `Port 8130` | Apache Solr Velocity Template SSTI RCE (CVE-2019-17558) |
| `php-cgi-rce` | `Port 8132` | PHP-CGI Query String Injection RCE (CVE-2012-1823) |
| `imagetragick` | `Port 8133` | ImageMagick ImageTragick RCE (CVE-2016-3714) |
| `ghostscript-rce` | `Port 8134` | Ghostscript -dSAFER Sandbox Bypass RCE (CVE-2018-16509) |
| `tomcat-put-rce` | `Port 8129` | Apache Tomcat Insecure PUT JSP Upload RCE (CVE-2017-12615) |
| `shiro-deserialization` | `Port 8127` | Apache Shiro RememberMe Deserialization RCE (CVE-2016-4437) |
| `fastjson-deserialization` | `Port 8128` | Fastjson 1.2.24 AutoType Deserialization RCE |
| `apache-traversal` | `Port 8138` | Apache HTTP Server Path Traversal & RCE (CVE-2021-41773) |
| `shellshock` | `Port 8137` | GNU Bash Shellshock Environment RCE (CVE-2014-6271) |
| `couchdb-privesc` | `Port 5984` | Apache CouchDB Admin Escalation & Erlang RCE (CVE-2017-12635/12636) |
| `elasticsearch-rce` | `Port 9200` | Elasticsearch MVEL/Groovy Sandbox Bypass RCE (CVE-2014-3120) |
| `mongo-express-rce` | `Port 8140` | Mongo-Express Server-Side JS RCE (CVE-2019-10758) |
| `uwsgi-traversal` | `Port 8153` | uWSGI PHP Directory Traversal (CVE-2018-7490) |
| `kibana-prototype-rce` | `Port 8155` | Kibana Timelion Prototype Pollution RCE (CVE-2019-7609) |
| `joomla-sqli` | `Port 8156` | Joomla Core com_fields SQL Injection (CVE-2017-8917) |
| `appweb-auth-bypass` | `Port 8159` | Embedthis Appweb HTTP Digest Auth Bypass (CVE-2018-8715) |
| `influxdb-jwt-bypass` | `Port 8164` | InfluxDB Empty Shared Secret JWT Signature Bypass (CVE-2019-20933) |
| `ffmpeg-hls-ssrf` | `Port 8165` | FFmpeg HLS Playlist File Reading & SSRF (CVE-2016-1897 / 1898) |
| `drupalgeddon1` | `Port 8166` | Drupal 7 Form API SQL Injection / Drupalgeddon 1 (CVE-2014-3704) |
| `spring-jackson-rce` | `Port 8171` | Jackson Databind Polymorphic Deserialization RCE (CVE-2017-7525) |
| `ecshop-deserialization` | `Port 8172` | ECShop Referer/User-Agent Base64 Deserialization SQLi RCE |
| `discuz-cookie-rce` | `Port 8173` | Discuz! Cookie Language Dynamic Local File Inclusion RCE |
| `php-xxe-injection` | `Port 8180` | PHP simplexml_load_string XML External Entity Injection |
| `django-trailing-redirect` | `Port 8181` | Django CommonMiddleware Trailing Slash Open Redirect (CVE-2018-14574) |
| `h2database-rce` | `Port 8184` | H2 Database Web Console JNDI Injection RCE (CVE-2021-42392) |
| `laravel-ignition-rce` | `Port 8187` | Laravel Ignition Debug Mode Deserialization RCE (CVE-2021-3129) |
| `adminer-ssrf` | `Port 8189` | Adminer Server-Side Request & Arbitrary File Read (CVE-2021-43008) |
| `solr-runexec-rce` | `Port 8198` | Apache Solr RunExecutableListener RCE (CVE-2017-12629) |
| `couchdb-cookie-rce` | `Port 8199` | Apache CouchDB Default Erlang Cookie RCE (CVE-2022-24706) |
| `mojarra-viewstate-rce` | `Port 8201` | Mojarra JSF ViewState Deserialization RCE |
| `xstream-deserialization-rce` | `Port 8202` | XStream Polymorphic Unmarshaling Deserialization RCE (CVE-2021-29505) |
| `fastjson-autotype-bypass` | `Port 8205` | Fastjson 1.2.47 AutoType Bypass Remote Code Execution |
| `metabase-fileread` | `Port 8215` | Metabase GeoJSON Endpoint Arbitrary Local File Inclusion (CVE-2021-41277) |
| `solr-dataimport-rce` | `Port 8216` | Apache Solr DataImportHandler ScriptTransformer RCE (CVE-2019-0193) |
| `solr-streaming-fileread` | `Port 8217` | Apache Solr RemoteStreaming Arbitrary Local File Disclosure |
| `phpmailer-file-disclosure` | `Port 8218` | PHPMailer msgHTML Local File Disclosure Vulnerability (CVE-2017-5223) |
| `shiro-path-bypass` | `Port 8219` | Apache Shiro Path Normalization Authentication Bypass (CVE-2020-1957) |
| `nginx-misconfig` | `Ports 8221, 8223, 8224` | Nginx Insecure Configuration Lab (Alias Traversal, CRLF, Header Overwrite) |
| `ghostscript-policy-bypass` | `Port 8222` | Ghostscript -dSAFER Sandbox Policy Bypass RCE (CVE-2019-6116) |
| `drupalgeddon3` | `Port 8233` | Drupalgeddon 3 Forms API Ajax Render Array Property Injection RCE (CVE-2018-7602) |
| `craftcms-rce` | `Port 8234` | Craft CMS 4 Pre-Authentication Template Engine RCE (CVE-2023-41892) |
| `django-open-redirect` | `Port 8235` | Django CommonMiddleware APPEND_SLASH Open Redirect Vulnerability (CVE-2018-14574) |
| `django-jsonfield-sqli` | `Port 8236` | Django JSONField & HStoreField KeyTransform SQL Injection (CVE-2019-14234) |
| `django-orderby-sqli` | `Port 8237` | Django QuerySet.order_by Raw Column SQL Injection (CVE-2021-35042) |
| `django-trunc-sqli` | `Port 8238` | Django Trunc & Extract Database Functions SQL Injection (CVE-2022-34265) |
| `discuz-file-delete` | `Port 8239` | Discuz! X3.4 Arbitrary File Deletion to Admin Re-installation RCE |
| `php-backdoor-rce` | `Port 8248` | PHP 8.1.0-dev User-Agentt Backdoor Remote Code Execution |
| `php-imap-rce` | `Port 8249` | PHP imap_open Command Injection RCE (CVE-2018-19518) |
| `php-xdebug-rce` | `Port 8250` | PHP XDebug Unauthenticated Remote Code Execution |
| `nginx-nullbyte-rce` | `Port 8251` | Nginx FastCGI Null Byte Code Execution (CVE-2013-4547) |
| `nginx-range-leak` | `Port 8252` | Nginx Range Header Integer Overflow Information Disclosure (CVE-2017-7529) |
| `elasticsearch-groovy-rce` | `Port 8253` | Elasticsearch Groovy Dynamic Scripting Remote Code Execution (CVE-2015-1427) |
| `fastjson-1283-rce` | `Port 8254` | Fastjson 1.2.83 AutoType Bypass Remote Code Execution (CVE-2022-25845) |
| `solr-xxe-injection` | `Port 8255` | Apache Solr XML Entity Expansion Information Disclosure (CVE-2017-12629 XXE) |
| `adminer-ssrf-bypass` | `Port 8258` | Adminer Elasticsearch Driver SSRF (CVE-2021-21311) |
| `cmsms-blind-sqli` | `Port 8259` | CMS Made Simple News Module Time-Based Blind SQLi (CVE-2019-9053) |
| `cmsms-object-rce` | `Port 8260` | CMS Made Simple Object Deserialization Remote Code Execution (CVE-2021-26120) |
| `owncloud-graphapi-leak` | `Port 8266` | ownCloud graphapi phpinfo Admin Credentials & Configuration Leak (CVE-2023-49103) |
| `php-fpm-underflow-rce` | `Port 8267` | PHP-FPM FastCGI PATH_INFO Pointer Underflow Remote Code Execution (CVE-2019-11043) |
| `tikiwiki-auth-bypass` | `Port 8268` | Tiki Wiki CMS Group Default Permissions Auth Bypass & Shell RCE (CVE-2020-15906) |

| `cgi-cve-2016-5385` | `Port 8269` | Cgi CVE-2016-1000111 Vulnerability Target |
| `craftcms-cve-2024-56145` | `Port 8270` | Craftcms CVE-2024-56145 Vulnerability Target |
| `craftcms-cve-2025-32432` | `Port 8271` | Craftcms CVE-2025-32432 Vulnerability Target |
| `discuz-wooyun-2010-080723` | `Port 8272` | Discuz WOOYUN-2010-080723 Vulnerability Target |
| `discuz-x3.4-arbitrary-file-d` | `Port 8273` | Discuz X3.4-ARBITRARY-FILE-DELETION Vulnerability Target |
| `django-cve-2017-12794` | `Port 8274` | Django CVE-2017-12794 Vulnerability Target |
| `django-cve-2020-9402` | `Port 8275` | Django CVE-2020-9402 Vulnerability Target |
| `drupal-cve-2017-6920` | `Port 8276` | Drupal CVE-2017-6920 Vulnerability Target |
| `drupal-cve-2019-6339` | `Port 8277` | Drupal CVE-2019-6339 Vulnerability Target |
| `drupal-cve-2019-6341` | `Port 8278` | Drupal CVE-2019-6341 Vulnerability Target |
| `ecshop-collection_list-sqli` | `Port 8279` | Ecshop COLLECTION_LIST-SQLI Vulnerability Target |
| `ecshop-xianzhi-2017-02-82239` | `Port 8280` | Ecshop XIANZHI-2017-02-82239600 Vulnerability Target |
| `electron-cve-2018-1000006` | `Port 8281` | Electron CVE-2018-1000006 Vulnerability Target |
| `electron-cve-2018-15685` | `Port 8282` | Electron CVE-2018-15685 Vulnerability Target |
| `flask-ssti` | `Port 8283` | Flask SSTI Vulnerability Target |
| `imagemagick-cve-2020-29599` | `Port 8284` | Imagemagick CVE-2020-29599 Vulnerability Target |
| `imagemagick-cve-2022-44268` | `Port 8285` | Imagemagick CVE-2022-44268 Vulnerability Target |
| `joomla-cve-2015-8562` | `Port 8286` | Joomla CVE-2015-8562 Vulnerability Target |
| `joomla-cve-2023-23752` | `Port 8287` | Joomla CVE-2023-23752 Vulnerability Target |
| `livewire-cve-2025-54068` | `Port 8288` | Livewire CVE-2025-54068 Vulnerability Target |
| `magento-2.2-sqli` | `Port 8289` | Magento 2.2-SQLI Vulnerability Target |
| `node-cve-2017-16082` | `Port 8290` | Node CVE-2017-16082 Vulnerability Target |
| `php-8.1-backdoor` | `Port 8291` | Php 8.1-BACKDOOR Vulnerability Target |
| `php-cve-2024-2961` | `Port 8292` | Php CVE-2024-2961 Vulnerability Target |
| `php-fpm` | `Port 8293` | Php FPM Vulnerability Target |
| `php-inclusion` | `Port 8294` | Php INCLUSION Vulnerability Target |
| `php-php_xxe` | `Port 8295` | Php PHP_XXE Vulnerability Target |
| `phpmyadmin-cve-2016-5734` | `Port 8297` | Phpmyadmin CVE-2016-5734 Vulnerability Target |
| `phpmyadmin-wooyun-2016-19943` | `Port 8298` | Phpmyadmin WOOYUN-2016-199433 Vulnerability Target |
| `rails-cve-2018-3760` | `Port 8299` | Rails CVE-2018-3760 Vulnerability Target |
| `showdoc-3.2.5-sqli` | `Port 8300` | Showdoc 3.2.5-SQLI Vulnerability Target |
| `showdoc-cnvd-2020-26585` | `Port 8301` | Showdoc CNVD-2020-26585 Vulnerability Target |
| `thinkphp-2-rce` | `Port 8302` | Thinkphp 2-RCE Vulnerability Target |
| `thinkphp-5-rce` | `Port 8303` | Thinkphp 5-RCE Vulnerability Target |

| `laravel-cve-2021-3129` | `Port 8422` | Laravel CVE-2021-3129 Vulnerability Target |
| `next.js-cve-2025-29927` | `Port 8423` | Next.js CVE-2025-29927 Vulnerability Target |
| `nginx-ui-cve-2026-27944` | `Port 8424` | Nginx-ui CVE-2026-27944 Vulnerability Target |
| `openclaw-cve-2026-25253` | `Port 8425` | Openclaw CVE-2026-25253 Vulnerability Target |
| `pdfjs-cve-2024-4367` | `Port 8426` | Pdfjs CVE-2024-4367 Vulnerability Target |
| `pgadmin-cve-2023-5002` | `Port 8427` | Pgadmin CVE-2023-5002 Vulnerability Target |
| `pgadmin-cve-2025-13780` | `Port 8428` | Pgadmin CVE-2025-13780 Vulnerability Target |
| `pgadmin-cve-2025-2945` | `Port 8429` | Pgadmin CVE-2025-2945 Vulnerability Target |
| `php-cve-2012-1823` | `Port 8430` | Php CVE-2012-1823 Vulnerability Target |
| `phpmyadmin-cve-2018-12613` | `Port 8431` | Phpmyadmin CVE-2018-12613 Vulnerability Target |
| `phpunit-cve-2017-9841` | `Port 8432` | Phpunit CVE-2017-9841 Vulnerability Target |
| `polkit-cve-2021-4034` | `Port 8433` | Polkit CVE-2021-4034 Vulnerability Target |
| `python-cve-2024-23334` | `Port 8434` | Python CVE-2024-23334 Vulnerability Target |
| `python-pil-cve-2017-8291` | `Port 8435` | Python CVE-2017-8291 Vulnerability Target |
| `python-unpickle` | `Port 8436` | Python UNPICKLE Vulnerability Target |
| `react-cve-2025-55182` | `Port 8437` | React CVE-2025-55182 Vulnerability Target |
| `rocketchat-cve-2021-22911` | `Port 8438` | Rocketchat CVE-2021-22911 Vulnerability Target |
| `ruby-cve-2017-17405` | `Port 8439` | Ruby CVE-2017-17405 Vulnerability Target |

### Cloud Native, Kubernetes & DevSecOps (`Real_World_Industry_Labs/`)
| Shortcut | Port / Access | Topic Focus |
| :--- | :--- | :--- |
| `k8s-goat` | `Port 8105` | Kubernetes Goat Cluster (22 scenarios, RBAC, Falco) |
| `container-escape` | `Terminal` | Alpine privileged mount & `CAP_SYS_ADMIN` breakout |
| `docker-api` | `Port 2375` | Docker Remote API Daemon unauth RCE & host escape |
| `opa-bypass` | `Port 8111` | OPA Gatekeeper Policy-as-Code Rego admission bypass |
| `wrongsecrets` | `Port 8100` | OWASP WrongSecrets (secrets in layers, env, K8s, Vault) |
| `cicd-goat` | `Port 8112` | Cider Security OWASP Top 10 CI/CD Risks CTF |
| `cicd-gitea` | `Port 3002` | Poisoned Pipeline Execution (PPE) in Gitea |
| `verdaccio` | `Port 8110` | Software Supply Chain & Dependency Confusion |
| `nexus-rce` | `Port 8136` | Sonatype Nexus Repository Manager 3 EL Injection RCE (CVE-2020-10199) |
| `vault` | `Port 8200` | HashiCorp Vault ACL privilege escalation & AppRole |
| `securebank` | `Ports 8118, 5001`| OWASP SecureBank FinTech Logic & API Pentesting |
| `aws-localstack` | `Port 4566` | LocalStack AWS cloud pentesting (IAM, S3, STS) |
| `cloudgoat` | `Terminal` | Rhino Security CloudGoat AWS pentest scenarios |
| `azuregoat` | `Terminal` | INE AzureGoat Microsoft Entra ID & Azure Functions |
| `gcpgoat` | `Terminal` | INE GCPGoat Google Cloud Platform IAM & SSRF Lab |
| `minio-leak` | `Ports 9000, 9002`| MinIO S3 Cluster Verify Environment Leak (CVE-2023-28432) |
| `jupyter-token-bypass` | `Port 8148` | Jupyter Notebook API Token Bypass & RCE (CVE-2019-10255) |
| `spark-unauth-rce` | `Ports 8144, 8145` | Apache Spark Standalone Cluster Manager REST RCE |
| `gogs-hook-rce` | `Port 8147` | Gogs Git Hook Execution & Session Traversal (CVE-2018-18925) |
| `gitlist-arg-injection` | `Port 8157` | GitList Search Query Argument Injection RCE (CVE-2018-1000533) |
| `hadoop-yarn-rce` | `Port 8162` | Apache Hadoop YARN ResourceManager REST API Unauthenticated RCE |
| `scrapyd-unauth-rce` | `Port 8168` | Scrapyd Unauthenticated Python Egg Upload & Scheduling RCE |
| `spring-oauth2-rce` | `Port 8170` | Spring Security OAuth2 Whitelabel Error SpEL RCE (CVE-2016-4977) |
| `grafana-traversal` | `Port 8182` | Grafana Plugin Path Traversal Arbitrary File Read (CVE-2021-43798) |
| `druid-rce` | `Port 8183` | Apache Druid Ingestion JavaScript RCE (CVE-2021-25646) |
| `apereo-cas-rce` | `Port 8186` | Apereo CAS Java Object Deserialization RCE |
| `phpunit-eval-rce` | `Port 8188` | PHPUnit eval-stdin.php Remote Code Execution (CVE-2017-9841) |
| `saltstack-rce` | `Port 8190` | SaltStack salt-api Unauthenticated Shell Command Injection (CVE-2020-16846) |
| `geoserver-rce` | `Port 8193` | GeoServer Unauthenticated JXPath Evaluation RCE (CVE-2024-36401) |
| `nexus-el-rce` | `Port 8206` | Sonatype Nexus 3 Unauthenticated Expression Language Injection RCE (CVE-2019-7238) |
| `nacos-auth-bypass` | `Port 8207` | Alibaba Nacos Dynamic Service Platform Authentication Bypass (CVE-2021-29441) |
| `saltstack-clearfuncs-rce` | `Port 8208` | SaltStack Salt-Master ClearFuncs Unauthenticated RCE (CVE-2020-11651) |
| `apisix-dashboard-rce` | `Ports 8225, 8226` | Apache APISIX Dashboard Unauthenticated API Access & Dropper RCE (CVE-2021-45232) |
| `airflow-dag-rce` | `Port 8227` | Apache Airflow Example DAG Celery Task Command Injection RCE (CVE-2020-11978) |
| `airflow-cookie-bypass` | `Port 8228` | Apache Airflow Session Cookie Default Secret Key Auth Bypass (CVE-2020-17526) |
| `celery-unauth-rce` | `Port 8229` | Celery 3 Unauthenticated Redis Command Injection & Task RCE |
| `cacti-rce` | `Port 8230` | Cacti Network Monitoring Remote_Agent Command Injection RCE (CVE-2022-46169) |
| `xxl-job-rce` | `Port 8231` | XXL-JOB Distributed Task Scheduler Default Access & REST Executor RCE |

| `1panel-cve-2024-39907` | `Port 8337` | 1panel CVE-2024-39907 Vulnerability Target |
| `airflow-cve-2020-11981` | `Port 8338` | Airflow CVE-2020-11981 Vulnerability Target |
| `aj-report-cnvd-2024-15077` | `Port 8339` | Aj-report CNVD-2024-15077 Vulnerability Target |
| `apereo-cas-4.1-rce` | `Port 8340` | Apereo-cas 4.1-RCE Vulnerability Target |
| `apisix-cve-2020-13945` | `Port 8341` | Apisix CVE-2020-13945 Vulnerability Target |
| `budibase-cve-2026-31816` | `Port 8343` | Budibase CVE-2026-31816 Vulnerability Target |
| `cacti-cve-2023-39361` | `Port 8344` | Cacti CVE-2023-39361 Vulnerability Target |
| `cacti-cve-2025-24367` | `Port 8345` | Cacti CVE-2025-24367 Vulnerability Target |
| `celery-celery3_redis_unauth` | `Port 8346` | Celery CELERY3_REDIS_UNAUTH Vulnerability Target |
| `chartbrew-cve-2026-25887` | `Port 8347` | Chartbrew CVE-2026-25887 Vulnerability Target |
| `comfyui-cve-2025-67303` | `Port 8348` | Comfyui CVE-2025-67303 Vulnerability Target |
| `comfyui-cve-2026-22777` | `Port 8349` | Comfyui CVE-2026-22777 Vulnerability Target |
| `elasticsearch-wooyun-2015-11` | `Port 8352` | Elasticsearch CVE-2015-5531 Vulnerability Target |
| `elfinder-cve-2021-32682` | `Port 8353` | Elfinder CVE-2021-32682 Vulnerability Target |
| `erlang-cve-2025-32433` | `Port 8354` | Erlang CVE-2025-32433 Vulnerability Target |
| `geoserver-cve-2021-40822` | `Port 8355` | Geoserver CVE-2021-40822 Vulnerability Target |
| `geoserver-cve-2022-24816` | `Port 8356` | Geoserver CVE-2023-35042 Vulnerability Target |
| `geoserver-cve-2023-25157` | `Port 8357` | Geoserver CVE-2023-25158 Vulnerability Target |
| `git-cve-2017-8386` | `Port 8358` | Git CVE-2017-8386 Vulnerability Target |
| `gitea-1.4-rce` | `Port 8359` | Gitea 1.4-RCE Vulnerability Target |
| `gotenberg-cve-2026-40281` | `Port 8360` | Gotenberg CVE-2026-40281 Vulnerability Target |
| `gradio-cve-2023-51449` | `Port 8361` | Gradio CVE-2023-51449 Vulnerability Target |
| `gradio-cve-2024-1561` | `Port 8362` | Gradio CVE-2024-1561 Vulnerability Target |
| `grafana-cve-2024-9264` | `Port 8363` | Grafana CVE-2024-9264 Vulnerability Target |
| `grafana-admin-ssrf` | `Port 8364` | Grafana ADMIN-SSRF Vulnerability Target |
| `hadoop-unauthorized-yarn` | `Port 8365` | Hadoop UNAUTHORIZED-YARN Vulnerability Target |
| `hertzbeat-cve-2024-42323` | `Port 8366` | Hertzbeat CVE-2024-42323 Vulnerability Target |
| `httpd-cve-2021-40438` | `Port 8367` | Httpd CVE-2021-40438 Vulnerability Target |
| `httpd-apache_parsing_vulnera` | `Port 8368` | Httpd APACHE_PARSING_VULNERABILITY Vulnerability Target |
| `httpd-ssi-rce` | `Port 8369` | Httpd SSI-RCE Vulnerability Target |
| `hugegraph-cve-2024-43441` | `Port 8370` | Hugegraph CVE-2024-43441 Vulnerability Target |
| `inetutils-cve-2026-24061` | `Port 8371` | Inetutils CVE-2026-24061 Vulnerability Target |

| `influxdb-cve-2019-20933` | `Port 8372` | Influxdb CVE-2019-20933 Vulnerability Target |
| `jimureport-cve-2023-4450` | `Port 8373` | Jimureport CVE-2023-4450 Vulnerability Target |
| `jumpserver-cve-2023-42820` | `Port 8374` | Jumpserver CVE-2023-42820 Vulnerability Target |
| `kafka-cve-2023-25194` | `Port 8375` | Kafka CVE-2023-25194 Vulnerability Target |
| `kibana-cve-2018-17246` | `Port 8376` | Kibana CVE-2018-17246 Vulnerability Target |
| `kibana-cve-2019-7609` | `Port 8377` | Kibana CVE-2019-7609 Vulnerability Target |
| `kibana-cve-2020-7012` | `Port 8378` | Kibana CVE-2020-7012 Vulnerability Target |
| `kkfileview-4.3-zipslip-rce` | `Port 8379` | Kkfileview 4.3-ZIPSLIP-RCE Vulnerability Target |
| `langflow-cve-2025-3248` | `Port 8380` | Langflow CVE-2025-3248 Vulnerability Target |
| `langflow-cve-2026-33017` | `Port 8381` | Langflow CVE-2026-33017 Vulnerability Target |
| `librsvg-cve-2023-38633` | `Port 8382` | Librsvg CVE-2023-38633 Vulnerability Target |
| `linkis-cve-2022-44645` | `Port 8383` | Linkis CVE-2022-44645 Vulnerability Target |
| `log4j-cve-2017-5645` | `Port 8384` | Log4j CVE-2017-5645 Vulnerability Target |
| `metabase-cve-2023-38646` | `Port 8385` | Metabase CVE-2023-38646 Vulnerability Target |
| `n8n-cve-2025-68613` | `Port 8386` | N8n CVE-2025-68613 Vulnerability Target |
| `n8n-cve-2026-21858` | `Port 8387` | N8n CVE-2026-21858 Vulnerability Target |
| `couchdb-cve-2017-12635` | `Port 8388` | Couchdb CVE-2017-12635 Vulnerability Target |
| `couchdb-cve-2017-12636` | `Port 8389` | Couchdb CVE-2017-12636 Vulnerability Target |
| `couchdb-cve-2022-24706` | `Port 8390` | Couchdb CVE-2022-24706 Vulnerability Target |
| `cups-browsed-cve-2024-47177` | `Port 8391` | Cups-browsed CVE-2024-47177 Vulnerability Target |
| `dns-dns-zone-transfer` | `Port 8392` | Dns DNS-ZONE-TRANSFER Vulnerability Target |
| `elasticsearch-cve-2014-3120` | `Port 8393` | Elasticsearch CVE-2014-3120 Vulnerability Target |
| `ghostscript-cve-2018-16509` | `Port 8394` | Ghostscript CVE-2018-16509 Vulnerability Target |
| `ghostscript-cve-2018-19475` | `Port 8395` | Ghostscript CVE-2018-19475 Vulnerability Target |
| `ingress-nginx-cve-2025-1974` | `Port 8396` | Ingress-nginx CVE-2025-1974 Vulnerability Target |

### Network, Active Directory, Enterprise Middleware, Exploit Writing & Hardware
| Shortcut | Port / Access | Topic Focus |
| :--- | :--- | :--- |
| `metasploitable2` | `Ports 21, 22, 23, 80, 445` | Full Metasploitable2 vulnerable suite |
| `ad-kerberos` | `Ports 88, 389, 445` | Native Samba AD DC (Kerberoasting, AS-REP Roasting) |
| `ad-ldap` | `Port 3893` | GLAuth lightweight Active Directory / LDAP |
| `sambacry` | `Port 4455` | Samba Remote Code Execution (CVE-2017-7494) |
| `struts2-s2045` | `Port 8121` | Apache Struts 2 (S2-045) OGNL Remote Code Execution |
| `redis-unauth` | `Port 6379` | Redis unauthenticated access & rogue module RCE |
| `jenkins-cve` | `Ports 8122, 50000` | Jenkins Controller CLI arbitrary file read (CVE-2024-23897) |
| `spring-gateway` | `Port 8125` | Spring Cloud Gateway SpEL Code Injection RCE (CVE-2022-22947) |
| `activemq-upload` | `Ports 8126, 61616` | Apache ActiveMQ Fileserver Arbitrary Upload RCE (CVE-2016-3088) |
| `weblogic-rce` | `Port 7001` | Oracle WebLogic WLS-WSAT XMLDecoder Deserialization RCE (CVE-2017-10271) |
| `heartbleed` | `Port 8443` | OpenSSL Heartbleed TLS Memory Disclosure (CVE-2014-0160) |
| `flink-traversal` | `Port 8135` | Apache Flink REST API Directory Traversal (CVE-2020-17518/17519) |
| `webmin-backdoor` | `Port 8141` | Webmin password_change.cgi Backdoor RCE (CVE-2019-15107) |
| `libssh-auth-bypass` | `Port 8142` | libssh Server Authentication Bypass (CVE-2018-10933) |
| `jboss-deserialization` | `Port 8143` | JBoss AS ReadOnlyAccessFilter Deserialization RCE (CVE-2017-12149) |
| `aria2-rce` | `Port 8146` | Aria2 JSON-RPC Arbitrary File Write & Crontab RCE |
| `mini-httpd-traversal` | `Port 8150` | ACME mini_httpd Virtual Host Traversal (CVE-2018-18778) |
| `spring-messaging-rce` | `Port 8151` | Spring Messaging STOMP Protocol SpEL RCE (CVE-2018-1270) |
| `spring-data-commons-rce` | `Port 8152` | Spring Data Commons Property Path SpEL RCE (CVE-2018-1273) |
| `rsync-unauth` | `Port 8154` | Rsync Daemon Anonymous Module Crontab RCE |
| `confluence-ognl-rce` | `Port 8158` | Atlassian Confluence Server OGNL Injection RCE (CVE-2022-26134) |
| `openssh-user-enum` | `Port 8160` | OpenSSH Username Timing Enumeration (CVE-2018-15473) |
| `glassfish-traversal` | `Port 8163` | GlassFish Admin Console Path Traversal Arbitrary File Read (CVE-2017-1000028) |
| `coldfusion-rce` | `Port 8167` | Adobe ColdFusion FCKeditor Traversal File Upload RCE |
| `spring-webflow-rce` | `Port 8169` | Spring Web Flow MvcViewFactoryCreator SpEL Injection RCE (CVE-2017-4971) |
| `struts2-s2005` | `Port 8174` | Apache Struts 2 (S2-005) OGNL Unicode Context Bypass RCE (CVE-2010-1870) |
| `struts2-s2008` | `Port 8175` | Apache Struts 2 (S2-008) DevMode / Cookie Double Evaluation RCE (CVE-2012-0391) |
| `struts2-s2009` | `Port 8176` | Apache Struts 2 (S2-009) ParametersInterceptor Chained Evaluation RCE (CVE-2011-3923) |
| `struts2-s2013` | `Port 8177` | Apache Struts 2 (S2-013) includeParams OGNL Injection RCE (CVE-2013-1966) |
| `jmeter-rmi-rce` | `Ports 8178, 1099` | Apache JMeter RMI Registry Deserialization RCE |
| `mysql-auth-bypass` | `Port 8179` | MySQL memcmp Signed Integer Cast Authentication Bypass (CVE-2012-2122) |
| `openfire-rce` | `Port 8185` | Openfire Admin Console Path Traversal & Plugin RCE (CVE-2023-32315) |
| `supervisor-rce` | `Port 8191` | Supervisor XML-RPC Arbitrary Code Execution (CVE-2017-11610) |
| `opensmtpd-rce` | `Ports 8192, 25` | OpenSMTPD Mail Server Command Injection RCE (CVE-2020-7247) |
| `spring4shell-rce` | `Port 8194` | Spring Framework Spring4Shell ClassLoader RCE (CVE-2022-22965) |
| `spring-function-rce` | `Port 8195` | Spring Cloud Function SpEL Routing RCE (CVE-2022-22963) |
| `struts2-s2057` | `Port 8196` | Apache Struts 2 Namespace OGNL Injection RCE (S2-057 / CVE-2018-11776) |
| `struts2-s2052` | `Port 8197` | Apache Struts 2 REST Plugin XStream Deserialization RCE (S2-052 / CVE-2017-9805) |
| `weblogic-console-rce` | `Port 8203` | Oracle WebLogic Console Authentication Bypass & Code Execution (CVE-2020-14882) |
| `activemq-openwire-rce` | `Ports 8204, 61617` | Apache ActiveMQ OpenWire Deserialization RCE (CVE-2023-46604) |
| `struts2-s2048` | `Port 8209` | Apache Struts 2 Struts 1 Plugin ActionForm OGNL RCE (S2-048 / CVE-2017-9791) |
| `struts2-s2053` | `Port 8210` | Apache Struts 2 Freemarker Template Double Evaluation OGNL RCE (S2-053 / CVE-2017-12611) |
| `struts2-s2059` | `Port 8211` | Apache Struts 2 Tag Attribute Double Evaluation OGNL RCE (S2-059 / CVE-2020-17530) |
| `struts2-s2061` | `Port 8212` | Apache Struts 2 OGNL Sandbox Package Blacklist Bypass (S2-061 / CVE-2020-17558) |
| `spring-data-rest-rce` | `Port 8213` | Spring Data REST PATCH Request JSON-Patch SpEL Injection RCE (CVE-2017-8046) |
| `spring-regex-bypass` | `Port 8214` | Spring Security RegexRequestMatcher Authorization Bypass (CVE-2022-22978) |
| `ofbiz-xmlrpc-rce` | `Port 8220` | Apache OFBiz XML-RPC Java Deserialization Remote Code Execution (CVE-2020-9496) |
| `redis-lua-escape` | `Port 8232` | Redis Debian/Ubuntu Package Lua Sandbox Escape RCE (CVE-2022-0543) |
| `dubbo-remoting-rce` | `Port 8240` | Apache Dubbo HTTP Remoting Java Deserialization RCE (CVE-2019-17564) |
| `unomi-mvel-rce` | `Port 8241` | Apache Unomi MVEL & OGNL Expression Injection RCE (CVE-2020-13942) |
| `hugegraph-gremlin-rce` | `Port 8242` | Apache HugeGraph Gremlin Sandbox Filter Bypass RCE (CVE-2024-27348) |
| `tomcat-ghostcat-ajp` | `Ports 8243, 8244` | Apache Tomcat Ghostcat AJP Protocol Arbitrary File Read & Inclusion (CVE-2020-1938) |
| `activemq-objectmessage-rce` | `Ports 8245, 61618` | Apache ActiveMQ ObjectMessage Java Deserialization RCE (CVE-2015-5254) |
| `postgres-copy-rce` | `Port 8246` | PostgreSQL COPY FROM PROGRAM Command Execution RCE (CVE-2019-9193) |
| `cxf-ssrf-rce` | `Port 8247` | Apache CXF Aegis DataBinding XML Parsing SSRF & Remote Execution (CVE-2024-28752) |
| `activemq-jolokia-rce` | `Ports 8256, 61619` | Apache ActiveMQ Jolokia JMX Remote Code Execution (CVE-2022-41678) |
| `activemq-jolokia-filewrite` | `Ports 8257, 61620` | Apache ActiveMQ Jolokia File Write & Code Execution (CVE-2024-32114) |
| `jenkins-signedobject-rce` | `Ports 8261, 50003` | Jenkins CLI SignedObject Deserialization RCE (CVE-2017-1000353) |
| `jenkins-stapler-rce` | `Ports 8262, 50004` | Jenkins Stapler Web Framework ACL Bypass RCE (CVE-2018-1000861) |
| `jetty-normalize-fileread` | `Port 8263` | Eclipse Jetty URI Normalization File Read (CVE-2021-28164) |
| `jetty-u002e-bypass` | `Port 8264` | Eclipse Jetty %u002e URI Normalization Bypass (CVE-2021-34429) |
| `neo4j-cypher-sqli` | `Port 8265` | Neo4j Cypher Injection APOC Procedure RCE (CVE-2021-34371) |
| `goahead-rce` | `Port 8149` | GoAhead Embedded Web Server LD_PRELOAD RCE (CVE-2017-17562) |
| `privesc-linux` | `Terminal` | Linux privilege escalation challenge container |
| `dns-tunnel` | `Port 5353/udp` | Iodine DNS tunneling and data exfiltration |
| `bof` | `Terminal` | Stack Buffer Overflow with GDB-pwndbg & pwntools |
| `shellcoder` | `Terminal` | Shellcode generation, encoders, and bad characters |
| `ai-pygoat` | `Port 8091` | OWASP LLM Top 10 & Prompt Injection |
| `web3-evm` | `Port 8545` | Solidity smart contract audit lab (Reentrancy) |
| `iot-firmware` | `Terminal` | Router firmware extraction with Binwalk & emulation |
| `openplc-modbus` | `Ports 502, 8123` | OpenPLC v3 Industrial SCADA, Modbus TCP & Web RCE |
| `iot-mqtt` | `Ports 1883, 9001` | Vulnerable Mosquitto MQTT broker & IoT telemetry |

---

| `coldfusion-cve-2017-3066` | `Port 8304` | Coldfusion CVE-2017-3066 Vulnerability Target |
| `coldfusion-cve-2023-26360` | `Port 8305` | Coldfusion CVE-2023-26360 Vulnerability Target |
| `coldfusion-cve-2023-29300` | `Port 8306` | Coldfusion CVE-2023-29300 Vulnerability Target |
| `fastjson-1.2.24-rce` | `Port 8307` | Fastjson CVE-2017-18349 Vulnerability Target |
| `fastjson-1.2.47-rce` | `Port 8308` | Fastjson 1.2.47-RCE Vulnerability Target |
| `fastjson-1.2.83-rce` | `Port 8309` | Fastjson 1.2.83-RCE Vulnerability Target |
| `h2database-cve-2018-10054` | `Port 8310` | H2database CVE-2018-10054 Vulnerability Target |
| `h2database-cve-2022-23221` | `Port 8311` | H2database CVE-2022-23221 Vulnerability Target |
| `jboss-cve-2017-7504` | `Port 8312` | Jboss CVE-2017-7504 Vulnerability Target |
| `jetty-cve-2021-28169` | `Port 8313` | Jetty CVE-2021-28169 Vulnerability Target |
| `ofbiz-cve-2023-51467` | `Port 8314` | Ofbiz CVE-2023-49070 Vulnerability Target |
| `ofbiz-cve-2024-38856` | `Port 8315` | Ofbiz CVE-2024-38856 Vulnerability Target |
| `ofbiz-cve-2024-45195` | `Port 8316` | Ofbiz CVE-2024-45195 Vulnerability Target |
| `ofbiz-cve-2024-45507` | `Port 8317` | Ofbiz CVE-2024-45507 Vulnerability Target |
| `postgres-cve-2018-1058` | `Port 8318` | Postgres CVE-2018-1058 Vulnerability Target |
| `redis-4-unacc` | `Port 8319` | Redis 4-UNACC Vulnerability Target |
| `rocketmq-cve-2023-33246` | `Port 8320` | Rocketmq CVE-2023-33246 Vulnerability Target |
| `rocketmq-cve-2023-37582` | `Port 8321` | Rocketmq CVE-2023-33246 Vulnerability Target |
| `solr-remote-streaming-filere` | `Port 8322` | Solr REMOTE-STREAMING-FILEREAD Vulnerability Target |
| `spring-cve-2025-41242` | `Port 8323` | Spring CVE-2025-41242 Vulnerability Target |
| `struts2-s2-048` | `Port 8324` | Struts2 S2-048 Vulnerability Target |
| `struts2-s2-052` | `Port 8325` | Struts2 S2-052 Vulnerability Target |
| `struts2-s2-053` | `Port 8326` | Struts2 S2-053 Vulnerability Target |
| `struts2-s2-066` | `Port 8327` | Struts2 CVE-2023-50164 Vulnerability Target |
| `struts2-s2-067` | `Port 8328` | Struts2 CVE-2024-53677 Vulnerability Target |
| `tomcat-cve-2026-34486` | `Port 8329` | Tomcat CVE-2026-34486 Vulnerability Target |
| `tomcat-tomcat8` | `Port 8330` | Tomcat TOMCAT8 Vulnerability Target |
| `weblogic-cve-2018-2628` | `Port 8331` | Weblogic CVE-2018-2628 Vulnerability Target |
| `weblogic-cve-2018-2894` | `Port 8332` | Weblogic CVE-2018-2894 Vulnerability Target |
| `weblogic-cve-2023-21839` | `Port 8333` | Weblogic CVE-2023-21839 Vulnerability Target |
| `weblogic-ssrf` | `Port 8334` | Weblogic SSRF Vulnerability Target |
| `weblogic-weak_password` | `Port 8335` | Weblogic WEAK_PASSWORD Vulnerability Target |
| `xstream-cve-2021-21351` | `Port 8336` | Xstream CVE-2021-21351 Vulnerability Target |

| `activemq-cve-2016-3088` | `Port 8397` | Activemq CVE-2016-3088 Vulnerability Target |
| `activemq-cve-2026-34197` | `Port 8398` | Activemq CVE-2026-34197 Vulnerability Target |
| `adminer-cve-2021-43008` | `Port 8399` | Adminer CVE-2021-43008 Vulnerability Target |
| `apache-druid-cve-2021-25646` | `Port 8400` | Apache-druid CVE-2021-25646 Vulnerability Target |
| `appweb-cve-2018-8715` | `Port 8401` | Appweb CVE-2018-8715 Vulnerability Target |
| `bash-cve-2014-6271` | `Port 8402` | Bash CVE-2014-6271 Vulnerability Target |
| `coldfusion-cve-2010-2861` | `Port 8403` | Coldfusion CVE-2010-2861 Vulnerability Target |
| `drupal-cve-2014-3704` | `Port 8404` | Drupal CVE-2014-3704 Vulnerability Target |
| `ffmpeg-cve-2016-1897` | `Port 8405` | Ffmpeg CVE-2016-1897 Vulnerability Target |
| `ffmpeg-cve-2017-9993` | `Port 8406` | Ffmpeg CVE-2017-9993 Vulnerability Target |
| `flink-cve-2020-17518` | `Port 8407` | Flink CVE-2020-17518 Vulnerability Target |
| `flink-cve-2020-17519` | `Port 8408` | Flink CVE-2020-17519 Vulnerability Target |
| `geoserver-cve-2024-36401` | `Port 8409` | Geoserver CVE-2024-36401 Vulnerability Target |
| `glassfish-cve-2017-1000028` | `Port 8410` | Glassfish CVE-2017-1000028 Vulnerability Target |
| `goahead-cve-2021-42342` | `Port 8411` | Goahead CVE-2021-42342 Vulnerability Target |
| `gogs-cve-2018-18925` | `Port 8412` | Gogs CVE-2018-18925 Vulnerability Target |
| `h2database-cve-2021-42392` | `Port 8413` | H2database CVE-2021-42392 Vulnerability Target |
| `imagemagick-cve-2016-3714` | `Port 8414` | Imagemagick CVE-2016-3714 Vulnerability Target |
| `jackson-cve-2017-7525` | `Port 8415` | Jackson CVE-2017-7525 Vulnerability Target |
| `java-rmi-codebase` | `Port 8416` | Java RMI-CODEBASE Vulnerability Target |
| `java-rmi-bind-bypass` | `Port 8417` | Java RMI-REGISTRY-BIND-DESERIALIZATION-BYPASS Vulnerability Target |
| `java-rmi-bind-deser` | `Port 8418` | Java RMI-REGISTRY-BIND-DESERIALIZATION Vulnerability Target |
| `jboss-cve-2017-12149` | `Port 8419` | Jboss CVE-2017-12149 Vulnerability Target |
| `jboss-jmxinvokerservlet-dese` | `Port 8420` | Jboss JMXINVOKERSERVLET-DESERIALIZATION Vulnerability Target |
| `jmeter-cve-2018-1297` | `Port 8421` | Jmeter CVE-2018-1297 Vulnerability Target |

| `libssh-cve-2018-10933` | `Port 8440` | Libssh CVE-2018-10933 Vulnerability Target |
| `liferay-portal-cve-2020-7961` | `Port 8441` | Liferay-portal CVE-2020-7961 Vulnerability Target |
| `mini_httpd-cve-2018-18778` | `Port 8442` | Mini_httpd CVE-2018-18778 Vulnerability Target |
| `minio-cve-2023-28432` | `Port 8444` | Minio CVE-2023-28432 Vulnerability Target |
| `mojarra-jsf-viewstate-deseri` | `Port 8445` | Mojarra JSF-VIEWSTATE-DESERIALIZATION Vulnerability Target |
| `mysql-cve-2012-2122` | `Port 8446` | Mysql CVE-2012-2122 Vulnerability Target |
| `nacos-cve-2021-29441` | `Port 8447` | Nacos CVE-2021-29441 Vulnerability Target |
| `nacos-cve-2021-29442` | `Port 8448` | Nacos CVE-2021-29442 Vulnerability Target |
| `nginx-nginx_parsing_vulnerab` | `Port 8449` | Nginx NGINX-PARSING-VULNERABILITY Vulnerability Target |
| `ntopng-cve-2021-28073` | `Port 8450` | Ntopng CVE-2021-28073 Vulnerability Target |
| `ofbiz-cve-2020-9496` | `Port 8451` | Ofbiz CVE-2020-9496 Vulnerability Target |
| `openfire-cve-2023-32315` | `Port 8452` | Openfire CVE-2023-32315 Vulnerability Target |
| `opensmtpd-cve-2020-7247` | `Port 8453` | Opensmtpd CVE-2020-7247 Vulnerability Target |
| `openssl-cve-2014-0160` | `Port 8454` | Openssl CVE-2014-0160 Vulnerability Target |
| `openssl-cve-2022-0778` | `Port 8455` | Openssl CVE-2022-0778 Vulnerability Target |
| `opentsdb-cve-2020-35476` | `Port 8456` | Opentsdb CVE-2020-35476 Vulnerability Target |
| `opentsdb-cve-2023-25826` | `Port 8457` | Opentsdb CVE-2023-25826 Vulnerability Target |
| `pgadmin-cve-2022-4223` | `Port 8458` | Pgadmin CVE-2022-4223 Vulnerability Target |

| `thinkphp-5-0-23-rce` | `Port 8459` | ThinkPHP 5.0.23-RCE Vulnerability Target |
| `thinkphp-in-sqlinjection` | `Port 8460` | ThinkPHP in-sqlinjection Vulnerability Target |
| `thinkphp-lang-rce` | `Port 8461` | ThinkPHP lang-rce Vulnerability Target |
| `v2board-1-6-privilege-escalation` | `Port 8462` | V2Board 1.6-privilege-escalation Vulnerability Target |
| `vite-cnvd-2022-44615` | `Port 8463` | Vite CNVD-2022-44615 Vulnerability Target |
| `vite-cve-2025-30208` | `Port 8464` | Vite CVE-2025-30208 Vulnerability Target |
| `vite-cve-2025-32395` | `Port 8465` | Vite CVE-2025-32395 Vulnerability Target |
| `vite-cve-2026-39363` | `Port 8466` | Vite CVE-2026-39363 Vulnerability Target |
| `wordpress-cve-2026-63030` | `Port 8467` | WordPress CVE-2026-63030 Vulnerability Target |
| `wordpress-pwnscriptum` | `Port 8468` | WordPress PwnScriptum Vulnerability Target |
| `yapi-mongodb-inj` | `Port 8469` | YApi mongodb-inj Vulnerability Target |
| `scrapy-scrapyd-unacc` | `Port 8470` | Scrapy scrapyd-unacc Vulnerability Target |
| `shiro-cve-2010-3863` | `Port 8471` | Shiro CVE-2010-3863 Vulnerability Target |
| `shiro-cve-2016-4437` | `Port 8472` | Shiro CVE-2016-4437 Vulnerability Target |
| `shiro-cve-2020-1957` | `Port 8473` | Shiro CVE-2020-1957 Vulnerability Target |
| `webmin-cve-2019-15107` | `Port 8474` | Webmin CVE-2019-15107 Vulnerability Target |
| `superset-cve-2023-27524` | `Port 8475` | Superset CVE-2023-27524 Vulnerability Target |
| `superset-cve-2023-37941` | `Port 8476` | Superset CVE-2023-37941 Vulnerability Target |
| `nowasp-mutillidae-owasp-top10` | `Port 8477` | NOWASP-Mutillidae OWASP-Top10 Vulnerability Target |
| `dvws-node-websocket-security` | `Port 8478` | DVWS-Node WebSocket-Security Vulnerability Target |
| `bodgeit-store-e-commerce-flaws` | `Port 8479` | BodgeIt-Store E-Commerce-Flaws Vulnerability Target |
| `flask-vulnerable-app-python-ssti-sqli` | `Port 8480` | Flask-Vulnerable-App Python-SSTI-SQLI Vulnerability Target |
| `owasp-wrongsecrets-cloud-secret-leakage` | `Port 8481` | OWASP-WrongSecrets Cloud-Secret-Leakage Vulnerability Target |
| `owasp-skf-security-knowledge-lab` | `Port 8482` | OWASP-SKF Security-Knowledge-Lab Vulnerability Target |
| `node-deserialization-nodejs-rce` | `Port 8483` | Node-Deserialization NodeJS-RCE Vulnerability Target |
| `nexus-cve-2019-7238` | `Port 8484` | Nexus CVE-2019-7238 Vulnerability Target |
| `nexus-cve-2020-10199` | `Port 8485` | Nexus CVE-2020-10199 Vulnerability Target |
| `nexus-cve-2020-10204` | `Port 8486` | Nexus CVE-2020-10204 Vulnerability Target |
| `nexus-cve-2024-4956` | `Port 8487` | Nexus CVE-2024-4956 Vulnerability Target |
| `saltstack-cve-2020-11651` | `Port 8488` | SaltStack CVE-2020-11651 Vulnerability Target |
| `saltstack-cve-2020-11652` | `Port 8489` | SaltStack CVE-2020-11652 Vulnerability Target |
| `saltstack-cve-2020-16846` | `Port 8490` | SaltStack CVE-2020-16846 Vulnerability Target |
| `samba-cve-2017-7494` | `Port 8491` | Samba CVE-2017-7494 Vulnerability Target |
| `skywalking-8-3-0-sqli` | `Port 8492` | SkyWalking 8.3.0-sqli Vulnerability Target |
| `solr-cve-2019-0193` | `Port 8493` | Solr CVE-2019-0193 Vulnerability Target |
| `solr-cve-2019-17558` | `Port 8494` | Solr CVE-2019-17558 Vulnerability Target |
| `spring-cve-2016-4977` | `Port 8495` | Spring CVE-2016-4977 Vulnerability Target |
| `spring-cve-2017-4971` | `Port 8496` | Spring CVE-2017-4971 Vulnerability Target |
| `spring-cve-2017-8046` | `Port 8497` | Spring CVE-2017-8046 Vulnerability Target |
| `spring-cve-2018-1270` | `Port 8498` | Spring CVE-2018-1270 Vulnerability Target |
| `spring-cve-2018-1273` | `Port 8499` | Spring CVE-2018-1273 Vulnerability Target |
| `spring-cve-2022-22947` | `Port 8500` | Spring CVE-2022-22947 Vulnerability Target |
| `spring-cve-2022-22963` | `Port 8501` | Spring CVE-2022-22963 Vulnerability Target |
| `spring-cve-2022-22965` | `Port 8502` | Spring CVE-2022-22965 Vulnerability Target |
| `spring-cve-2022-22978` | `Port 8503` | Spring CVE-2022-22978 Vulnerability Target |
| `struts2-s2-032` | `Port 8504` | Struts2 S2-032 Vulnerability Target |
| `struts2-s2-046` | `Port 8505` | Struts2 S2-046 Vulnerability Target |
| `supervisor-cve-2017-11610` | `Port 8506` | Supervisor CVE-2017-11610 Vulnerability Target |
| `weblogic-cve-2017-10271` | `Port 8507` | WebLogic CVE-2017-10271 Vulnerability Target |
| `struts2-vulnforensics-forensics-rce` | `Port 8508` | Struts2-VulnForensics Forensics-RCE Vulnerability Target |

| `wordpress-cve-2019-8942-rce` | `Port 8509` | WordPress CVE-2019-8942-RCE Vulnerability Target |
| `wordpress-cve-2017-1001000-rest-api` | `Port 8510` | WordPress CVE-2017-1001000-REST-API Vulnerability Target |
| `wordpress-catalog-product-catalog-sqli` | `Port 8511` | WordPress-Catalog Product-Catalog-SQLi Vulnerability Target |
| `wordpress-finder-cysteme-finder-lfi` | `Port 8512` | WordPress-Finder Cysteme-Finder-LFI Vulnerability Target |
| `wordpress-mailpress-mailpress-plugin-rce` | `Port 8513` | WordPress-Mailpress Mailpress-Plugin-RCE Vulnerability Target |
| `wordpress-optin-double-optin-sqli` | `Port 8514` | WordPress-OptIn Double-OptIn-SQLi Vulnerability Target |
| `phpmailer-cve-2016-10033` | `Port 8515` | PHPMailer CVE-2016-10033 Vulnerability Target |
| `discuz-x3-2-auth-bypass` | `Port 8516` | Discuz X3.2-Auth-Bypass Vulnerability Target |
| `cmseasy-cut-image-rce` | `Port 8517` | CmsEasy cut-image-rce Vulnerability Target |
| `zabbix-cve-2016-10134-sqli` | `Port 8518` | Zabbix CVE-2016-10134-SQLi Vulnerability Target |
| `zabbix-cve-2017-2824-rce` | `Port 8519` | Zabbix CVE-2017-2824-RCE Vulnerability Target |
| `git-cve-2018-11235` | `Port 8520` | Git CVE-2018-11235 Vulnerability Target |
| `owasp-webgoat-webgoat-enterprise` | `Port 8521` | OWASP-WebGoat WebGoat-Enterprise Vulnerability Target |
| `dsxs-xss-damn-small-xss-scanner` | `Port 8522` | DSXS-XSS Damn-Small-XSS-Scanner Vulnerability Target |
| `owasp-skf-xss-lab` | `Port 8523` | OWASP-SKF XSS-Lab Vulnerability Target |
| `owasp-skf-sqli-lab` | `Port 8524` | OWASP-SKF SQLi-Lab Vulnerability Target |
| `owasp-skf-ssrf-lab` | `Port 8525` | OWASP-SKF SSRF-Lab Vulnerability Target |
| `owasp-skf-idor-lab` | `Port 8526` | OWASP-SKF IDOR-Lab Vulnerability Target |
| `owasp-skf-lfi-lab` | `Port 8527` | OWASP-SKF LFI-Lab Vulnerability Target |
| `owasp-skf-rfi-lab` | `Port 8528` | OWASP-SKF RFI-Lab Vulnerability Target |
| `owasp-skf-cors-lab` | `Port 8529` | OWASP-SKF CORS-Lab Vulnerability Target |
| `owasp-skf-csrf-lab` | `Port 8530` | OWASP-SKF CSRF-Lab Vulnerability Target |
| `owasp-skf-racecondition-lab` | `Port 8531` | OWASP-SKF RaceCondition-Lab Vulnerability Target |
| `owasp-skf-commandexec-lab` | `Port 8532` | OWASP-SKF CommandExec-Lab Vulnerability Target |
| `owasp-skf-jwt-lab` | `Port 8533` | OWASP-SKF JWT-Lab Vulnerability Target |
| `tomcat-cve-2020-1938-ghostcat` | `Port 8534` | Tomcat CVE-2020-1938-Ghostcat Vulnerability Target |
| `tomcat-cve-2017-12615-put-rce` | `Port 8535` | Tomcat CVE-2017-12615-PUT-RCE Vulnerability Target |
| `struts2-s2-057` | `Port 8536` | Struts2 S2-057 Vulnerability Target |
| `jenkins-cve-2015-8103` | `Port 8537` | Jenkins CVE-2015-8103-Deser Vulnerability Target |
| `jboss-cve-2015-7501` | `Port 8538` | JBoss CVE-2015-7501-Deser Vulnerability Target |
| `openssh-cve-2017-1000117` | `Port 8539` | OpenSSH CVE-2017-1000117 Vulnerability Target |
| `struts2-s2-045` | `Port 8540` | Struts2 S2-045 Vulnerability Target |
| `struts2-s2-037` | `Port 8541` | Struts2 S2-037 Vulnerability Target |
| `struts2-s2-033` | `Port 8542` | Struts2 S2-033 Vulnerability Target |
| `struts2-s2-029` | `Port 8543` | Struts2 S2-029 Vulnerability Target |
| `struts2-s2-019` | `Port 8544` | Struts2 S2-019 Vulnerability Target |
| `struts2-s2-016` | `Port 8546` | Struts2 S2-016 Vulnerability Target |
| `struts2-s2-015` | `Port 8547` | Struts2 S2-015 Vulnerability Target |
| `struts2-s2-013` | `Port 8548` | Struts2 S2-013 Vulnerability Target |
| `struts2-s2-012` | `Port 8549` | Struts2 S2-012 Vulnerability Target |
| `struts2-s2-008` | `Port 8550` | Struts2 S2-008 Vulnerability Target |
| `struts2-s2-007` | `Port 8551` | Struts2 S2-007 Vulnerability Target |
| `struts2-s2-001` | `Port 8552` | Struts2 S2-001 Vulnerability Target |
| `struts2-s2-devmode` | `Port 8553` | Struts2 S2-devMode Vulnerability Target |
| `springboot-whitelabel-spel-rce` | `Port 8554` | SpringBoot Whitelabel-SpEL-RCE Vulnerability Target |
| `nginx-cve-2017-7529-integer-overflow` | `Port 8555` | Nginx CVE-2017-7529-Integer-Overflow Vulnerability Target |
| `nagios-cve-2016-9565-root-rce` | `Port 8556` | Nagios CVE-2016-9565-Root-RCE Vulnerability Target |
| `memcached-cve-2016-8704-append-overflow` | `Port 8557` | Memcached CVE-2016-8704-Append-Overflow Vulnerability Target |
| `memcached-cve-2016-8705-update-overflow` | `Port 8558` | Memcached CVE-2016-8705-Update-Overflow Vulnerability Target |
| `memcached-cve-2016-8706-sasl-overflow` | `Port 8559` | Memcached CVE-2016-8706-SASL-Overflow Vulnerability Target |

## Rules for Next Session

1. **Verify YouTube Links**: Every README in the project contains working, oEmbed-verified YouTube walkthroughs. If adding new labs, ensure the video links return `HTTP 200` via `https://www.youtube.com/oembed?url=...`.
2. **Keep Tooling in `tools/`**: All general-purpose monitoring, offensive frameworks, C2, forensics, and scan analyzers belong in `tools/` (`network`, `offensive`, `defensive_soc`, `analysis`). Targets to attack belong in `Classes/` or `Real_World_Industry_Labs/`.
3. **Check Port Availability**: When creating new labs, consult the table above to ensure no port conflicts occur.
