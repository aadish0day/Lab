# Cybersecurity Lab: MrWebSecure Syllabus & Real-World Industry Labs

This repository is organized into three clean divisions:
1. **[`Classes/`](Classes/)**: Course curriculum tracks covering Ethical Hacking, Web Pentesting, Network Attacks, and Binary Exploitation.
2. **[`Real_World_Industry_Labs/`](Real_World_Industry_Labs/)**: Production-grade industry domains (Cloud/K8s escapes, DevSecOps, OAuth2/Vault, AWS/Azure, Web3 EVM, and Firmware).
3. **[`tools/`](tools/)**: **Dedicated Defensive, Offensive, and Forensic Tooling Suite** (Network Monitors, C2 Platforms, Honeypots, Live Triage, and Reverse-Engineering Workstations).

---

## Quick Management via CLI (`./lab`)

```bash
./lab list # List all 800 available labs, tools, and shortcuts (805 entries)
./lab start <shortcut> # Start a specific lab/tool container
./lab shell <shortcut> # Open interactive shell in container
./lab stop <shortcut> # Stop container
./lab status # Show running containers and ports
./lab stop-all # Shut down all running lab containers
```

---

## Dedicated Tooling Suite (`tools/`)

### 1. Network Monitoring & Detection (`tools/network/`)
* **Zeek NSM + Web Wireshark** ([`tools/network/zeek`](tools/network/zeek)): Semantic logs (`conn.log`, `dns.log`, `ssl.log`), JA3/JA4 TLS fingerprinting, and in-browser Wireshark. Shortcut: `./lab start zeek` | **Port**: `3003`.
* **Suricata NIDS/NIPS + EveBox** ([`tools/network/suricata`](tools/network/suricata)): Next-Gen multi-threaded intrusion detection with EVE JSON telemetry and EveBox web console. Shortcut: `./lab start suricata` | **Port**: `8113`.
* **Snort IDS/IPS** ([`tools/network/snort`](tools/network/snort)): Classic signature-based packet matching and evaluation engine. Shortcut: `./lab start snort` | **Host Mode**.

### 2. Offensive, Red Team & C2 Platforms (`tools/offensive/`)
* **Sliver C2** ([`tools/offensive/sliver-c2`](tools/offensive/sliver-c2)): BishopFox Go/C cross-platform Command & Control framework. Shortcut: `./lab start c2-sliver && ./lab shell c2-sliver` | **Ports**: `8889`, `31337`.
* **MITRE Caldera** ([`tools/offensive/caldera`](tools/offensive/caldera)): Automated adversary emulation mapped to MITRE ATT&CK. Shortcut: `./lab start c2-caldera` | **Port**: `8888`.
* **Gophish Phishing** ([`tools/offensive/gophish`](tools/offensive/gophish)): Red Team phishing campaign platform. Shortcut: `./lab start phish-gophish` | **Ports**: `3333` (Admin), `8092`.
* **Interactsh OOB Collaborator** ([`tools/offensive/interactsh-oob`](tools/offensive/interactsh-oob)): Self-hosted Out-of-Band SSRF/XXE callback server. Shortcut: `./lab start oob` | **Ports**: `8090`, `5354`.
* **JWT Tool Workspace** ([`tools/offensive/jwt-tool`](tools/offensive/jwt-tool)): CLI JWT manipulation and cracking toolkit. Shortcut: `./lab start jwt && ./lab shell jwt`.

### 3. Defensive SOC, Threat Intel & Live Triage (`tools/defensive_soc/`)
* **Cowrie Deception Honeypot** ([`tools/defensive_soc/cowrie`](tools/defensive_soc/cowrie)): Medium-to-high interaction SSH/Telnet honeypot with keystroke session replay. Shortcut: `./lab start cowrie` | **Ports**: `2223`, `2324`.
* **Velociraptor Live Endpoint Forensics** ([`tools/defensive_soc/velociraptor`](tools/defensive_soc/velociraptor)): Live endpoint triage and VQL threat hunting. Shortcut: `./lab start velociraptor` | **Port**: `8114`.
* **MISP Threat Intelligence** ([`tools/defensive_soc/misp`](tools/defensive_soc/misp)): Open-source CTI platform for IoC correlation and STIX 2.1/TAXII feeds. Shortcut: `./lab start misp` | **Port**: `8115`.
* **DefectDojo Vulnerability Management** ([`tools/defensive_soc/defectdojo`](tools/defensive_soc/defectdojo)): Scan ingestion (Nessus, Nmap, Burp) and CVSS triaging. Shortcut: `./lab start threat-intel` | **Port**: `8098`.

### 4. Forensic Analysis & Security Scanners (`tools/analysis/`)
* **REMnux Malware Analysis** ([`tools/analysis/remnux`](tools/analysis/remnux)): SANS FOR610 reverse engineering workstation (Capa, FLOSS, PEfile, Olevba). Shortcut: `./lab start remnux && ./lab shell remnux`.
* **DFIR Suite** ([`tools/analysis/dfir-cyberchef`](tools/analysis/dfir-cyberchef)): CyberChef deobfuscation + Volatility 3 memory forensics + YARA scanning. Shortcut: `./lab start dfir` | **Port**: `8106`.
* **DevSecOps Scanner Stack** ([`tools/analysis/devsecops-scanners`](tools/analysis/devsecops-scanners)): Automated SAST, SCA, and secret scanning pipeline (Semgrep + Trivy + Gitleaks). Shortcut: `./lab start scanner-pipeline` | **Port**: `8102`.

---

## Real-World Industry Labs (`Real_World_Industry_Labs/`)

### 1. AI & LLM Security
* **OWASP PyGoat LLM** ([`01_llm_ai_security/pygoat_ai_owasp`](Real_World_Industry_Labs/01_llm_ai_security/pygoat_ai_owasp)): Prompt Injection, Insecure Output Handling, and Model Deserialization. Shortcut: `./lab start ai-pygoat` | **Port**: `8091`.
* **Jupyter Notebook API Token Bypass & RCE** ([`01_llm_ai_security/jupyter_notebook_rce`](Real_World_Industry_Labs/01_llm_ai_security/jupyter_notebook_rce)): Unauthenticated API token bypass and terminal command execution (CVE-2019-10255). Shortcut: `./lab start jupyter-token-bypass` | **Port**: `8148`.

### 2. Cloud Native & Kubernetes Security
* **Container Escape Target** ([`02_cloud_k8s_container_escape/badrobot_k8s_escape`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/badrobot_k8s_escape)): Privileged container breakout & `CAP_SYS_ADMIN`. Shortcut: `./lab start container-escape`.
* **Kubernetes Goat Cluster** ([`02_cloud_k8s_container_escape/kubernetes_goat`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/kubernetes_goat)): 22-scenario K3s offensive/defensive cluster (RBAC, SSRF metadata, Falco). Shortcut: `./lab start k8s-goat` | **Port**: `8105`.
* **OPA Gatekeeper Bypass** ([`02_cloud_k8s_container_escape/opa_gatekeeper_bypass`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/opa_gatekeeper_bypass)): Policy-as-Code Rego logic evasion and admission webhook bypasses. Shortcut: `./lab start opa-bypass` | **Port**: `8111`.
* **Docker Remote Daemon API RCE** ([`02_cloud_k8s_container_escape/docker_remote_api_rce`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/docker_remote_api_rce)): Unauthenticated Docker daemon management socket and host root mount escape. Shortcut: `./lab start docker-api` | **Port**: `2375`.
* **Apache Spark Standalone Cluster Manager REST RCE** ([`02_cloud_k8s_container_escape/spark_unauth_rce`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/spark_unauth_rce)): Unauthenticated Spark standalone submission API RCE. Shortcut: `./lab start spark-unauth-rce` | **Ports**: `8144`, `8145`.
* **Apache Hadoop YARN ResourceManager REST API RCE** ([`02_cloud_k8s_container_escape/hadoop_yarn_rce`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/hadoop_yarn_rce)): Unauthenticated REST API application submission and arbitrary command execution. Shortcut: `./lab start hadoop-yarn-rce` | **Port**: `8162`.
* **Grafana Plugin Path Traversal Arbitrary File Read** ([`02_cloud_k8s_container_escape/grafana_cve_2021_43798`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/grafana_cve_2021_43798)): Unauthenticated directory traversal via plugin assets endpoint (CVE-2021-43798). Shortcut: `./lab start grafana-traversal` | **Port**: `8182`.
* **Apache Druid Ingestion JavaScript RCE** ([`02_cloud_k8s_container_escape/apache_druid_rce`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/apache_druid_rce)): JSON-based ingestion spec JavaScript execution RCE (CVE-2021-25646). Shortcut: `./lab start druid-rce` | **Port**: `8183`.
* **GeoServer Unauthenticated JXPath Evaluation RCE** ([`02_cloud_k8s_container_escape/geoserver_jxpath_rce`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/geoserver_jxpath_rce)): OGC request filter attribute evaluation RCE (CVE-2024-36401). Shortcut: `./lab start geoserver-rce` | **Port**: `8193`.

### 3. DevSecOps & Supply Chain Security
* **CI/CD Poisoning (Gitea)** ([`03_devsecops_ci_cd_poisoning/poisoned_pipeline_gitea`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/poisoned_pipeline_gitea)): Poisoned Pipeline Execution (PPE) and runner token theft. Shortcut: `./lab start cicd-gitea` | **Port**: `3002`.
* **Cider Security CI/CD Goat** ([`03_devsecops_ci_cd_poisoning/cicd_goat`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/cicd_goat)): OWASP Top 10 CI/CD Security Risks CTF. Shortcut: `./lab start cicd-goat` | **Port**: `8112`.
* **OWASP WrongSecrets** ([`03_devsecops_ci_cd_poisoning/wrongsecrets`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/wrongsecrets)): Secrets in code, Docker layers, K8s, and Vault. Shortcut: `./lab start wrongsecrets` | **Port**: `8100`.
* **Verdaccio Supply Chain** ([`03_devsecops_ci_cd_poisoning/supply_chain_verdaccio`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/supply_chain_verdaccio)): Dependency Confusion & package registry poisoning. Shortcut: `./lab start verdaccio` | **Port**: `8110`.
* **Sonatype Nexus Repository Manager 3 EL RCE** ([`03_devsecops_ci_cd_poisoning/nexus_repository_el_rce`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/nexus_repository_el_rce)): Java Expression Language (JUEL) injection RCE (CVE-2020-10199). Shortcut: `./lab start nexus-rce` | **Port**: `8136`.
* **Gogs Git Hook Execution & Session Traversal** ([`03_devsecops_ci_cd_poisoning/gogs_hook_rce`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/gogs_hook_rce)): Session directory traversal and custom git hook execution (CVE-2018-18925). Shortcut: `./lab start gogs-hook-rce` | **Port**: `8147`.
* **GitList Search Query Argument Injection RCE** ([`03_devsecops_ci_cd_poisoning/gitlist_argument_injection_rce`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/gitlist_argument_injection_rce)): Argument injection in git grep search query to web shell (CVE-2018-1000533). Shortcut: `./lab start gitlist-arg-injection` | **Port**: `8157`.
* **Scrapyd Unauthenticated Egg Upload & RCE** ([`03_devsecops_ci_cd_poisoning/scrapyd_unauth_rce`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/scrapyd_unauth_rce)): Arbitrary Python egg deployment and unauthenticated spider execution. Shortcut: `./lab start scrapyd-unauth-rce` | **Port**: `8168`.
* **PHPUnit eval-stdin.php Remote Code Execution** ([`03_devsecops_ci_cd_poisoning/phpunit_eval_rce`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/phpunit_eval_rce)): HTTP request body evaluation in test runner helper script (CVE-2017-9841). Shortcut: `./lab start phpunit-eval-rce` | **Port**: `8188`.
* **SaltStack salt-api Unauthenticated Shell Injection** ([`03_devsecops_ci_cd_poisoning/saltstack_unauth_rce`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/saltstack_unauth_rce)): SSH client command injection vulnerability in salt-api (CVE-2020-16846). Shortcut: `./lab start saltstack-rce` | **Port**: `8190`.
* **Sonatype Nexus 3 Unauth EL Injection RCE** ([`03_devsecops_ci_cd_poisoning/nexus_el_injection_rce`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/nexus_el_injection_rce)): EL evaluation expression injection arbitrary code execution (CVE-2019-7238). Shortcut: `./lab start nexus-el-rce` | **Port**: `8206`.
* **SaltStack Salt-Master ClearFuncs Unauth RCE** ([`03_devsecops_ci_cd_poisoning/saltstack_clearfuncs_rce`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/saltstack_clearfuncs_rce)): ClearFuncs unauthenticated method execution and root privilege compromise (CVE-2020-11651). Shortcut: `./lab start saltstack-clearfuncs-rce` | **Port**: `8208`.
* **Apache Airflow Example DAG Celery Task Command Injection RCE** ([`03_devsecops_ci_cd_poisoning/airflow_cve_2020_11978`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/airflow_cve_2020_11978)): Unsanitized JSON configuration bash execution RCE (CVE-2020-11978). Shortcut: `./lab start airflow-dag-rce` | **Port**: `8227`.
* **Apache Airflow Session Cookie Default Secret Key Auth Bypass** ([`03_devsecops_ci_cd_poisoning/airflow_cve_2020_17526`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/airflow_cve_2020_17526)): Hardcoded Flask signing key administrative session forgery (CVE-2020-17526). Shortcut: `./lab start airflow-cookie-bypass` | **Port**: `8228`.
* **Celery 3 Unauthenticated Redis Command Injection & Task RCE** ([`03_devsecops_ci_cd_poisoning/celery_redis_unauth_rce`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/celery_redis_unauth_rce)): Insecure pickle deserialization via Redis broker queue injection. Shortcut: `./lab start celery-unauth-rce` | **Port**: `8229`.
* **Cacti Network Monitoring Remote_Agent Command Injection RCE** ([`03_devsecops_ci_cd_poisoning/cacti_cve_2022_46169`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/cacti_cve_2022_46169)): Client IP spoofing and poller_id command injection (CVE-2022-46169). Shortcut: `./lab start cacti-rce` | **Port**: `8230`.
* **XXL-JOB Distributed Task Scheduler REST API RCE** ([`03_devsecops_ci_cd_poisoning/xxl_job_unacc_rce`](Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/xxl_job_unacc_rce)): Unauthenticated REST executor API trigger with shell / GLUE execution. Shortcut: `./lab start xxl-job-rce` | **Port**: `8231`.

