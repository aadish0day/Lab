package kubernetes.admission.security_context

import future.keywords.in

default allow = true

# VULNERABLE RULE: Undefined Variable Fall-Through
# Intention: Prevent pods from running as root
# Flaw: The rule checks if runAsNonRoot is explicitly set to false.
# If an attacker submits a pod spec WITHOUT a securityContext or WITHOUT
# runAsNonRoot, the expression evaluates to undefined (failing the deny condition).
# Consequently, the admission controller permits the pod, which defaults to root (UID 0)!
deny[msg] {
    container := input.request.object.spec.containers[_]
    container.securityContext.runAsNonRoot == false
    msg := sprintf("Denied: Container '%v' is explicitly configured with runAsNonRoot: false", [container.name])
}

allow = false {
    count(deny) > 0
}
