package kubernetes.admission.pod_security

import future.keywords.in

default allow = true

# VULNERABLE RULE: Incomplete Container Inspection (Pod Security Standard Bypass)
# Intention: Disallow privileged containers in the cluster.
# Flaw: The policy only inspects standard containers and initContainers.
# It completely misses ephemeralContainers (used via kubectl debug).
# An attacker with ephemeralcontainers/create permission can inject a privileged
# container into an existing pod, bypassing Gatekeeper entirely!
deny[msg] {
    container := input.request.object.spec.containers[_]
    container.securityContext.privileged == true
    msg := sprintf("Denied: Main container '%v' cannot run in privileged mode.", [container.name])
}

deny[msg] {
    container := input.request.object.spec.initContainers[_]
    container.securityContext.privileged == true
    msg := sprintf("Denied: Init container '%v' cannot run in privileged mode.", [container.name])
}

allow = false {
    count(deny) > 0
}