### 4. Identity, Single Sign-On & Secrets Broker
* **Keycloak OAuth2/OIDC** ([`05_api_gateway_oauth_oidc/oauth2_idor_lab`](Real_World_Industry_Labs/05_api_gateway_oauth_oidc/oauth2_idor_lab)): SSO pentesting, redirect URI poisoning, and token replay. Shortcut: `./lab start oauth-keycloak` | **Port**: `8093`.
* **HashiCorp Vault Security** ([`05_api_gateway_oauth_oidc/hashicorp_vault_security`](Real_World_Industry_Labs/05_api_gateway_oauth_oidc/hashicorp_vault_security)): Vault ACL policy privilege escalation and AppRole abuse. Shortcut: `./lab start vault` | **Port**: `8200`.
* **OWASP SecureBank** ([`05_api_gateway_oauth_oidc/securebank`](Real_World_Industry_Labs/05_api_gateway_oauth_oidc/securebank)): FinTech business logic flaws, double-spending race conditions, and BOLA/IDOR banking API pentesting. Shortcut: `./lab start securebank` | **Ports**: `8118`, `5001`.
* **Spring Security OAuth2 Whitelabel Error SpEL RCE** ([`05_api_gateway_oauth_oidc/spring_oauth2_rce`](Real_World_Industry_Labs/05_api_gateway_oauth_oidc/spring_oauth2_rce)): SpEL expression injection via error response parameter rendering (CVE-2016-4977). Shortcut: `./lab start spring-oauth2-rce` | **Port**: `8170`.
* **Apereo CAS Java Object Deserialization RCE** ([`05_api_gateway_oauth_oidc/apereo_cas_rce`](Real_World_Industry_Labs/05_api_gateway_oauth_oidc/apereo_cas_rce)): Unencrypted execution state parameter deserialization RCE. Shortcut: `./lab start apereo-cas-rce` | **Port**: `8186`.
* **Alibaba Nacos User-Agent Auth Bypass** ([`05_api_gateway_oauth_oidc/nacos_auth_bypass`](Real_World_Industry_Labs/05_api_gateway_oauth_oidc/nacos_auth_bypass)): Default user agent header manipulation authentication bypass (CVE-2021-29441). Shortcut: `./lab start nacos-auth-bypass` | **Port**: `8207`.
* **Apache APISIX Dashboard Unauthenticated API Access & Dropper RCE** ([`05_api_gateway_oauth_oidc/apisix_cve_2021_45232`](Real_World_Industry_Labs/05_api_gateway_oauth_oidc/apisix_cve_2021_45232)): URI filter bypass on administrative endpoints and script injection (CVE-2021-45232). Shortcut: `./lab start apisix-dashboard-rce` | **Ports**: `8225`, `8226`.

### 5. Multi-Cloud Security (AWS, Azure & GCP)
* **AWS LocalStack** ([`06_aws_cloud_security/localstack_aws_pentest`](Real_World_Industry_Labs/06_aws_cloud_security/localstack_aws_pentest)): Offline AWS IAM, S3, and Lambda exploitation. Shortcut: `./lab start aws-localstack` | **Port**: `4566`.
* **Rhino Security CloudGoat** ([`06_aws_cloud_security/cloudgoat`](Real_World_Industry_Labs/06_aws_cloud_security/cloudgoat)): 21 AWS IAM privilege escalation paths and EC2 metadata SSRF. Shortcut: `./lab start cloudgoat`.
* **INE AzureGoat** ([`06_aws_cloud_security/azuregoat`](Real_World_Industry_Labs/06_aws_cloud_security/azuregoat)): Microsoft Entra ID (Azure AD) RBAC escalation and Managed Identity token theft. Shortcut: `./lab start azuregoat`.
* **INE GCPGoat** ([`08_gcp_cloud_security/gcpgoat`](Real_World_Industry_Labs/08_gcp_cloud_security/gcpgoat)): Google Cloud Platform IAM privilege escalation, metadata service (IMDS) SSRF, and GCS bucket exploitation. Shortcut: `./lab start gcpgoat`.
* **MinIO S3 Cluster Verify Environment Leak** ([`06_aws_cloud_security/minio_s3_secret_leak`](Real_World_Industry_Labs/06_aws_cloud_security/minio_s3_secret_leak)): Unauthenticated cluster verify endpoint information disclosure (CVE-2023-28432). Shortcut: `./lab start minio-leak` | **Ports**: `9000`, `9002`.

### 6. Emerging Technologies (Web3, OT/SCADA & IoT)
* **Web3 Smart Contract Security** ([`07_web3_smart_contracts/evm_vulnerable_bank`](Real_World_Industry_Labs/07_web3_smart_contracts/evm_vulnerable_bank)): Solidity Reentrancy, price oracle manipulation, and mempool front-running. Shortcut: `./lab start web3-evm` | **Port**: `8545`.
* **IoT Firmware Reverse Engineering** ([`10_iot_firmware_hardware_hacking/firmadyne_emulation`](Real_World_Industry_Labs/10_iot_firmware_hardware_hacking/firmadyne_emulation)): Binwalk firmware extraction and cross-architecture emulation. Shortcut: `./lab start iot-firmware`.
* **OpenPLC v3 SCADA & Modbus TCP** ([`10_iot_firmware_hardware_hacking/openplc_scada_modbus`](Real_World_Industry_Labs/10_iot_firmware_hardware_hacking/openplc_scada_modbus)): Industrial control systems, holding register tampering, coil forcing, and web HMI code injection RCE. Shortcut: `./lab start openplc-modbus` | **Ports**: `502`, `8123`.
* **Vulnerable MQTT Broker & Telemetry Gateway** ([`10_iot_firmware_hardware_hacking/vulnerable_mqtt_broker`](Real_World_Industry_Labs/10_iot_firmware_hardware_hacking/vulnerable_mqtt_broker)): Insecure anonymous MQTT broker, wildcard topic eavesdropping (`#`), and actuator command injection. Shortcut: `./lab start iot-mqtt` | **Ports**: `1883`, `9001`.
* **GoAhead Embedded Web Server LD_PRELOAD RCE** ([`10_iot_firmware_hardware_hacking/goahead_cve_2017_17562`](Real_World_Industry_Labs/10_iot_firmware_hardware_hacking/goahead_cve_2017_17562)): IoT webserver CGI parameter injection leading to dynamic linker hijacking (CVE-2017-17562). Shortcut: `./lab start goahead-rce` | **Port**: `8149`.

---

## Syllabus Tracks (`Classes/`)

### 01. Cyber Security Ethical Hacking (`Classes/01_cyber_security_ethical_hacking/`)
- [`scanning_and_recon`](Classes/01_cyber_security_ethical_hacking/scanning_and_recon): `./lab start recon` (Port 8081).
- [`metasploit_and_system_hacking`](Classes/01_cyber_security_ethical_hacking/metasploit_and_system_hacking): `./lab start meta-target` (Ports 2121, 2222, 2323, 8082).
- [`web_basics_dvwa`](Classes/01_cyber_security_ethical_hacking/web_basics_dvwa): `./lab start dvwa-basic` (Port 8083).
- [`ctf_intro_challenges`](Classes/01_cyber_security_ethical_hacking/ctf_intro_challenges): `./lab start ctfd` (Port 8000).

