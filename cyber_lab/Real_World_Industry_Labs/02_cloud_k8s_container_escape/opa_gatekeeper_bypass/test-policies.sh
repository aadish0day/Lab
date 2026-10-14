#!/usr/bin/env bash
# ==============================================================================
# OPA Gatekeeper Policy Evaluation & Bypass Test Suite
# ==============================================================================
set -e

OPA_URL="http://127.0.0.1:8111"

echo "[*] Testing OPA Server at $OPA_URL..."
until curl -s "$OPA_URL/v1/data" > /dev/null 2>&1; do
  echo "    Waiting for OPA server..."
  sleep 1
done
echo "[+] OPA Server is running and serving policies."

echo ""
echo "================================================================="
echo " TEST 1: Regex Anchor Bypass in Admission Control"
echo " Vulnerable Policy: kubernetes/admission/registry"
echo " Attack: Image 'docker.io/attacker/internal-registry.corp.com-backdoor:latest'"
echo "================================================================="
RESP1=$(curl -s -X POST "$OPA_URL/v1/data/kubernetes/admission/registry" \
  -H "Content-Type: application/json" \
  -d "{\"input\": $(cat ./examples/bypass_regex_pod.json)}")
echo "OPA Result: $RESP1" | jq .

echo ""
echo "================================================================="
echo " TEST 2: Undefined Variable Fall-Through (Running as Root)"
echo " Vulnerable Policy: kubernetes/admission/security_context"
echo " Attack: Pod completely omits securityContext -> undefined evaluation"
echo "================================================================="
RESP2=$(curl -s -X POST "$OPA_URL/v1/data/kubernetes/admission/security_context" \
  -H "Content-Type: application/json" \
  -d "{\"input\": $(cat ./examples/bypass_undefined_root_pod.json)}")
echo "OPA Result: $RESP2" | jq .

echo ""
echo "================================================================="
echo " TEST 3: Ephemeral Container Pod Security Standards Bypass"
echo " Vulnerable Policy: kubernetes/admission/pod_security"
echo " Attack: Pod adds privileged container inside ephemeralContainers"
echo "================================================================="
RESP3=$(curl -s -X POST "$OPA_URL/v1/data/kubernetes/admission/pod_security" \
  -H "Content-Type: application/json" \
  -d "{\"input\": $(cat ./examples/bypass_ephemeral_pod.json)}")
echo "OPA Result: $RESP3" | jq .

echo ""
echo "================================================================="
echo " TEST 4: Evaluating the same attacks against Hardened Policy"
echo " Hardened Policy: kubernetes/admission/hardened"
echo " Expectation: ALL ATTACKS BLOCKED (allow == false, deny has reasons)"
echo "================================================================="
HARDENED_RESP=$(curl -s -X POST "$OPA_URL/v1/data/kubernetes/admission/hardened" \
  -H "Content-Type: application/json" \
  -d "{\"input\": $(cat ./examples/bypass_regex_pod.json)}")
echo "Hardened Policy Result: $HARDENED_RESP" | jq .
