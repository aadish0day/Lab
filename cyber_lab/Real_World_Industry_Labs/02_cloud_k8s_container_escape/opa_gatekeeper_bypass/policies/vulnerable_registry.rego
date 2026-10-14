package kubernetes.admission.registry

import future.keywords.in

default allow = true

# VULNERABLE RULE: Regex lacking start (^) and end ($) anchors
# Intention: Ensure all images originate from internal-registry.corp.com
# Flaw: An attacker can deploy images like:
#   evil-hacker.com/internal-registry.corp.com/malware:v1
#   internal-registry.corp.com.attacker.net/backdoor:latest
deny[msg] {
    container := input.request.object.spec.containers[_]
    image := container.image
    not re_match("internal-registry.corp.com", image)
    msg := sprintf("Denied: Image '%v' does not match approved registry pattern.", [image])
}

allow = false {
    count(deny) > 0
}