### 02. Web Penetration Tester (`Classes/02_web_penetration_tester/`)
> ** PortSwigger Easy-to-Hard Roadmap**: See [`Classes/02_web_penetration_tester/PORTSWIGGER_ROADMAP.md`](Classes/02_web_penetration_tester/PORTSWIGGER_ROADMAP.md) for full Apprentice Practitioner Expert challenges.
- [`rest_vampi`](Classes/02_web_penetration_tester/03_api_penetration_testing/rest_vampi): `./lab start vampi` (Port 5000).
- [`graphql_dvga`](Classes/02_web_penetration_tester/03_api_penetration_testing/graphql_dvga): `./lab start dvga` (Port 5013).
- [`crapi_microservices`](Classes/02_web_penetration_tester/03_api_penetration_testing/crapi_microservices): `./lab start crapi` (Ports 8888, 8025).
- [`juice_shop`](Classes/02_web_penetration_tester/06_owasp_top_10/juice_shop): `./lab start juice-shop` (Port 3000).
- [`railsgoat`](Classes/02_web_penetration_tester/06_owasp_top_10/railsgoat): `./lab start railsgoat` (Port 8109).
- [`webgoat`](Classes/02_web_penetration_tester/06_owasp_top_10/webgoat): `./lab start webgoat` (Ports 8099 WebGoat, 9090 WebWolf).
- [`authentication_lab`](Classes/02_web_penetration_tester/07_08_09_10_auth_and_access_control/authentication_lab): `./lab start auth` (Port 8084).
- [`request_smuggling_lab`](Classes/02_web_penetration_tester/09_http_request_smuggling/request_smuggling_lab): `./lab start smuggling` (Port 8108).
- [`ssti_jinja2`](Classes/02_web_penetration_tester/11_ssti_template_injection/ssti_jinja2): `./lab start ssti` (Port 8094).
- [`bwapp`](Classes/02_web_penetration_tester/12_13_14_15_client_side_attacks/bwapp): `./lab start client-bwapp` (Port 8085).
- [`vulnerable_wordpress`](Classes/02_web_penetration_tester/12_cms_security/vulnerable_wordpress): `./lab start wordpress` (Port 8107).
- [`dvws`](Classes/02_web_penetration_tester/15_websockets/dvws): `./lab start dvws` (Ports 8102 Web, 8103 WS).
- [`sqli_labs`](Classes/02_web_penetration_tester/16_advanced_sql_injection/sqli_labs): `./lab start sqli` (Port 8086).
- [`pickle_and_php`](Classes/02_web_penetration_tester/17_insecure_deserialization/pickle_and_php): `./lab start deserialization` (Port 8095).
- [`dvwa_uploads_lfi`](Classes/02_web_penetration_tester/17_18_19_file_and_command_attacks/dvwa_uploads_lfi): `./lab start uploads-lfi` (Port 8087).
- [`log4shell_jndi`](Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/log4shell_jndi): `./lab start log4shell` (Port 8104).
- [`vulhub_server_attacks`](Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/vulhub_server_attacks): Server-side SSRF/XXE recipes.
- [`nosql_injection_lab`](Classes/02_web_penetration_tester/22_nosql_injection/nosql_injection_lab): `./lab start nosql` (Port 3001).
- [`node_proto_lab`](Classes/02_web_penetration_tester/25_prototype_pollution/node_proto_lab): `./lab start prototype-pollution` (Port 8096).
- [`race_concurrency_lab`](Classes/02_web_penetration_tester/27_race_conditions/race_concurrency_lab): `./lab start race-condition` (Port 8097).
- [`mutillidae`](Classes/02_web_penetration_tester/06_owasp_top_10/mutillidae): `./lab start mutillidae` (Port 8116).
- [`dvna`](Classes/02_web_penetration_tester/06_owasp_top_10/dvna): `./lab start dvna` (Port 8117).
- [`vulnerableapp`](Classes/02_web_penetration_tester/06_owasp_top_10/vulnerableapp): `./lab start vulnerableapp` (Port 8119).
- [`drupalgeddon2`](Classes/02_web_penetration_tester/12_cms_security/drupalgeddon2): `./lab start drupalgeddon2` (Port 8120).
- [`thinkphp_rce`](Classes/02_web_penetration_tester/12_cms_security/thinkphp_rce): `./lab start thinkphp-rce` (Port 8131).
- [`phpmyadmin_lfi`](Classes/02_web_penetration_tester/06_owasp_top_10/phpmyadmin_lfi): `./lab start phpmyadmin-lfi` (Port 8139).
- [`solr_velocity_ssti`](Classes/02_web_penetration_tester/11_ssti_template_injection/solr_velocity_ssti): `./lab start solr-velocity` (Port 8130).
- [`php_cgi_rce`](Classes/02_web_penetration_tester/06_owasp_top_10/php_cgi_rce): `./lab start php-cgi-rce` (Port 8132).
- [`imagetragick_rce`](Classes/02_web_penetration_tester/17_18_19_file_and_command_attacks/imagetragick_rce): `./lab start imagetragick` (Port 8133).
- [`ghostscript_sandbox_rce`](Classes/02_web_penetration_tester/17_18_19_file_and_command_attacks/ghostscript_sandbox_rce): `./lab start ghostscript-rce` (Port 8134).
- [`tomcat_put_jsp_upload`](Classes/02_web_penetration_tester/17_18_19_file_and_command_attacks/tomcat_put_jsp_upload): `./lab start tomcat-put-rce` (Port 8129).
- [`shiro_rememberme_deserialization`](Classes/02_web_penetration_tester/17_insecure_deserialization/shiro_rememberme_deserialization): `./lab start shiro-deserialization` (Port 8127).
- [`fastjson_autotype_deserialization`](Classes/02_web_penetration_tester/17_insecure_deserialization/fastjson_autotype_deserialization): `./lab start fastjson-deserialization` (Port 8128).
- [`apache_path_traversal`](Classes/02_web_penetration_tester/06_owasp_top_10/apache_path_traversal): `./lab start apache-traversal` (Port 8138).
- [`shellshock`](Classes/02_web_penetration_tester/06_owasp_top_10/shellshock): `./lab start shellshock` (Port 8137).
- [`couchdb_erlang_rce`](Classes/02_web_penetration_tester/22_nosql_injection/couchdb_erlang_rce): `./lab start couchdb-privesc` (Port 5984).
- [`elasticsearch_mvel_rce`](Classes/02_web_penetration_tester/22_nosql_injection/elasticsearch_mvel_rce): `./lab start elasticsearch-rce` (Port 9200).
- [`mongo_express_rce`](Classes/02_web_penetration_tester/22_nosql_injection/mongo_express_rce): `./lab start mongo-express-rce` (Port 8140).
- [`uwsgi_php_traversal`](Classes/02_web_penetration_tester/06_owasp_top_10/uwsgi_php_traversal): `./lab start uwsgi-traversal` (Port 8153).
- [`kibana_prototype_pollution_rce`](Classes/02_web_penetration_tester/25_prototype_pollution/kibana_prototype_pollution_rce): `./lab start kibana-prototype-rce` (Port 8155).
- [`joomla_sqli_cve_2017_8917`](Classes/02_web_penetration_tester/12_cms_security/joomla_sqli_cve_2017_8917): `./lab start joomla-sqli` (Port 8156).
- [`appweb_auth_bypass`](Classes/02_web_penetration_tester/07_08_09_10_auth_and_access_control/appweb_auth_bypass): `./lab start appweb-auth-bypass` (Port 8159).
- [`influxdb_jwt_bypass`](Classes/02_web_penetration_tester/22_nosql_injection/influxdb_jwt_bypass): `./lab start influxdb-jwt-bypass` (Port 8164).
- [`ffmpeg_hls_ssrf`](Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/ffmpeg_hls_ssrf): `./lab start ffmpeg-hls-ssrf` (Port 8165).
- [`drupalgeddon1`](Classes/02_web_penetration_tester/12_cms_security/drupalgeddon1): `./lab start drupalgeddon1` (Port 8166).
- [`spring_jackson_rce`](Classes/02_web_penetration_tester/17_insecure_deserialization/spring_jackson_rce): `./lab start spring-jackson-rce` (Port 8171).
- [`ecshop_deserialization_rce`](Classes/02_web_penetration_tester/17_insecure_deserialization/ecshop_deserialization_rce): `./lab start ecshop-deserialization` (Port 8172).
- [`discuz_cookie_rce`](Classes/02_web_penetration_tester/12_cms_security/discuz_cookie_rce): `./lab start discuz-cookie-rce` (Port 8173).
- [`php_xxe_injection`](Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/php_xxe_injection): `./lab start php-xxe-injection` (Port 8180).
- [`django_trailing_redirect`](Classes/02_web_penetration_tester/06_owasp_top_10/django_trailing_redirect): `./lab start django-trailing-redirect` (Port 8181).
- [`h2database_jndi_rce`](Classes/02_web_penetration_tester/16_advanced_sql_injection/h2database_jndi_rce): `./lab start h2database-rce` (Port 8184).
- [`laravel_ignition_rce`](Classes/02_web_penetration_tester/06_owasp_top_10/laravel_ignition_rce): `./lab start laravel-ignition-rce` (Port 8187).
- [`adminer_arbitrary_file_read`](Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/adminer_arbitrary_file_read): `./lab start adminer-ssrf` (Port 8189).
- [`solr_cve_2017_12629`](Classes/02_web_penetration_tester/11_ssti_template_injection/solr_cve_2017_12629): `./lab start solr-runexec-rce` (Port 8198).
- [`couchdb_erlang_cookie_rce`](Classes/02_web_penetration_tester/22_nosql_injection/couchdb_erlang_cookie_rce): `./lab start couchdb-cookie-rce` (Port 8199).
- [`mojarra_jsf_viewstate_rce`](Classes/02_web_penetration_tester/17_insecure_deserialization/mojarra_jsf_viewstate_rce): `./lab start mojarra-viewstate-rce` (Port 8201).
- [`xstream_cve_2021_29505`](Classes/02_web_penetration_tester/17_insecure_deserialization/xstream_cve_2021_29505): `./lab start xstream-deserialization-rce` (Port 8202).
- [`fastjson_cve_2019_12086`](Classes/02_web_penetration_tester/17_insecure_deserialization/fastjson_cve_2019_12086): `./lab start fastjson-autotype-bypass` (Port 8205).
- [`metabase_cve_2021_41277`](Classes/02_web_penetration_tester/06_owasp_top_10/metabase_cve_2021_41277): `./lab start metabase-fileread` (Port 8215).
- [`solr_dataimport_rce`](Classes/02_web_penetration_tester/11_ssti_template_injection/solr_dataimport_rce): `./lab start solr-dataimport-rce` (Port 8216).
- [`solr_remote_streaming`](Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/solr_remote_streaming): `./lab start solr-streaming-fileread` (Port 8217).
- [`phpmailer_cve_2017_5223`](Classes/02_web_penetration_tester/06_owasp_top_10/phpmailer_cve_2017_5223): `./lab start phpmailer-file-disclosure` (Port 8218).
- [`shiro_path_traversal_bypass`](Classes/02_web_penetration_tester/07_08_09_10_auth_and_access_control/shiro_path_traversal_bypass): `./lab start shiro-path-bypass` (Port 8219).
- [`nginx_insecure_configuration`](Classes/02_web_penetration_tester/06_owasp_top_10/nginx_insecure_configuration): `./lab start nginx-misconfig` (Ports 8221, 8223, 8224).
- [`ghostscript_cve_2019_6116`](Classes/02_web_penetration_tester/17_18_19_file_and_command_attacks/ghostscript_cve_2019_6116): `./lab start ghostscript-policy-bypass` (Port 8222).
- [`drupalgeddon3_cve_2018_7602`](Classes/02_web_penetration_tester/12_cms_security/drupalgeddon3_cve_2018_7602): `./lab start drupalgeddon3` (Port 8233).
- [`craftcms_cve_2023_41892`](Classes/02_web_penetration_tester/12_cms_security/craftcms_cve_2023_41892): `./lab start craftcms-rce` (Port 8234).
- [`django_cve_2018_14574`](Classes/02_web_penetration_tester/06_owasp_top_10/django_cve_2018_14574): `./lab start django-open-redirect` (Port 8235).
- [`django_cve_2019_14234`](Classes/02_web_penetration_tester/16_advanced_sql_injection/django_cve_2019_14234): `./lab start django-jsonfield-sqli` (Port 8236).
- [`django_cve_2021_35042`](Classes/02_web_penetration_tester/16_advanced_sql_injection/django_cve_2021_35042): `./lab start django-orderby-sqli` (Port 8237).
- [`django_cve_2022_34265`](Classes/02_web_penetration_tester/16_advanced_sql_injection/django_cve_2022_34265): `./lab start django-trunc-sqli` (Port 8238).
- [`discuz_x34_file_delete`](Classes/02_web_penetration_tester/12_cms_security/discuz_x34_file_delete): `./lab start discuz-file-delete` (Port 8239).
- [`php_81_backdoor_rce`](Classes/02_web_penetration_tester/06_owasp_top_10/php_81_backdoor_rce): `./lab start php-backdoor-rce` (Port 8248).
- [`php_imap_cve_2018_19518`](Classes/02_web_penetration_tester/06_owasp_top_10/php_imap_cve_2018_19518): `./lab start php-imap-rce` (Port 8249).
- [`php_xdebug_rce`](Classes/02_web_penetration_tester/06_owasp_top_10/php_xdebug_rce): `./lab start php-xdebug-rce` (Port 8250).
- [`nginx_cve_2013_4547`](Classes/02_web_penetration_tester/06_owasp_top_10/nginx_cve_2013_4547): `./lab start nginx-nullbyte-rce` (Port 8251).
- [`nginx_cve_2017_7529`](Classes/02_web_penetration_tester/06_owasp_top_10/nginx_cve_2017_7529): `./lab start nginx-range-leak` (Port 8252).
- [`elasticsearch_groovy_cve_2015_1427`](Classes/02_web_penetration_tester/22_nosql_injection/elasticsearch_groovy_cve_2015_1427): `./lab start elasticsearch-groovy-rce` (Port 8253).
- [`fastjson_cve_2022_25845`](Classes/02_web_penetration_tester/17_insecure_deserialization/fastjson_cve_2022_25845): `./lab start fastjson-1283-rce` (Port 8254).
- [`solr_xxe_cve_2017_12629`](Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/solr_xxe_cve_2017_12629): `./lab start solr-xxe-injection` (Port 8255).
- [`adminer_ssrf_cve_2021_21311`](Classes/02_web_penetration_tester/20_21_24_server_side_ssrf_xxe_ssti/adminer_ssrf_cve_2021_21311): `./lab start adminer-ssrf-bypass` (Port 8258).
- [`cmsms_sqli_cve_2019_9053`](Classes/02_web_penetration_tester/16_advanced_sql_injection/cmsms_sqli_cve_2019_9053): `./lab start cmsms-blind-sqli` (Port 8259).
- [`cmsms_deserialization_cve_2021_26120`](Classes/02_web_penetration_tester/17_insecure_deserialization/cmsms_deserialization_cve_2021_26120): `./lab start cmsms-object-rce` (Port 8260).
- [`owncloud_cve_2023_49103`](Classes/02_web_penetration_tester/12_cms_security/owncloud_cve_2023_49103): `./lab start owncloud-graphapi-leak` (Port 8266).
- [`php_fpm_cve_2019_11043`](Classes/02_web_penetration_tester/06_owasp_top_10/php_fpm_cve_2019_11043): `./lab start php-fpm-underflow-rce` (Port 8267).
- [`tikiwiki_cve_2020_15906`](Classes/02_web_penetration_tester/12_cms_security/tikiwiki_cve_2020_15906): `./lab start tikiwiki-auth-bypass` (Port 8268).

