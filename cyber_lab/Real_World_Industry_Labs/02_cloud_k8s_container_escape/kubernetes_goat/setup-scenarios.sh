#!/usr/bin/env bash
# ==============================================================================
# Kubernetes Goat Automated Scenarios Deployment Script
# Deploys official scenarios into the local cyberlab_k8s_goat container
# ==============================================================================

set -e

echo "[*] Waiting for K3s cluster inside cyberlab_k8s_goat to be ready..."
until docker exec cyberlab_k8s_goat kubectl get nodes >/dev/null 2>&1; do
	echo "    Waiting for cluster API server..."
	sleep 3
done

echo "[+] K3s cluster is online!"
docker exec cyberlab_k8s_goat kubectl get nodes

echo "[*] Fetching and deploying Kubernetes Goat scenarios..."
docker exec cyberlab_k8s_goat sh -c '
  curl -sSL https://raw.githubusercontent.com/madhuakula/kubernetes-goat/master/scenarios-manifests.yaml | kubectl apply -f - || true
'

echo "[+] Scenarios deployed! Checking pod status in default namespace:"
docker exec cyberlab_k8s_goat kubectl get pods -A

echo ""
echo "[+] Kubernetes Goat is live!"
echo "    Web Portal:   http://localhost:8105"
echo "    Cluster API:  https://localhost:6443"
echo "    Kubeconfig:   $(pwd)/output/kubeconfig.yaml"
