# Lab

A collection of self-hosted Docker Compose stacks for personal infrastructure, media management, and security testing.

## Stacks

### homelab

| Stack | Services | Count | Ports |
|---|---|---|---|
| **Immich** | immich-server, immich-machine-learning, valkey/redis, postgres | 4 | 2283 |
| **Media Stack** | jellyfin, qbittorrent, prowlarr, sonarr, radarr | 5 | 8096, 8080, 9696, 8989, 7878 |
| **Pi-hole** | pihole (DNS ad-blocker) | 1 | 53, 80, 443 |
| **Stirling PDF** | stirling-pdf (PDF toolbox) | 1 | 9000 |

### cyber_lab

Placeholder for security testing lab environments.

## Quick Start

```bash
# Install Docker (if needed)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo usermod -aG docker $USER

# Start a stack
cd home_lab/media-stack
docker compose up -d
```

Each stack has its own `docker-compose.yml` — no single orchestration file ties them together, so start only what you need.