- [`cgi_cve-2016-5385`](Classes/02_web_penetration_tester/12_cms_security/cgi_cve-2016-5385): `./lab start cgi-cve-2016-5385` (Port 8269).
- [`craftcms_cve-2024-56145`](Classes/02_web_penetration_tester/12_cms_security/craftcms_cve-2024-56145): `./lab start craftcms-cve-2024-56145` (Port 8270).
- [`craftcms_cve-2025-32432`](Classes/02_web_penetration_tester/12_cms_security/craftcms_cve-2025-32432): `./lab start craftcms-cve-2025-32432` (Port 8271).
- [`discuz_wooyun-2010-080723`](Classes/02_web_penetration_tester/12_cms_security/discuz_wooyun-2010-080723): `./lab start discuz-wooyun-2010-080723` (Port 8272).
- [`discuz_x3_4-arbitrary-file-deletion`](Classes/02_web_penetration_tester/12_cms_security/discuz_x3_4-arbitrary-file-deletion): `./lab start discuz-x3.4-arbitrary-file-d` (Port 8273).
- [`django_cve-2017-12794`](Classes/02_web_penetration_tester/12_cms_security/django_cve-2017-12794): `./lab start django-cve-2017-12794` (Port 8274).
- [`django_cve-2020-9402`](Classes/02_web_penetration_tester/12_cms_security/django_cve-2020-9402): `./lab start django-cve-2020-9402` (Port 8275).
- [`drupal_cve-2017-6920`](Classes/02_web_penetration_tester/12_cms_security/drupal_cve-2017-6920): `./lab start drupal-cve-2017-6920` (Port 8276).
- [`drupal_cve-2019-6339`](Classes/02_web_penetration_tester/12_cms_security/drupal_cve-2019-6339): `./lab start drupal-cve-2019-6339` (Port 8277).
- [`drupal_cve-2019-6341`](Classes/02_web_penetration_tester/12_cms_security/drupal_cve-2019-6341): `./lab start drupal-cve-2019-6341` (Port 8278).
- [`ecshop_collection_list-sqli`](Classes/02_web_penetration_tester/12_cms_security/ecshop_collection_list-sqli): `./lab start ecshop-collection_list-sqli` (Port 8279).
- [`ecshop_xianzhi-2017-02-82239600`](Classes/02_web_penetration_tester/12_cms_security/ecshop_xianzhi-2017-02-82239600): `./lab start ecshop-xianzhi-2017-02-82239` (Port 8280).
- [`electron_cve-2018-1000006`](Classes/02_web_penetration_tester/12_cms_security/electron_cve-2018-1000006): `./lab start electron-cve-2018-1000006` (Port 8281).
- [`electron_cve-2018-15685`](Classes/02_web_penetration_tester/12_cms_security/electron_cve-2018-15685): `./lab start electron-cve-2018-15685` (Port 8282).
- [`flask_ssti`](Classes/02_web_penetration_tester/12_cms_security/flask_ssti): `./lab start flask-ssti` (Port 8283).
- [`imagemagick_cve-2020-29599`](Classes/02_web_penetration_tester/12_cms_security/imagemagick_cve-2020-29599): `./lab start imagemagick-cve-2020-29599` (Port 8284).
- [`imagemagick_cve-2022-44268`](Classes/02_web_penetration_tester/12_cms_security/imagemagick_cve-2022-44268): `./lab start imagemagick-cve-2022-44268` (Port 8285).
- [`joomla_cve-2015-8562`](Classes/02_web_penetration_tester/12_cms_security/joomla_cve-2015-8562): `./lab start joomla-cve-2015-8562` (Port 8286).
- [`joomla_cve-2023-23752`](Classes/02_web_penetration_tester/12_cms_security/joomla_cve-2023-23752): `./lab start joomla-cve-2023-23752` (Port 8287).
- [`livewire_cve-2025-54068`](Classes/02_web_penetration_tester/12_cms_security/livewire_cve-2025-54068): `./lab start livewire-cve-2025-54068` (Port 8288).
- [`magento_2_2-sqli`](Classes/02_web_penetration_tester/12_cms_security/magento_2_2-sqli): `./lab start magento-2.2-sqli` (Port 8289).
- [`node_cve-2017-16082`](Classes/02_web_penetration_tester/12_cms_security/node_cve-2017-16082): `./lab start node-cve-2017-16082` (Port 8290).
- [`php_8_1-backdoor`](Classes/02_web_penetration_tester/12_cms_security/php_8_1-backdoor): `./lab start php-8.1-backdoor` (Port 8291).
- [`php_cve-2024-2961`](Classes/02_web_penetration_tester/12_cms_security/php_cve-2024-2961): `./lab start php-cve-2024-2961` (Port 8292).
- [`php_fpm`](Classes/02_web_penetration_tester/12_cms_security/php_fpm): `./lab start php-fpm` (Port 8293).
- [`php_inclusion`](Classes/02_web_penetration_tester/12_cms_security/php_inclusion): `./lab start php-inclusion` (Port 8294).
- [`php_php_xxe`](Classes/02_web_penetration_tester/12_cms_security/php_php_xxe): `./lab start php-php_xxe` (Port 8295).
- [`phpmyadmin_cve-2016-5734`](Classes/02_web_penetration_tester/12_cms_security/phpmyadmin_cve-2016-5734): `./lab start phpmyadmin-cve-2016-5734` (Port 8297).
- [`phpmyadmin_wooyun-2016-199433`](Classes/02_web_penetration_tester/12_cms_security/phpmyadmin_wooyun-2016-199433): `./lab start phpmyadmin-wooyun-2016-19943` (Port 8298).
- [`rails_cve-2018-3760`](Classes/02_web_penetration_tester/12_cms_security/rails_cve-2018-3760): `./lab start rails-cve-2018-3760` (Port 8299).
- [`showdoc_3_2_5-sqli`](Classes/02_web_penetration_tester/12_cms_security/showdoc_3_2_5-sqli): `./lab start showdoc-3.2.5-sqli` (Port 8300).
- [`showdoc_cnvd-2020-26585`](Classes/02_web_penetration_tester/12_cms_security/showdoc_cnvd-2020-26585): `./lab start showdoc-cnvd-2020-26585` (Port 8301).
- [`thinkphp_2-rce`](Classes/02_web_penetration_tester/12_cms_security/thinkphp_2-rce): `./lab start thinkphp-2-rce` (Port 8302).
- [`thinkphp_5-rce`](Classes/02_web_penetration_tester/12_cms_security/thinkphp_5-rce): `./lab start thinkphp-5-rce` (Port 8303).

- [`laravel_cve_2021_3129`](Classes/02_web_penetration_tester/12_cms_security/laravel_cve_2021_3129): `./lab start laravel-cve-2021-3129` (Port 8422).
- [`next.js_cve_2025_29927`](Classes/02_web_penetration_tester/12_cms_security/next.js_cve_2025_29927): `./lab start next.js-cve-2025-29927` (Port 8423).
- [`nginx-ui_cve_2026_27944`](Classes/02_web_penetration_tester/12_cms_security/nginx-ui_cve_2026_27944): `./lab start nginx-ui-cve-2026-27944` (Port 8424).
- [`openclaw_cve_2026_25253`](Classes/02_web_penetration_tester/12_cms_security/openclaw_cve_2026_25253): `./lab start openclaw-cve-2026-25253` (Port 8425).
- [`pdfjs_cve_2024_4367`](Classes/02_web_penetration_tester/12_cms_security/pdfjs_cve_2024_4367): `./lab start pdfjs-cve-2024-4367` (Port 8426).
- [`pgadmin_cve_2023_5002`](Classes/02_web_penetration_tester/12_cms_security/pgadmin_cve_2023_5002): `./lab start pgadmin-cve-2023-5002` (Port 8427).
- [`pgadmin_cve_2025_13780`](Classes/02_web_penetration_tester/12_cms_security/pgadmin_cve_2025_13780): `./lab start pgadmin-cve-2025-13780` (Port 8428).
- [`pgadmin_cve_2025_2945`](Classes/02_web_penetration_tester/12_cms_security/pgadmin_cve_2025_2945): `./lab start pgadmin-cve-2025-2945` (Port 8429).
- [`php_cve_2012_1823`](Classes/02_web_penetration_tester/12_cms_security/php_cve_2012_1823): `./lab start php-cve-2012-1823` (Port 8430).
- [`phpmyadmin_cve_2018_12613`](Classes/02_web_penetration_tester/12_cms_security/phpmyadmin_cve_2018_12613): `./lab start phpmyadmin-cve-2018-12613` (Port 8431).
- [`phpunit_cve_2017_9841`](Classes/02_web_penetration_tester/12_cms_security/phpunit_cve_2017_9841): `./lab start phpunit-cve-2017-9841` (Port 8432).
- [`polkit_cve_2021_4034`](Classes/02_web_penetration_tester/12_cms_security/polkit_cve_2021_4034): `./lab start polkit-cve-2021-4034` (Port 8433).
- [`python_cve_2024_23334`](Classes/02_web_penetration_tester/12_cms_security/python_cve_2024_23334): `./lab start python-cve-2024-23334` (Port 8434).
- [`python_pil_cve_2017_8291`](Classes/02_web_penetration_tester/12_cms_security/python_pil_cve_2017_8291): `./lab start python-pil-cve-2017-8291` (Port 8435).
- [`python_unpickle`](Classes/02_web_penetration_tester/12_cms_security/python_unpickle): `./lab start python-unpickle` (Port 8436).
- [`react_cve_2025_55182`](Classes/02_web_penetration_tester/12_cms_security/react_cve_2025_55182): `./lab start react-cve-2025-55182` (Port 8437).
- [`rocketchat_cve_2021_22911`](Classes/02_web_penetration_tester/12_cms_security/rocketchat_cve_2021_22911): `./lab start rocketchat-cve-2021-22911` (Port 8438).
- [`ruby_cve_2017_17405`](Classes/02_web_penetration_tester/12_cms_security/ruby_cve_2017_17405): `./lab start ruby-cve-2017-17405` (Port 8439).

### 03. Network Security (`Classes/03_network_security/`)
- [`dns_tunneling`](Classes/03_network_security/dns_tunneling): `./lab start dns-tunnel` (Port 5353/udp).

