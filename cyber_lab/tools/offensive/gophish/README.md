# Red Team Phishing Infrastructure & Simulation (Gophish)

## Overview
Deploy an enterprise phishing simulation platform: Clone corporate login portals (M365, Google), harvest credentials, and understand SPF/DKIM/DMARC.

- **Default Port / Access**: `3333 (Admin HTTPS), 8092 (Phishing)`
- **Directory**: `Real_World_Industry_Labs/04_social_engineering_redteam/gophish_infrastructure`

---

## How to Solve & Practice

1. Start the lab: `docker compose up -d`
2. Retrieve initial admin credentials from logs: `docker logs cyberlab_realworld_gophish 2>&1 | grep password`.
3. Browse to `https://localhost:3333` (accept self-signed SSL certificate) and login.
4. Import a landing page template by cloning an existing website login page.
5. Configure a sending profile and launch a simulated campaign to monitor click and submission telemetry.

---

## YouTube Walkthroughs & Solving Guides

- [HackerForce - Gophish: Phishing Infrastructure Setup and Campaign Execution](https://www.youtube.com/watch?v=KTWxIaSXcJA)
- [David Bombal - How Hackers Create Phishing Campaigns for Free Using Gophish](https://www.youtube.com/watch?v=JgxEkUHKOBo)

---

## Quick CLI Control
From the `cyber_lab` root directory:
```bash
# Check status
./lab status

# Stop this lab
docker compose down
```
