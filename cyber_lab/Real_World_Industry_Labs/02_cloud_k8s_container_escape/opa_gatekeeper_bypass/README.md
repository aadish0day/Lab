# OPA Gatekeeper Bypass: Policy-as-Code Logic Flaws & Kubernetes Admission Escapes

## Overview

In modern Kubernetes clusters, **Open Policy Agent (OPA)** and its Kubernetes-native counterpart **Gatekeeper** serve as the primary line of defense for enforcing security boundaries, Pod Security Standards (PSS/PSA), compliant registries, resource constraints, and network policies.

However, writing secure **Rego** (the declarative query language underpinning OPA) is notoriously tricky. Subtle syntactic and semantic logic flaws—such as unanchored regular expressions, undefined variable fall-through, missing object inspection across new Kubernetes fields (e.g. `ephemeralContainers`), and inverted truthiness assumptions—frequently allow malicious workloads to completely bypass admission control and execute as privileged root containers with access to host namespaces.

This lab provides an OPA server running with live Rego policies simulating real-world Kubernetes admission webhooks, accompanied by exploit payloads and verified remediation patterns.

- **OPA Server API**: `http://localhost:8111`
- **Internal Container Port**: `8181`
- **Container Name**: `cyberlab_opa_server`
- **Directory**: `Real_World_Industry_Labs/02_cloud_k8s_container_escape/opa_gatekeeper_bypass`

---

## Quick Start & Lab Usage

```bash
cd Real_World_Industry_Labs/02_cloud_k8s_container_escape/opa_gatekeeper_bypass

# Launch OPA server container with loaded Rego policies
docker compose up -d

# Run automated policy evaluation and exploit test suite
./test-policies.sh
```

To interactively evaluate policies using OPA CLI:

```bash
docker compose exec -it opa opa eval \
  --data /policies \
  --input /examples/bypass_regex_pod.json \
  "data.kubernetes.admission.registry"
```

---

## Kubernetes Admission Control & Policy-as-Code Architecture

```
                                      KUBERNETES API REQUEST LIFECYCLE
+---------------------------------------------------------------------------------------------------+
| 1. API Client ----> [Authentication] ----> [Authorization] ----> [Mutating Webhooks]              |
|                     (Cert / Bearer)          (RBAC)             (Inject sidecars/defaults)       |
+---------------------------------------------------------------------------------------------------+
                                                                               |
                                                                               v
+---------------------------------------------------------------------------------------------------+
| 2. Object Schema Validation (Schema, OpenAPI v3)                                                   |
+---------------------------------------------------------------------------------------------------+
                                                                               |
                                                                               v
+---------------------------------------------------------------------------------------------------+
| 3. VALIDATING ADMISSION WEBHOOKS (OPA Gatekeeper)                                                 |
|    - Intercepts AdmissionReview JSON payload                                                     |
|    - Evaluates Rego Constraints against incoming spec                                            |
|    - Returns { "allowed": true } OR { "allowed": false, "status": { "message": "Denied" } }       |
+---------------------------------------------------------------------------------------------------+
           |                                                                  |
    [Allowed: Pass]                                                    [Denied: Block]
           v                                                                  v
+-----------------------------+                                    +----------------------+
| 4. Persisted to etcd        |                                    | 403 Forbidden to User|
+-----------------------------+                                    +----------------------+
```

### Policy-as-Code (PaC) Paradigm

1. **ConstraintTemplates**: Define the abstract Rego validation logic and parameters.
2. **Constraints**: Bind the template to specific Kubernetes resources, namespaces, and enforcement actions (`deny`, `dryrun`, or `warn`).
3. **Data Ingestion**: Rego queries compare incoming request objects (`input.request.object`) against cluster state stored in OPA memory.

---

## Attack Vector 1: Rego Logic Flaws & Truthiness Traps

### Threat Model & Rego Mechanics

Rego is not an imperative language; it is a declarative, set-based query language. Key properties that introduce vulnerabilities:

- **Default Behavior**: In Rego, if no rule generates a contradiction or if a condition fails, undefined evaluation occurs.
- **AND vs OR Semantics**:
  - Statements on separate lines inside a single rule block are evaluated as logical **AND**. If any statement is false or undefined, the entire rule fails.
  - Multiple rule blocks with the same name are evaluated as logical **OR**.