- [`1panel_cve-2024-39907`](Real_World_Industry_Labs/09_infrastructure_server_cves/1panel_cve-2024-39907): `./lab start 1panel-cve-2024-39907` (Port 8337).
- [`airflow_cve-2020-11981`](Real_World_Industry_Labs/09_infrastructure_server_cves/airflow_cve-2020-11981): `./lab start airflow-cve-2020-11981` (Port 8338).
- [`aj-report_cnvd-2024-15077`](Real_World_Industry_Labs/09_infrastructure_server_cves/aj-report_cnvd-2024-15077): `./lab start aj-report-cnvd-2024-15077` (Port 8339).
- [`apereo-cas_4_1-rce`](Real_World_Industry_Labs/09_infrastructure_server_cves/apereo-cas_4_1-rce): `./lab start apereo-cas-4.1-rce` (Port 8340).
- [`apisix_cve-2020-13945`](Real_World_Industry_Labs/09_infrastructure_server_cves/apisix_cve-2020-13945): `./lab start apisix-cve-2020-13945` (Port 8341).
- [`budibase_cve-2026-31816`](Real_World_Industry_Labs/09_infrastructure_server_cves/budibase_cve-2026-31816): `./lab start budibase-cve-2026-31816` (Port 8343).
- [`cacti_cve-2023-39361`](Real_World_Industry_Labs/09_infrastructure_server_cves/cacti_cve-2023-39361): `./lab start cacti-cve-2023-39361` (Port 8344).
- [`cacti_cve-2025-24367`](Real_World_Industry_Labs/09_infrastructure_server_cves/cacti_cve-2025-24367): `./lab start cacti-cve-2025-24367` (Port 8345).
- [`celery_celery3_redis_unauth`](Real_World_Industry_Labs/09_infrastructure_server_cves/celery_celery3_redis_unauth): `./lab start celery-celery3_redis_unauth` (Port 8346).
- [`chartbrew_cve-2026-25887`](Real_World_Industry_Labs/09_infrastructure_server_cves/chartbrew_cve-2026-25887): `./lab start chartbrew-cve-2026-25887` (Port 8347).
- [`comfyui_cve-2025-67303`](Real_World_Industry_Labs/09_infrastructure_server_cves/comfyui_cve-2025-67303): `./lab start comfyui-cve-2025-67303` (Port 8348).
- [`comfyui_cve-2026-22777`](Real_World_Industry_Labs/09_infrastructure_server_cves/comfyui_cve-2026-22777): `./lab start comfyui-cve-2026-22777` (Port 8349).
- [`elasticsearch_wooyun-2015-110216`](Real_World_Industry_Labs/09_infrastructure_server_cves/elasticsearch_wooyun-2015-110216): `./lab start elasticsearch-wooyun-2015-11` (Port 8352).
- [`elfinder_cve-2021-32682`](Real_World_Industry_Labs/09_infrastructure_server_cves/elfinder_cve-2021-32682): `./lab start elfinder-cve-2021-32682` (Port 8353).
- [`erlang_cve-2025-32433`](Real_World_Industry_Labs/09_infrastructure_server_cves/erlang_cve-2025-32433): `./lab start erlang-cve-2025-32433` (Port 8354).
- [`geoserver_cve-2021-40822`](Real_World_Industry_Labs/09_infrastructure_server_cves/geoserver_cve-2021-40822): `./lab start geoserver-cve-2021-40822` (Port 8355).
- [`geoserver_cve-2022-24816`](Real_World_Industry_Labs/09_infrastructure_server_cves/geoserver_cve-2022-24816): `./lab start geoserver-cve-2022-24816` (Port 8356).
- [`geoserver_cve-2023-25157`](Real_World_Industry_Labs/09_infrastructure_server_cves/geoserver_cve-2023-25157): `./lab start geoserver-cve-2023-25157` (Port 8357).
- [`git_cve-2017-8386`](Real_World_Industry_Labs/09_infrastructure_server_cves/git_cve-2017-8386): `./lab start git-cve-2017-8386` (Port 8358).
- [`gitea_1_4-rce`](Real_World_Industry_Labs/09_infrastructure_server_cves/gitea_1_4-rce): `./lab start gitea-1.4-rce` (Port 8359).
- [`gotenberg_cve-2026-40281`](Real_World_Industry_Labs/09_infrastructure_server_cves/gotenberg_cve-2026-40281): `./lab start gotenberg-cve-2026-40281` (Port 8360).
- [`gradio_cve-2023-51449`](Real_World_Industry_Labs/09_infrastructure_server_cves/gradio_cve-2023-51449): `./lab start gradio-cve-2023-51449` (Port 8361).
- [`gradio_cve-2024-1561`](Real_World_Industry_Labs/09_infrastructure_server_cves/gradio_cve-2024-1561): `./lab start gradio-cve-2024-1561` (Port 8362).
- [`grafana_cve-2024-9264`](Real_World_Industry_Labs/09_infrastructure_server_cves/grafana_cve-2024-9264): `./lab start grafana-cve-2024-9264` (Port 8363).
- [`grafana_admin-ssrf`](Real_World_Industry_Labs/09_infrastructure_server_cves/grafana_admin-ssrf): `./lab start grafana-admin-ssrf` (Port 8364).
- [`hadoop_unauthorized-yarn`](Real_World_Industry_Labs/09_infrastructure_server_cves/hadoop_unauthorized-yarn): `./lab start hadoop-unauthorized-yarn` (Port 8365).
- [`hertzbeat_cve-2024-42323`](Real_World_Industry_Labs/09_infrastructure_server_cves/hertzbeat_cve-2024-42323): `./lab start hertzbeat-cve-2024-42323` (Port 8366).
- [`httpd_cve-2021-40438`](Real_World_Industry_Labs/09_infrastructure_server_cves/httpd_cve-2021-40438): `./lab start httpd-cve-2021-40438` (Port 8367).
- [`httpd_apache_parsing_vulnerability`](Real_World_Industry_Labs/09_infrastructure_server_cves/httpd_apache_parsing_vulnerability): `./lab start httpd-apache_parsing_vulnera` (Port 8368).
- [`httpd_ssi-rce`](Real_World_Industry_Labs/09_infrastructure_server_cves/httpd_ssi-rce): `./lab start httpd-ssi-rce` (Port 8369).
- [`hugegraph_cve-2024-43441`](Real_World_Industry_Labs/09_infrastructure_server_cves/hugegraph_cve-2024-43441): `./lab start hugegraph-cve-2024-43441` (Port 8370).
- [`inetutils_cve-2026-24061`](Real_World_Industry_Labs/09_infrastructure_server_cves/inetutils_cve-2026-24061): `./lab start inetutils-cve-2026-24061` (Port 8371).

### 04. Network Penetration Tester (`Classes/04_network_penetration_tester/`)
- [`vulnerable_network_services_metasploitable2`](Classes/04_network_penetration_tester/vulnerable_network_services_metasploitable2): `./lab start metasploitable2`.
- [`linux_privilege_escalation`](Classes/04_network_penetration_tester/linux_privilege_escalation): `./lab start privesc-linux && ./lab shell privesc-linux`.
- [`samba_cry_remote_exploit`](Classes/04_network_penetration_tester/samba_cry_remote_exploit): `./lab start sambacry` (Port 4455).
- [`active_directory_goad_ldap`](Classes/04_network_penetration_tester/active_directory_goad_ldap): `./lab start ad-ldap` (Port 3893).
- [`active_directory_samba_kerberos`](Classes/04_network_penetration_tester/active_directory_samba_kerberos): `./lab start ad-kerberos` (Ports 88 Kerberos, 389 LDAP, 445 SMB).
- [`struts2_s2045`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2045): `./lab start struts2-s2045` (Port 8121).
- [`redis_unauthorized`](Classes/04_network_penetration_tester/enterprise_middleware/redis_unauthorized): `./lab start redis-unauth` (Port 6379).
- [`jenkins_cve_2024_23897`](Classes/04_network_penetration_tester/enterprise_middleware/jenkins_cve_2024_23897): `./lab start jenkins-cve` (Ports 8122, 50000).
- [`spring_cloud_gateway_rce`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cloud_gateway_rce): `./lab start spring-gateway` (Port 8125).
- [`activemq_upload_rce`](Classes/04_network_penetration_tester/enterprise_middleware/activemq_upload_rce): `./lab start activemq-upload` (Ports 8126, 61616).
- [`weblogic_wls_wsat_rce`](Classes/04_network_penetration_tester/enterprise_middleware/weblogic_wls_wsat_rce): `./lab start weblogic-rce` (Port 7001).
- [`heartbleed_openssl`](Classes/04_network_penetration_tester/enterprise_middleware/heartbleed_openssl): `./lab start heartbleed` (Port 8443).
- [`flink_path_traversal`](Classes/04_network_penetration_tester/enterprise_middleware/flink_path_traversal): `./lab start flink-traversal` (Port 8135).
- [`webmin_backdoor_rce`](Classes/04_network_penetration_tester/enterprise_middleware/webmin_backdoor_rce): `./lab start webmin-backdoor` (Port 8141).
- [`libssh_auth_bypass`](Classes/04_network_penetration_tester/libssh_auth_bypass): `./lab start libssh-auth-bypass` (Port 8142).
- [`jboss_deserialization_rce`](Classes/04_network_penetration_tester/enterprise_middleware/jboss_deserialization_rce): `./lab start jboss-deserialization` (Port 8143).
- [`aria2_rpc_rce`](Classes/04_network_penetration_tester/aria2_rpc_rce): `./lab start aria2-rce` (Port 8146).
- [`mini_httpd_traversal`](Classes/04_network_penetration_tester/mini_httpd_traversal): `./lab start mini-httpd-traversal` (Port 8150).
- [`spring_messaging_rce`](Classes/04_network_penetration_tester/enterprise_middleware/spring_messaging_rce): `./lab start spring-messaging-rce` (Port 8151).
- [`spring_data_commons_rce`](Classes/04_network_penetration_tester/enterprise_middleware/spring_data_commons_rce): `./lab start spring-data-commons-rce` (Port 8152).
- [`rsync_unauthorized_rce`](Classes/04_network_penetration_tester/rsync_unauthorized_rce): `./lab start rsync-unauth` (Port 8154).
- [`confluence_ognl_rce`](Classes/04_network_penetration_tester/enterprise_middleware/confluence_ognl_rce): `./lab start confluence-ognl-rce` (Port 8158).
- [`openssh_user_enum`](Classes/04_network_penetration_tester/openssh_user_enum): `./lab start openssh-user-enum` (Port 8160).
- [`glassfish_arbitrary_file_read`](Classes/04_network_penetration_tester/enterprise_middleware/glassfish_arbitrary_file_read): `./lab start glassfish-traversal` (Port 8163).
- [`coldfusion_file_upload_rce`](Classes/04_network_penetration_tester/enterprise_middleware/coldfusion_file_upload_rce): `./lab start coldfusion-rce` (Port 8167).
- [`spring_webflow_rce`](Classes/04_network_penetration_tester/enterprise_middleware/spring_webflow_rce): `./lab start spring-webflow-rce` (Port 8169).
- [`struts2_s2005`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2005): `./lab start struts2-s2005` (Port 8174).
- [`struts2_s2008`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2008): `./lab start struts2-s2008` (Port 8175).
- [`struts2_s2009`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2009): `./lab start struts2-s2009` (Port 8176).
- [`struts2_s2013`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2013): `./lab start struts2-s2013` (Port 8177).
- [`jmeter_rmi_rce`](Classes/04_network_penetration_tester/jmeter_rmi_rce): `./lab start jmeter-rmi-rce` (Ports 8178, 1099).
- [`mysql_auth_bypass`](Classes/04_network_penetration_tester/mysql_auth_bypass): `./lab start mysql-auth-bypass` (Port 8179).
- [`openfire_admin_rce`](Classes/04_network_penetration_tester/enterprise_middleware/openfire_admin_rce): `./lab start openfire-rce` (Port 8185).
- [`supervisor_xmlrpc_rce`](Classes/04_network_penetration_tester/enterprise_middleware/supervisor_xmlrpc_rce): `./lab start supervisor-rce` (Port 8191).
- [`opensmtpd_mail_rce`](Classes/04_network_penetration_tester/opensmtpd_mail_rce): `./lab start opensmtpd-rce` (Ports 8192, 25).
- [`spring_webmvc_spring4shell`](Classes/04_network_penetration_tester/enterprise_middleware/spring_webmvc_spring4shell): `./lab start spring4shell-rce` (Port 8194).
- [`spring_cloud_function_rce`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cloud_function_rce): `./lab start spring-function-rce` (Port 8195).
- [`struts2_s2057`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2057): `./lab start struts2-s2057` (Port 8196).
- [`struts2_s2052`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2052): `./lab start struts2-s2052` (Port 8197).
- [`weblogic_cve_2020_14882`](Classes/04_network_penetration_tester/enterprise_middleware/weblogic_cve_2020_14882): `./lab start weblogic-console-rce` (Port 8203).
- [`activemq_cve_2023_46604`](Classes/04_network_penetration_tester/enterprise_middleware/activemq_cve_2023_46604): `./lab start activemq-openwire-rce` (Ports 8204, 61617).
- [`struts2_s2048`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2048): `./lab start struts2-s2048` (Port 8209).
- [`struts2_s2053`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2053): `./lab start struts2-s2053` (Port 8210).
- [`struts2_s2059`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2059): `./lab start struts2-s2059` (Port 8211).
- [`struts2_s2061`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2061): `./lab start struts2-s2061` (Port 8212).
- [`spring_data_rest_rce`](Classes/04_network_penetration_tester/enterprise_middleware/spring_data_rest_rce): `./lab start spring-data-rest-rce` (Port 8213).
- [`spring_security_regex_bypass`](Classes/04_network_penetration_tester/enterprise_middleware/spring_security_regex_bypass): `./lab start spring-regex-bypass` (Port 8214).
- [`ofbiz_xmlrpc_deserialization`](Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_xmlrpc_deserialization): `./lab start ofbiz-xmlrpc-rce` (Port 8220).
- [`redis_cve_2022_0543`](Classes/04_network_penetration_tester/enterprise_middleware/redis_cve_2022_0543): `./lab start redis-lua-escape` (Port 8232).
- [`dubbo_cve_2019_17564`](Classes/04_network_penetration_tester/enterprise_middleware/dubbo_cve_2019_17564): `./lab start dubbo-remoting-rce` (Port 8240).
- [`unomi_cve_2020_13942`](Classes/04_network_penetration_tester/enterprise_middleware/unomi_cve_2020_13942): `./lab start unomi-mvel-rce` (Port 8241).
- [`hugegraph_cve_2024_27348`](Classes/04_network_penetration_tester/enterprise_middleware/hugegraph_cve_2024_27348): `./lab start hugegraph-gremlin-rce` (Port 8242).
- [`tomcat_ghostcat_cve_2020_1938`](Classes/04_network_penetration_tester/enterprise_middleware/tomcat_ghostcat_cve_2020_1938): `./lab start tomcat-ghostcat-ajp` (Ports 8243, 8244).
- [`activemq_cve_2015_5254`](Classes/04_network_penetration_tester/enterprise_middleware/activemq_cve_2015_5254): `./lab start activemq-objectmessage-rce` (Ports 8245, 61618).
- [`postgres_cve_2019_9193`](Classes/04_network_penetration_tester/enterprise_middleware/postgres_cve_2019_9193): `./lab start postgres-copy-rce` (Port 8246).
- [`apache_cxf_cve_2024_28752`](Classes/04_network_penetration_tester/enterprise_middleware/apache_cxf_cve_2024_28752): `./lab start cxf-ssrf-rce` (Port 8247).
- [`activemq_cve_2022_41678`](Classes/04_network_penetration_tester/enterprise_middleware/activemq_cve_2022_41678): `./lab start activemq-jolokia-rce` (Ports 8256, 61619).
- [`activemq_cve_2024_32114`](Classes/04_network_penetration_tester/enterprise_middleware/activemq_cve_2024_32114): `./lab start activemq-jolokia-filewrite` (Ports 8257, 61620).
- [`jenkins_cve_2017_1000353`](Classes/04_network_penetration_tester/enterprise_middleware/jenkins_cve_2017_1000353): `./lab start jenkins-signedobject-rce` (Ports 8261, 50003).
- [`jenkins_stapler_cve_2018_1000861`](Classes/04_network_penetration_tester/enterprise_middleware/jenkins_stapler_cve_2018_1000861): `./lab start jenkins-stapler-rce` (Ports 8262, 50004).
- [`jetty_cve_2021_28164`](Classes/04_network_penetration_tester/enterprise_middleware/jetty_cve_2021_28164): `./lab start jetty-normalize-fileread` (Port 8263).
- [`jetty_cve_2021_34429`](Classes/04_network_penetration_tester/enterprise_middleware/jetty_cve_2021_34429): `./lab start jetty-u002e-bypass` (Port 8264).
- [`neo4j_cypher_cve_2021_34371`](Classes/04_network_penetration_tester/enterprise_middleware/neo4j_cypher_cve_2021_34371): `./lab start neo4j-cypher-sqli` (Port 8265).

