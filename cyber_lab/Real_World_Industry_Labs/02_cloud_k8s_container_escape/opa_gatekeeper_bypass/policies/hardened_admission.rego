package kubernetes.admission.hardened

import future.keywords.in

default allow = false

approved_registry_regex := "^internal-registry\\.corp\\.com/"

# Helper to inspect ALL container types: containers, initContainers, ephemeralContainers
all_containers[c] {
    c := input.request.object.spec.containers[_]
}
all_containers[c] {
    c := input.request.object.spec.initContainers[_]
}
all_containers[c] {
    c := input.request.object.spec.ephemeralContainers[_]
}

# 1. Hardened Registry Check: Anchored regex check
deny[msg] {
    c := all_containers[_]
    not regex.match(approved_registry_regex, c.image)
    msg := sprintf("Hardened Denial: Container '%v' uses unapproved image '%v'. Must match '^internal-registry.corp.com/'", [c.name, c.image])
}

# 2. Hardened Non-Root Enforcement: Explicitly require runAsNonRoot == true
deny[msg] {
    c := all_containers[_]
    run_as_non_root := object.get(c, ["securityContext", "runAsNonRoot"], false)
    run_as_non_root != true
    msg := sprintf("Hardened Denial: Container '%v' must explicitly define securityContext.runAsNonRoot: true", [c.name])
}

# 3. Hardened Privileged Enforcement across all container definitions
deny[msg] {
    c := all_containers[_]
    is_privileged := object.get(c, ["securityContext", "privileged"], false)
    is_privileged == true
    msg := sprintf("Hardened Denial: Container '%v' is requesting forbidden privileged mode.", [c.name])
}

# Allow only if zero denials
allow {
    count(deny) == 0
}