- **The Negation (`not`) Gotcha**:
  `not x` evaluates to `true` if `x` is `false` **OR if `x` is undefined**.
  If a rule attempts to check:
  ```rego
  not input.request.object.spec.securityContext.runAsNonRoot
  ```
  If `securityContext` does not exist at all, the inner expression is undefined, so `not` evaluates to `true`!

---

## Attack Vector 2: Undefined Variable Fall-Through (Privileged Root Bypass)

### The Vulnerability

A common pattern in custom admission webhooks is writing a rule that detects explicit violations:

```rego
# Vulnerable Rego Rule
package kubernetes.admission.security_context

default allow = true

deny[msg] {
    container := input.request.object.spec.containers[_]
    container.securityContext.runAsNonRoot == false
    msg := "Denied: container explicitly disabled runAsNonRoot."
}

allow = false {
    count(deny) > 0
}
```

### The Flaw

The policy author assumed that containers either have `runAsNonRoot: true` or `runAsNonRoot: false`.
However, in Kubernetes, `securityContext` is entirely optional. When a developer omits `securityContext`:

1. `container.securityContext.runAsNonRoot` evaluates to **undefined**.
2. The `deny` block halts immediately without producing an error.
3. The count of `deny` is 0, so `default allow = true` takes effect!
4. Kubernetes spawns the container with standard default settings: **UID 0 (root)**!

### Hands-On Exploitation

Send `bypass_undefined_root_pod.json` to the OPA server:

```bash
curl -s -X POST http://127.0.0.1:8111/v1/data/kubernetes/admission/security_context \
  -H "Content-Type: application/json" \
  -d "{\"input\": $(cat ./examples/bypass_undefined_root_pod.json)}" | jq .
```

**Result**:

```json
{
  "result": {
    "allow": true
  }
}
```

The admission controller allows the pod, and it executes as unconstrained root inside the cluster.

---

## Attack Vector 3: Regex Anchor Bypass in Admission Control

### The Vulnerability

Organizations enforce trusted container registries by matching image strings against corporate prefixes. A common flaw is omitting regular expression anchors (`^` for beginning of string, `$` for end of string):

```rego
# Vulnerable Rego Rule
package kubernetes.admission.registry

default allow = true

deny[msg] {
    container := input.request.object.spec.containers[_]
    not re_match("internal-registry.corp.com", container.image)
    msg := "Denied: image does not match corporate registry."
}

allow = false { count(deny) > 0 }
```

### The Flaw

Because `re_match` searches for a substring anywhere within the image string without anchors:

- `internal-registry.corp.com/approved-app:v1` -> **MATCHES** (Approved)
- `docker.io/attacker/internal-registry.corp.com-backdoor:latest` -> **MATCHES** (Bypassed!)
- `internal-registry.corp.com.attacker.com/pwned:latest` -> **MATCHES** (Bypassed!)

### Hands-On Exploitation

Submit a pod referencing an external malicious registry disguised with the trusted domain as a path component:

```bash
curl -s -X POST http://127.0.0.1:8111/v1/data/kubernetes/admission/registry \
  -H "Content-Type: application/json" \
  -d "{\"input\": $(cat ./examples/bypass_regex_pod.json)}" | jq .
```

**Result**:

```json
{
  "result": {
    "allow": true
  }
}
```

The attacker pulls arbitrary malicious containers into the production cluster despite policy enforcement.

---

## Attack Vector 4: Pod Security Standard (PSS) Bypasses

### 1. Ephemeral Containers Bypass (`kubectl debug`)

Many Gatekeeper ConstraintTemplates and legacy Kyverno policies inspect only:

- `spec.containers[_]`
- `spec.initContainers[_]`

In modern Kubernetes, `spec.ephemeralContainers` allows attaching interactive debug containers to already running pods. If an admission controller does not explicitly evaluate `spec.ephemeralContainers`, an attacker running `kubectl debug -it <pod> --image=alpine` can launch a container with `securityContext.privileged: true` and host mounts without triggering any admission alerts!

```bash
curl -s -X POST http://127.0.0.1:8111/v1/data/kubernetes/admission/pod_security \
  -H "Content-Type: application/json" \
  -d "{\"input\": $(cat ./examples/bypass_ephemeral_pod.json)}" | jq .
```