- [`coldfusion_cve-2017-3066`](Classes/04_network_penetration_tester/enterprise_middleware/coldfusion_cve-2017-3066): `./lab start coldfusion-cve-2017-3066` (Port 8304).
- [`coldfusion_cve-2023-26360`](Classes/04_network_penetration_tester/enterprise_middleware/coldfusion_cve-2023-26360): `./lab start coldfusion-cve-2023-26360` (Port 8305).
- [`coldfusion_cve-2023-29300`](Classes/04_network_penetration_tester/enterprise_middleware/coldfusion_cve-2023-29300): `./lab start coldfusion-cve-2023-29300` (Port 8306).
- [`fastjson_1_2_24-rce`](Classes/04_network_penetration_tester/enterprise_middleware/fastjson_1_2_24-rce): `./lab start fastjson-1.2.24-rce` (Port 8307).
- [`fastjson_1_2_47-rce`](Classes/04_network_penetration_tester/enterprise_middleware/fastjson_1_2_47-rce): `./lab start fastjson-1.2.47-rce` (Port 8308).
- [`fastjson_1_2_83-rce`](Classes/04_network_penetration_tester/enterprise_middleware/fastjson_1_2_83-rce): `./lab start fastjson-1.2.83-rce` (Port 8309).
- [`h2database_cve-2018-10054`](Classes/04_network_penetration_tester/enterprise_middleware/h2database_cve-2018-10054): `./lab start h2database-cve-2018-10054` (Port 8310).
- [`h2database_cve-2022-23221`](Classes/04_network_penetration_tester/enterprise_middleware/h2database_cve-2022-23221): `./lab start h2database-cve-2022-23221` (Port 8311).
- [`jboss_cve-2017-7504`](Classes/04_network_penetration_tester/enterprise_middleware/jboss_cve-2017-7504): `./lab start jboss-cve-2017-7504` (Port 8312).
- [`jetty_cve-2021-28169`](Classes/04_network_penetration_tester/enterprise_middleware/jetty_cve-2021-28169): `./lab start jetty-cve-2021-28169` (Port 8313).
- [`ofbiz_cve-2023-51467`](Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_cve-2023-51467): `./lab start ofbiz-cve-2023-51467` (Port 8314).
- [`ofbiz_cve-2024-38856`](Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_cve-2024-38856): `./lab start ofbiz-cve-2024-38856` (Port 8315).
- [`ofbiz_cve-2024-45195`](Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_cve-2024-45195): `./lab start ofbiz-cve-2024-45195` (Port 8316).
- [`ofbiz_cve-2024-45507`](Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_cve-2024-45507): `./lab start ofbiz-cve-2024-45507` (Port 8317).
- [`postgres_cve-2018-1058`](Classes/04_network_penetration_tester/enterprise_middleware/postgres_cve-2018-1058): `./lab start postgres-cve-2018-1058` (Port 8318).
- [`redis_4-unacc`](Classes/04_network_penetration_tester/enterprise_middleware/redis_4-unacc): `./lab start redis-4-unacc` (Port 8319).
- [`rocketmq_cve-2023-33246`](Classes/04_network_penetration_tester/enterprise_middleware/rocketmq_cve-2023-33246): `./lab start rocketmq-cve-2023-33246` (Port 8320).
- [`rocketmq_cve-2023-37582`](Classes/04_network_penetration_tester/enterprise_middleware/rocketmq_cve-2023-37582): `./lab start rocketmq-cve-2023-37582` (Port 8321).
- [`solr_remote-streaming-fileread`](Classes/04_network_penetration_tester/enterprise_middleware/solr_remote-streaming-fileread): `./lab start solr-remote-streaming-filere` (Port 8322).
- [`spring_cve-2025-41242`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cve-2025-41242): `./lab start spring-cve-2025-41242` (Port 8323).
- [`struts2_s2-048`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2-048): `./lab start struts2-s2-048` (Port 8324).
- [`struts2_s2-052`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2-052): `./lab start struts2-s2-052` (Port 8325).
- [`struts2_s2-053`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2-053): `./lab start struts2-s2-053` (Port 8326).
- [`struts2_s2-066`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2-066): `./lab start struts2-s2-066` (Port 8327).
- [`struts2_s2-067`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2-067): `./lab start struts2-s2-067` (Port 8328).
- [`tomcat_cve-2026-34486`](Classes/04_network_penetration_tester/enterprise_middleware/tomcat_cve-2026-34486): `./lab start tomcat-cve-2026-34486` (Port 8329).
- [`tomcat_tomcat8`](Classes/04_network_penetration_tester/enterprise_middleware/tomcat_tomcat8): `./lab start tomcat-tomcat8` (Port 8330).
- [`weblogic_cve-2018-2628`](Classes/04_network_penetration_tester/enterprise_middleware/weblogic_cve-2018-2628): `./lab start weblogic-cve-2018-2628` (Port 8331).
- [`weblogic_cve-2018-2894`](Classes/04_network_penetration_tester/enterprise_middleware/weblogic_cve-2018-2894): `./lab start weblogic-cve-2018-2894` (Port 8332).
- [`weblogic_cve-2023-21839`](Classes/04_network_penetration_tester/enterprise_middleware/weblogic_cve-2023-21839): `./lab start weblogic-cve-2023-21839` (Port 8333).
- [`weblogic_ssrf`](Classes/04_network_penetration_tester/enterprise_middleware/weblogic_ssrf): `./lab start weblogic-ssrf` (Port 8334).
- [`weblogic_weak_password`](Classes/04_network_penetration_tester/enterprise_middleware/weblogic_weak_password): `./lab start weblogic-weak_password` (Port 8335).
- [`xstream_cve-2021-21351`](Classes/04_network_penetration_tester/enterprise_middleware/xstream_cve-2021-21351): `./lab start xstream-cve-2021-21351` (Port 8336).

- [`activemq_cve_2016_3088`](Classes/04_network_penetration_tester/enterprise_middleware/activemq_cve_2016_3088): `./lab start activemq-cve-2016-3088` (Port 8397).
- [`activemq_cve_2026_34197`](Classes/04_network_penetration_tester/enterprise_middleware/activemq_cve_2026_34197): `./lab start activemq-cve-2026-34197` (Port 8398).
- [`adminer_cve_2021_43008`](Classes/04_network_penetration_tester/enterprise_middleware/adminer_cve_2021_43008): `./lab start adminer-cve-2021-43008` (Port 8399).
- [`apache-druid_cve_2021_25646`](Classes/04_network_penetration_tester/enterprise_middleware/apache-druid_cve_2021_25646): `./lab start apache-druid-cve-2021-25646` (Port 8400).
- [`appweb_cve_2018_8715`](Classes/04_network_penetration_tester/enterprise_middleware/appweb_cve_2018_8715): `./lab start appweb-cve-2018-8715` (Port 8401).
- [`bash_cve_2014_6271`](Classes/04_network_penetration_tester/enterprise_middleware/bash_cve_2014_6271): `./lab start bash-cve-2014-6271` (Port 8402).
- [`coldfusion_cve_2010_2861`](Classes/04_network_penetration_tester/enterprise_middleware/coldfusion_cve_2010_2861): `./lab start coldfusion-cve-2010-2861` (Port 8403).
- [`drupal_cve_2014_3704`](Classes/04_network_penetration_tester/enterprise_middleware/drupal_cve_2014_3704): `./lab start drupal-cve-2014-3704` (Port 8404).
- [`ffmpeg_cve_2016_1897`](Classes/04_network_penetration_tester/enterprise_middleware/ffmpeg_cve_2016_1897): `./lab start ffmpeg-cve-2016-1897` (Port 8405).
- [`ffmpeg_cve_2017_9993`](Classes/04_network_penetration_tester/enterprise_middleware/ffmpeg_cve_2017_9993): `./lab start ffmpeg-cve-2017-9993` (Port 8406).
- [`flink_cve_2020_17518`](Classes/04_network_penetration_tester/enterprise_middleware/flink_cve_2020_17518): `./lab start flink-cve-2020-17518` (Port 8407).
- [`flink_cve_2020_17519`](Classes/04_network_penetration_tester/enterprise_middleware/flink_cve_2020_17519): `./lab start flink-cve-2020-17519` (Port 8408).
- [`geoserver_cve_2024_36401`](Classes/04_network_penetration_tester/enterprise_middleware/geoserver_cve_2024_36401): `./lab start geoserver-cve-2024-36401` (Port 8409).
- [`glassfish_cve_2017_1000028`](Classes/04_network_penetration_tester/enterprise_middleware/glassfish_cve_2017_1000028): `./lab start glassfish-cve-2017-1000028` (Port 8410).
- [`goahead_cve_2021_42342`](Classes/04_network_penetration_tester/enterprise_middleware/goahead_cve_2021_42342): `./lab start goahead-cve-2021-42342` (Port 8411).
- [`gogs_cve_2018_18925`](Classes/04_network_penetration_tester/enterprise_middleware/gogs_cve_2018_18925): `./lab start gogs-cve-2018-18925` (Port 8412).
- [`h2database_cve_2021_42392`](Classes/04_network_penetration_tester/enterprise_middleware/h2database_cve_2021_42392): `./lab start h2database-cve-2021-42392` (Port 8413).
- [`imagemagick_cve_2016_3714`](Classes/04_network_penetration_tester/enterprise_middleware/imagemagick_cve_2016_3714): `./lab start imagemagick-cve-2016-3714` (Port 8414).
- [`jackson_cve_2017_7525`](Classes/04_network_penetration_tester/enterprise_middleware/jackson_cve_2017_7525): `./lab start jackson-cve-2017-7525` (Port 8415).
- [`java_rmi_codebase`](Classes/04_network_penetration_tester/enterprise_middleware/java_rmi_codebase): `./lab start java-rmi-codebase` (Port 8416).
- [`java_rmi_registry_bind_deserialization_bypass`](Classes/04_network_penetration_tester/enterprise_middleware/java_rmi_registry_bind_deserialization_bypass): `./lab start java-rmi-bind-bypass` (Port 8417).
- [`java_rmi_registry_bind_deserialization`](Classes/04_network_penetration_tester/enterprise_middleware/java_rmi_registry_bind_deserialization): `./lab start java-rmi-bind-deser` (Port 8418).
- [`jboss_cve_2017_12149`](Classes/04_network_penetration_tester/enterprise_middleware/jboss_cve_2017_12149): `./lab start jboss-cve-2017-12149` (Port 8419).
- [`jboss_jmxinvokerservlet_deserialization`](Classes/04_network_penetration_tester/enterprise_middleware/jboss_jmxinvokerservlet_deserialization): `./lab start jboss-jmxinvokerservlet-dese` (Port 8420).
- [`jmeter_cve_2018_1297`](Classes/04_network_penetration_tester/enterprise_middleware/jmeter_cve_2018_1297): `./lab start jmeter-cve-2018-1297` (Port 8421).

- [`libssh_cve_2018_10933`](Classes/04_network_penetration_tester/enterprise_middleware/libssh_cve_2018_10933): `./lab start libssh-cve-2018-10933` (Port 8440).
- [`liferay-portal_cve_2020_7961`](Classes/04_network_penetration_tester/enterprise_middleware/liferay-portal_cve_2020_7961): `./lab start liferay-portal-cve-2020-7961` (Port 8441).
- [`mini_httpd_cve_2018_18778`](Classes/04_network_penetration_tester/enterprise_middleware/mini_httpd_cve_2018_18778): `./lab start mini_httpd-cve-2018-18778` (Port 8442).
- [`minio_cve_2023_28432`](Classes/04_network_penetration_tester/enterprise_middleware/minio_cve_2023_28432): `./lab start minio-cve-2023-28432` (Port 8444).
- [`mojarra_jsf_viewstate_deserialization`](Classes/04_network_penetration_tester/enterprise_middleware/mojarra_jsf_viewstate_deserialization): `./lab start mojarra-jsf-viewstate-deseri` (Port 8445).
- [`mysql_cve_2012_2122`](Classes/04_network_penetration_tester/enterprise_middleware/mysql_cve_2012_2122): `./lab start mysql-cve-2012-2122` (Port 8446).
- [`nacos_cve_2021_29441`](Classes/04_network_penetration_tester/enterprise_middleware/nacos_cve_2021_29441): `./lab start nacos-cve-2021-29441` (Port 8447).
- [`nacos_cve_2021_29442`](Classes/04_network_penetration_tester/enterprise_middleware/nacos_cve_2021_29442): `./lab start nacos-cve-2021-29442` (Port 8448).
- [`nginx_nginx_parsing_vulnerability`](Classes/04_network_penetration_tester/enterprise_middleware/nginx_nginx_parsing_vulnerability): `./lab start nginx-nginx_parsing_vulnerab` (Port 8449).
- [`ntopng_cve_2021_28073`](Classes/04_network_penetration_tester/enterprise_middleware/ntopng_cve_2021_28073): `./lab start ntopng-cve-2021-28073` (Port 8450).
- [`ofbiz_cve_2020_9496`](Classes/04_network_penetration_tester/enterprise_middleware/ofbiz_cve_2020_9496): `./lab start ofbiz-cve-2020-9496` (Port 8451).
- [`openfire_cve_2023_32315`](Classes/04_network_penetration_tester/enterprise_middleware/openfire_cve_2023_32315): `./lab start openfire-cve-2023-32315` (Port 8452).
- [`opensmtpd_cve_2020_7247`](Classes/04_network_penetration_tester/enterprise_middleware/opensmtpd_cve_2020_7247): `./lab start opensmtpd-cve-2020-7247` (Port 8453).
- [`openssl_cve_2014_0160`](Classes/04_network_penetration_tester/enterprise_middleware/openssl_cve_2014_0160): `./lab start openssl-cve-2014-0160` (Port 8454).
- [`openssl_cve_2022_0778`](Classes/04_network_penetration_tester/enterprise_middleware/openssl_cve_2022_0778): `./lab start openssl-cve-2022-0778` (Port 8455).
- [`opentsdb_cve_2020_35476`](Classes/04_network_penetration_tester/enterprise_middleware/opentsdb_cve_2020_35476): `./lab start opentsdb-cve-2020-35476` (Port 8456).
- [`opentsdb_cve_2023_25826`](Classes/04_network_penetration_tester/enterprise_middleware/opentsdb_cve_2023_25826): `./lab start opentsdb-cve-2023-25826` (Port 8457).
- [`pgadmin_cve_2022_4223`](Classes/04_network_penetration_tester/enterprise_middleware/pgadmin_cve_2022_4223): `./lab start pgadmin-cve-2022-4223` (Port 8458).