### 2. HostPath Volume Obfuscation & SubPath Escapes

Policies banning `hostPath` volumes can often be bypassed by:

- Using symbolic links inside persistent volumes.
- Path normalization bypasses (e.g. `/var/run/docker.sock` vs `/var/log/../../var/run/docker.sock` if path resolution is performed textually instead of canonicalized).

### 3. Namespace Selector & Label Tampering

Gatekeeper uses `namespaceSelector` to exclude system namespaces (`kube-system`).
If an attacker has permission to create pods in unmonitored namespaces or can apply labels like `admission.gatekeeper.sh/ignore=true` to an existing namespace, Gatekeeper ignores all objects within that namespace.

---

## Defensive Hardening & Safe Rego Patterns

Review the included hardened policy at `policies/hardened_admission.rego`:

### 1. Enforce Default Deny

Never rely on `default allow = true`. Explicitly deny by default and require all security assertions to pass:

```rego
default allow = false
```

### 2. Safe Object Access with `object.get`

Never traverse deeply nested optional objects directly. Use `object.get` with an explicit fallback value:

```rego
# Safely handle undefined securityContext
run_as_non_root := object.get(container, ["securityContext", "runAsNonRoot"], false)
run_as_non_root != true # Triggers denial if missing or false
```

### 3. Comprehensive Container Iteration

Create a helper rule that unifies all container categories:

```rego
all_containers[c] { c := input.request.object.spec.containers[_] }
all_containers[c] { c := input.request.object.spec.initContainers[_] }
all_containers[c] { c := input.request.object.spec.ephemeralContainers[_] }
```

### 4. Anchored Regular Expressions

Always anchor domain checks and escape dots:

```rego
approved_registry_regex := "^internal-registry\\.corp\\.com/"
regex.match(approved_registry_regex, container.image)
```

---

## Verified YouTube Walkthroughs & Lectures

All video links have been verified active via the YouTube oEmbed API (`HTTP 200 OK`):

- [Vincent Stevenson - Open Policy Agent OPA Quickstart Guide with Simple Rego Rules and Json Inputs](https://www.youtube.com/watch?v=M7IwpC9WpIg) — Hands-on primer to OPA evaluation, Rego query syntax, and testing with JSON inputs.
- [Is it Observable - Secure Your Kubernetes Clusters with OPA Gatekeeper: Policy and Governance for K8s](https://www.youtube.com/watch?v=w3rQeBvbTlA) — Deep dive into Gatekeeper admission webhooks, ConstraintTemplates, and production governance.
- [Cloud Quick Labs - Kubernetes Security: How to Protect Your Cluster with Open Policy Agent Gatekeeper](https://www.youtube.com/watch?v=NmzuIONvzI4) — Step-by-step installation, constraint deployment, and admission rejection demos.
- [Learn with GVR - Kubernetes Security - Open Policy Agent - OPA Gatekeeper - 12](https://www.youtube.com/watch?v=ocSgbSCX34M) — Detailed architecture of validating admission controllers and Rego policy enforcement.
- [KodeKloud - Open Policy Agent – Unified Policy Enforcement for Cloud-Native Security](https://www.youtube.com/watch?v=pe3n2mJn2EI) — CNCF project overview, policy-as-code principles, and enterprise security architecture.
- [LearnITGuide Tutorials - How Kubernetes Admission Controllers Work | Security Deep Dive 2026](https://www.youtube.com/watch?v=JC4-iXWpTuA) — Comprehensive breakdown of validating vs mutating webhooks and API request lifecycles.
- [Pyronix TechLab - Open Policy Agent (OPA) Tutorial for Beginners | Learn Rego in 5 Minutes](https://www.youtube.com/watch?v=CdZ9v5T0GTE) — Fast-paced tutorial covering Rego truthiness, rules, arrays, and set evaluation.
- [The Cyber Basics Channel - Kubernetes Admission Controller Bypass](https://www.youtube.com/watch?v=kxCRJbsR3aQ) — Offensive security analysis of admission controller misconfigurations and bypass techniques.

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Check status
./lab status

# Stop this lab
cd Real_World_Industry_Labs/02_cloud_k8s_container_escape/opa_gatekeeper_bypass && docker compose down
```