- [`thinkphp_5_0_23_rce`](Classes/02_web_penetration_tester/12_cms_security/thinkphp_5_0_23_rce): `./lab start thinkphp-5-0-23-rce` (Port 8459).
- [`thinkphp_in_sqlinjection`](Classes/02_web_penetration_tester/12_cms_security/thinkphp_in_sqlinjection): `./lab start thinkphp-in-sqlinjection` (Port 8460).
- [`thinkphp_lang_rce`](Classes/02_web_penetration_tester/12_cms_security/thinkphp_lang_rce): `./lab start thinkphp-lang-rce` (Port 8461).
- [`v2board_1_6_privilege_escalation`](Classes/02_web_penetration_tester/12_cms_security/v2board_1_6_privilege_escalation): `./lab start v2board-1-6-privilege-escalation` (Port 8462).
- [`vite_cnvd_2022_44615`](Classes/02_web_penetration_tester/12_cms_security/vite_cnvd_2022_44615): `./lab start vite-cnvd-2022-44615` (Port 8463).
- [`vite_cve_2025_30208`](Classes/02_web_penetration_tester/12_cms_security/vite_cve_2025_30208): `./lab start vite-cve-2025-30208` (Port 8464).
- [`vite_cve_2025_32395`](Classes/02_web_penetration_tester/12_cms_security/vite_cve_2025_32395): `./lab start vite-cve-2025-32395` (Port 8465).
- [`vite_cve_2026_39363`](Classes/02_web_penetration_tester/12_cms_security/vite_cve_2026_39363): `./lab start vite-cve-2026-39363` (Port 8466).
- [`wordpress_cve_2026_63030`](Classes/02_web_penetration_tester/12_cms_security/wordpress_cve_2026_63030): `./lab start wordpress-cve-2026-63030` (Port 8467).
- [`wordpress_pwnscriptum`](Classes/02_web_penetration_tester/12_cms_security/wordpress_pwnscriptum): `./lab start wordpress-pwnscriptum` (Port 8468).
- [`yapi_mongodb_inj`](Classes/02_web_penetration_tester/12_cms_security/yapi_mongodb_inj): `./lab start yapi-mongodb-inj` (Port 8469).
- [`scrapy_scrapyd_unacc`](Classes/02_web_penetration_tester/12_cms_security/scrapy_scrapyd_unacc): `./lab start scrapy-scrapyd-unacc` (Port 8470).
- [`shiro_cve_2010_3863`](Classes/02_web_penetration_tester/12_cms_security/shiro_cve_2010_3863): `./lab start shiro-cve-2010-3863` (Port 8471).
- [`shiro_cve_2016_4437`](Classes/02_web_penetration_tester/12_cms_security/shiro_cve_2016_4437): `./lab start shiro-cve-2016-4437` (Port 8472).
- [`shiro_cve_2020_1957`](Classes/02_web_penetration_tester/12_cms_security/shiro_cve_2020_1957): `./lab start shiro-cve-2020-1957` (Port 8473).
- [`webmin_cve_2019_15107`](Classes/02_web_penetration_tester/12_cms_security/webmin_cve_2019_15107): `./lab start webmin-cve-2019-15107` (Port 8474).
- [`superset_cve_2023_27524`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/superset_cve_2023_27524): `./lab start superset-cve-2023-27524` (Port 8475).
- [`superset_cve_2023_37941`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/superset_cve_2023_37941): `./lab start superset-cve-2023-37941` (Port 8476).
- [`nowasp_mutillidae_owasp_top10`](Classes/02_web_penetration_tester/12_cms_security/nowasp_mutillidae_owasp_top10): `./lab start nowasp-mutillidae-owasp-top10` (Port 8477).
- [`dvws_node_websocket_security`](Classes/02_web_penetration_tester/12_cms_security/dvws_node_websocket_security): `./lab start dvws-node-websocket-security` (Port 8478).
- [`bodgeit_store_e_commerce_flaws`](Classes/02_web_penetration_tester/12_cms_security/bodgeit_store_e_commerce_flaws): `./lab start bodgeit-store-e-commerce-flaws` (Port 8479).
- [`flask_vulnerable_app_python_ssti_sqli`](Classes/02_web_penetration_tester/12_cms_security/flask_vulnerable_app_python_ssti_sqli): `./lab start flask-vulnerable-app-python-ssti-sqli` (Port 8480).
- [`owasp_wrongsecrets_cloud_secret_leakage`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/owasp_wrongsecrets_cloud_secret_leakage): `./lab start owasp-wrongsecrets-cloud-secret-leakage` (Port 8481).
- [`owasp_skf_security_knowledge_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_security_knowledge_lab): `./lab start owasp-skf-security-knowledge-lab` (Port 8482).
- [`node_deserialization_nodejs_rce`](Real_World_Industry_Labs/02_cloud_k8s_container_escape/node_deserialization_nodejs_rce): `./lab start node-deserialization-nodejs-rce` (Port 8483).
- [`nexus_cve_2019_7238`](Classes/04_network_penetration_tester/enterprise_middleware/nexus_cve_2019_7238): `./lab start nexus-cve-2019-7238` (Port 8484).
- [`nexus_cve_2020_10199`](Classes/04_network_penetration_tester/enterprise_middleware/nexus_cve_2020_10199): `./lab start nexus-cve-2020-10199` (Port 8485).
- [`nexus_cve_2020_10204`](Classes/04_network_penetration_tester/enterprise_middleware/nexus_cve_2020_10204): `./lab start nexus-cve-2020-10204` (Port 8486).
- [`nexus_cve_2024_4956`](Classes/04_network_penetration_tester/enterprise_middleware/nexus_cve_2024_4956): `./lab start nexus-cve-2024-4956` (Port 8487).
- [`saltstack_cve_2020_11651`](Classes/04_network_penetration_tester/enterprise_middleware/saltstack_cve_2020_11651): `./lab start saltstack-cve-2020-11651` (Port 8488).
- [`saltstack_cve_2020_11652`](Classes/04_network_penetration_tester/enterprise_middleware/saltstack_cve_2020_11652): `./lab start saltstack-cve-2020-11652` (Port 8489).
- [`saltstack_cve_2020_16846`](Classes/04_network_penetration_tester/enterprise_middleware/saltstack_cve_2020_16846): `./lab start saltstack-cve-2020-16846` (Port 8490).
- [`samba_cve_2017_7494`](Classes/04_network_penetration_tester/enterprise_middleware/samba_cve_2017_7494): `./lab start samba-cve-2017-7494` (Port 8491).
- [`skywalking_8_3_0_sqli`](Classes/04_network_penetration_tester/enterprise_middleware/skywalking_8_3_0_sqli): `./lab start skywalking-8-3-0-sqli` (Port 8492).
- [`solr_cve_2019_0193`](Classes/04_network_penetration_tester/enterprise_middleware/solr_cve_2019_0193): `./lab start solr-cve-2019-0193` (Port 8493).
- [`solr_cve_2019_17558`](Classes/04_network_penetration_tester/enterprise_middleware/solr_cve_2019_17558): `./lab start solr-cve-2019-17558` (Port 8494).
- [`spring_cve_2016_4977`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cve_2016_4977): `./lab start spring-cve-2016-4977` (Port 8495).
- [`spring_cve_2017_4971`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cve_2017_4971): `./lab start spring-cve-2017-4971` (Port 8496).
- [`spring_cve_2017_8046`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cve_2017_8046): `./lab start spring-cve-2017-8046` (Port 8497).
- [`spring_cve_2018_1270`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cve_2018_1270): `./lab start spring-cve-2018-1270` (Port 8498).
- [`spring_cve_2018_1273`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cve_2018_1273): `./lab start spring-cve-2018-1273` (Port 8499).
- [`spring_cve_2022_22947`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cve_2022_22947): `./lab start spring-cve-2022-22947` (Port 8500).
- [`spring_cve_2022_22963`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cve_2022_22963): `./lab start spring-cve-2022-22963` (Port 8501).
- [`spring_cve_2022_22965`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cve_2022_22965): `./lab start spring-cve-2022-22965` (Port 8502).
- [`spring_cve_2022_22978`](Classes/04_network_penetration_tester/enterprise_middleware/spring_cve_2022_22978): `./lab start spring-cve-2022-22978` (Port 8503).
- [`struts2_s2_032`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_032): `./lab start struts2-s2-032` (Port 8504).
- [`struts2_s2_046`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_046): `./lab start struts2-s2-046` (Port 8505).
- [`supervisor_cve_2017_11610`](Classes/04_network_penetration_tester/enterprise_middleware/supervisor_cve_2017_11610): `./lab start supervisor-cve-2017-11610` (Port 8506).
- [`weblogic_cve_2017_10271`](Classes/04_network_penetration_tester/enterprise_middleware/weblogic_cve_2017_10271): `./lab start weblogic-cve-2017-10271` (Port 8507).
- [`struts2_vulnforensics_forensics_rce`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_vulnforensics_forensics_rce): `./lab start struts2-vulnforensics-forensics-rce` (Port 8508).

- [`wordpress_cve_2019_8942_rce`](Classes/02_web_penetration_tester/12_cms_security/wordpress_cve_2019_8942_rce): `./lab start wordpress-cve-2019-8942-rce` (Port 8509).
- [`wordpress_cve_2017_1001000_rest_api`](Classes/02_web_penetration_tester/12_cms_security/wordpress_cve_2017_1001000_rest_api): `./lab start wordpress-cve-2017-1001000-rest-api` (Port 8510).
- [`wordpress_catalog_product_catalog_sqli`](Classes/02_web_penetration_tester/12_cms_security/wordpress_catalog_product_catalog_sqli): `./lab start wordpress-catalog-product-catalog-sqli` (Port 8511).
- [`wordpress_finder_cysteme_finder_lfi`](Classes/02_web_penetration_tester/12_cms_security/wordpress_finder_cysteme_finder_lfi): `./lab start wordpress-finder-cysteme-finder-lfi` (Port 8512).
- [`wordpress_mailpress_mailpress_plugin_rce`](Classes/02_web_penetration_tester/12_cms_security/wordpress_mailpress_mailpress_plugin_rce): `./lab start wordpress-mailpress-mailpress-plugin-rce` (Port 8513).
- [`wordpress_optin_double_optin_sqli`](Classes/02_web_penetration_tester/12_cms_security/wordpress_optin_double_optin_sqli): `./lab start wordpress-optin-double-optin-sqli` (Port 8514).
- [`phpmailer_cve_2016_10033`](Classes/02_web_penetration_tester/12_cms_security/phpmailer_cve_2016_10033): `./lab start phpmailer-cve-2016-10033` (Port 8515).
- [`discuz_x3_2_auth_bypass`](Classes/02_web_penetration_tester/12_cms_security/discuz_x3_2_auth_bypass): `./lab start discuz-x3-2-auth-bypass` (Port 8516).
- [`cmseasy_cut_image_rce`](Classes/02_web_penetration_tester/12_cms_security/cmseasy_cut_image_rce): `./lab start cmseasy-cut-image-rce` (Port 8517).
- [`zabbix_cve_2016_10134_sqli`](Classes/02_web_penetration_tester/12_cms_security/zabbix_cve_2016_10134_sqli): `./lab start zabbix-cve-2016-10134-sqli` (Port 8518).
- [`zabbix_cve_2017_2824_rce`](Classes/02_web_penetration_tester/12_cms_security/zabbix_cve_2017_2824_rce): `./lab start zabbix-cve-2017-2824-rce` (Port 8519).
- [`git_cve_2018_11235`](Classes/02_web_penetration_tester/12_cms_security/git_cve_2018_11235): `./lab start git-cve-2018-11235` (Port 8520).
- [`owasp_webgoat_webgoat_enterprise`](Classes/02_web_penetration_tester/12_cms_security/owasp_webgoat_webgoat_enterprise): `./lab start owasp-webgoat-webgoat-enterprise` (Port 8521).
- [`dsxs_xss_damn_small_xss_scanner`](Classes/02_web_penetration_tester/12_cms_security/dsxs_xss_damn_small_xss_scanner): `./lab start dsxs-xss-damn-small-xss-scanner` (Port 8522).
- [`owasp_skf_xss_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_xss_lab): `./lab start owasp-skf-xss-lab` (Port 8523).
- [`owasp_skf_sqli_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_sqli_lab): `./lab start owasp-skf-sqli-lab` (Port 8524).
- [`owasp_skf_ssrf_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_ssrf_lab): `./lab start owasp-skf-ssrf-lab` (Port 8525).
- [`owasp_skf_idor_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_idor_lab): `./lab start owasp-skf-idor-lab` (Port 8526).
- [`owasp_skf_lfi_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_lfi_lab): `./lab start owasp-skf-lfi-lab` (Port 8527).
- [`owasp_skf_rfi_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_rfi_lab): `./lab start owasp-skf-rfi-lab` (Port 8528).
- [`owasp_skf_cors_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_cors_lab): `./lab start owasp-skf-cors-lab` (Port 8529).
- [`owasp_skf_csrf_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_csrf_lab): `./lab start owasp-skf-csrf-lab` (Port 8530).
- [`owasp_skf_racecondition_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_racecondition_lab): `./lab start owasp-skf-racecondition-lab` (Port 8531).
- [`owasp_skf_commandexec_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_commandexec_lab): `./lab start owasp-skf-commandexec-lab` (Port 8532).
- [`owasp_skf_jwt_lab`](Classes/02_web_penetration_tester/12_cms_security/owasp_skf_jwt_lab): `./lab start owasp-skf-jwt-lab` (Port 8533).
- [`tomcat_cve_2020_1938_ghostcat`](Classes/04_network_penetration_tester/enterprise_middleware/tomcat_cve_2020_1938_ghostcat): `./lab start tomcat-cve-2020-1938-ghostcat` (Port 8534).
- [`tomcat_cve_2017_12615_put_rce`](Classes/04_network_penetration_tester/enterprise_middleware/tomcat_cve_2017_12615_put_rce): `./lab start tomcat-cve-2017-12615-put-rce` (Port 8535).
- [`struts2_s2_057`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_057): `./lab start struts2-s2-057` (Port 8536).
- [`jenkins_cve_2015_8103`](Classes/04_network_penetration_tester/enterprise_middleware/jenkins_cve_2015_8103): `./lab start jenkins-cve-2015-8103` (Port 8537).
- [`jboss_cve_2015_7501`](Classes/04_network_penetration_tester/enterprise_middleware/jboss_cve_2015_7501): `./lab start jboss-cve-2015-7501` (Port 8538).
- [`openssh_cve_2017_1000117`](Classes/04_network_penetration_tester/enterprise_middleware/openssh_cve_2017_1000117): `./lab start openssh-cve-2017-1000117` (Port 8539).
- [`struts2_s2_045`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_045): `./lab start struts2-s2-045` (Port 8540).
- [`struts2_s2_037`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_037): `./lab start struts2-s2-037` (Port 8541).
- [`struts2_s2_033`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_033): `./lab start struts2-s2-033` (Port 8542).
- [`struts2_s2_029`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_029): `./lab start struts2-s2-029` (Port 8543).
- [`struts2_s2_019`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_019): `./lab start struts2-s2-019` (Port 8544).
- [`struts2_s2_016`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_016): `./lab start struts2-s2-016` (Port 8546).
- [`struts2_s2_015`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_015): `./lab start struts2-s2-015` (Port 8547).
- [`struts2_s2_013`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_013): `./lab start struts2-s2-013` (Port 8548).
- [`struts2_s2_012`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_012): `./lab start struts2-s2-012` (Port 8549).
- [`struts2_s2_008`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_008): `./lab start struts2-s2-008` (Port 8550).
- [`struts2_s2_007`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_007): `./lab start struts2-s2-007` (Port 8551).
- [`struts2_s2_001`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_001): `./lab start struts2-s2-001` (Port 8552).
- [`struts2_s2_devmode`](Classes/04_network_penetration_tester/enterprise_middleware/struts2_s2_devmode): `./lab start struts2-s2-devmode` (Port 8553).
- [`springboot_whitelabel_spel_rce`](Classes/04_network_penetration_tester/enterprise_middleware/springboot_whitelabel_spel_rce): `./lab start springboot-whitelabel-spel-rce` (Port 8554).
- [`nginx_cve_2017_7529_integer_overflow`](Classes/04_network_penetration_tester/enterprise_middleware/nginx_cve_2017_7529_integer_overflow): `./lab start nginx-cve-2017-7529-integer-overflow` (Port 8555).
- [`nagios_cve_2016_9565_root_rce`](Classes/04_network_penetration_tester/enterprise_middleware/nagios_cve_2016_9565_root_rce): `./lab start nagios-cve-2016-9565-root-rce` (Port 8556).
- [`memcached_cve_2016_8704_append_overflow`](Classes/04_network_penetration_tester/enterprise_middleware/memcached_cve_2016_8704_append_overflow): `./lab start memcached-cve-2016-8704-append-overflow` (Port 8557).
- [`memcached_cve_2016_8705_update_overflow`](Classes/04_network_penetration_tester/enterprise_middleware/memcached_cve_2016_8705_update_overflow): `./lab start memcached-cve-2016-8705-update-overflow` (Port 8558).
- [`memcached_cve_2016_8706_sasl_overflow`](Classes/04_network_penetration_tester/enterprise_middleware/memcached_cve_2016_8706_sasl_overflow): `./lab start memcached-cve-2016-8706-sasl-overflow` (Port 8559).

### 05. Exploit Writing (`Classes/05_exploit_writing/`)
- [`05_stack_buffer_overflow_env`](Classes/05_exploit_writing/05_stack_buffer_overflow_env): `./lab start bof && ./lab shell bof`.
- [`06_13_14_shellcoding_and_encoders`](Classes/05_exploit_writing/06_13_14_shellcoding_and_encoders): `./lab start shellcoder && ./lab shell shellcoder`.
- [`12_dep_aslr_bypass`](Classes/05_exploit_writing/12_dep_aslr_bypass): ROP & ret2libc guide.
