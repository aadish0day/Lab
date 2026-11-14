# Media Stack - Self-Hosted Automation

A complete media automation stack using Docker Compose with Jellyfin, Sonarr, Radarr, qBittorrent, Prowlarr, and Gluetun VPN.

## Table of Contents

- [Overview](#overview)
- [Stack Components](#stack-components)
- [Directory Structure](#directory-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Credits](#credits)

## Overview

This setup provides a fully automated media server that can:

- Download and organize TV shows and movies automatically
- Stream content through Jellyfin with hardware transcoding
- Manage torrent downloads securely behind a VPN with a built-in killswitch (Gluetun)
- Search and index content across multiple sources

## Stack Components

| Service         | Purpose                                              | Web UI Port                       |
| --------------- | ---------------------------------------------------- | --------------------------------- |
| **Gluetun**     | VPN client with killswitch protecting torrent & indexer traffic | `8080` (qBit), `9696` (Prowlarr), `8191` (FlareSolverr) |
| **qBittorrent** | Torrent download client (routed via Gluetun)        | Routed via Gluetun (`8080`)       |
| **Prowlarr**    | Indexer manager (routed via Gluetun to bypass ISP blocks) | Routed via Gluetun (`9696`)  |
| **FlareSolverr**| Cloudflare challenge proxy for indexers like 1337x   | Routed via Gluetun (`8191`)       |
| **Jellyfin**    | Media server for streaming                           | `8096`                            |
| **Sonarr**      | TV show management & automation                      | `8989`                            |
| **Radarr**      | Movie management & automation                        | `7878`                            |

## Directory Structure

This setup uses the recommended unified `/data` directory structure for optimal compatibility between all services:

```
~/data/                                   # Main data directory in home
├── movies/                               # Radarr root folder
├── shows/                                # Sonarr root folder
└── downloads/
    └── qbittorrent/
        ├── completed/                    # Finished downloads
        ├── incomplete/                   # In-progress downloads
        └── torrents/                     # .torrent files

~/home_lab/media-stack/                   # Docker compose directory
├── .env.example                          # Example VPN configuration
├── .env                                  # Your local VPN credentials
├── docker-compose.yml
├── gluetun/                              # Gluetun configuration / data
├── jellyfin/
│   ├── config/                           # Jellyfin configuration
│   └── cache/                            # Jellyfin cache
├── qbittorrent/
│   └── config/                           # qBittorrent configuration
├── prowlarr/
│   └── config/                           # Prowlarr configuration
├── sonarr/
│   └── config/                           # Sonarr configuration
└── radarr/
    └── config/                           # Radarr configuration
```

> **Why unified `~/data`?** Using a single `~/data:/data` mount point for all containers prevents path mapping issues. Multiple separate mounts like `/tv`, `/movies`, and `/downloads` can appear as different filesystems to Docker, causing hardlinking failures and wasted disk space.

## Prerequisites

- Docker and Docker Compose installed
- Ubuntu/Debian-based system (or similar)
- Intel CPU with QuickSync or dedicated GPU for hardware transcoding (optional but recommended)
- At least 20GB free disk space for configs and metadata
- Separate storage for media files
- VPN provider subscription or free tier credentials supporting WireGuard or OpenVPN (e.g. ProtonVPN, Mullvad, etc.)

### Check Your User ID

All containers run as user `1000:1000` by default. Verify your user ID:

```bash
id $USER
```

If your UID/GID is different from `1000`, update the `PUID` and `PGID` values in the compose file.

## Installation

### 1. Create Directory Structure

Navigate to your preferred location and create the necessary directories:

Create the unified data structure in your home directory:

```bash
mkdir -p ~/data/{movies,shows,downloads/qbittorrent/{completed,incomplete,torrents}}
```

Create a directory for your compose file:

```bash
mkdir -p ~/home_lab/media-stack
cd ~/home_lab/media-stack
```

Create config directories (Docker will populate these):

```bash
mkdir -p gluetun jellyfin/{config,cache} qbittorrent/config prowlarr/config sonarr/config radarr/config
```

### 2. Configure VPN Credentials (`.env`)

Copy the example environment file to `.env`:

```bash
cp .env.example .env
```

Edit `.env` with your VPN settings:

```bash
nano .env
```

Key environment settings:
- **`VPN_SERVICE_PROVIDER`**: Provider name (e.g., `protonvpn`, `mullvad`, `nordvpn`, `custom`). Default is `protonvpn`.
- **`VPN_TYPE`**: Protocol type, typically `wireguard` (recommended for speed and efficiency) or `openvpn`.
- **`WIREGUARD_PRIVATE_KEY`**: Your WireGuard private key obtained from your VPN provider dashboard.
- **`VPN_FREE_ONLY`**: Set to `on` if using ProtonVPN free tier servers, or `off` for paid tiers.
- **`VPN_SERVER_COUNTRIES`**: Preferred exit country (e.g., `Netherlands`, `United States`).

#### How qBittorrent and Prowlarr Route Through Gluetun

- **Network Routing (`network_mode: "service:gluetun"`)**: Both `qbittorrent` and `prowlarr` share Gluetun's network stack.
  - **qBittorrent**: All torrent download and upload traffic is encrypted and forced through the VPN tunnel.
  - **Prowlarr**: All indexer queries (e.g. YTS, 1337x, TorrentGalaxy) route through the VPN. This bypasses ISP-level DNS/IP blocks (such as those enforced in India by Jio, Airtel, ACT, etc.).
- **Killswitch Protection**: If the VPN tunnel disconnects, Gluetun's built-in firewall automatically prevents any unencrypted traffic from leaking.
- **Port Exposure**: Because services sharing Gluetun's network namespace cannot expose their own ports, their ports are published directly on the `gluetun` service container:
  - `8080:8080`: qBittorrent Web UI
  - `6881:6881` & `6881:6881/udp`: qBittorrent torrent transfers
  - `9696:9696`: Prowlarr Web UI
- **Local Network Access (`FIREWALL_OUTBOUND_SUBNETS`)**: Gluetun is configured with `FIREWALL_OUTBOUND_SUBNETS=192.168.0.0/16,172.16.0.0/12,10.0.0.0/8`. This allows Sonarr and Radarr to reach Prowlarr (`http://gluetun:9696` or `http://172.17.0.1:9696`) and qBittorrent (`http://gluetun:8080`), and lets Prowlarr sync directly with Sonarr and Radarr without hitting the VPN killswitch.

### 3. Deploy the Stack

Place your `docker-compose.yml` and `.env` in the `~/home_lab/media-stack` directory, then start the services:

```bash
docker compose up -d
```

### 4. Verify Services

Check that all containers are running:

```bash
docker compose ps
```

`qbittorrent` waits for `gluetun` to reach a healthy status before starting.

Verify Gluetun VPN connection and status:

```bash
docker logs gluetun
```

You should see logs indicating a successful connection, assigned VPN IP address, and healthy status.

## Configuration

### Initial Access

After deployment, access each service's web interface:

- **Jellyfin**: <http://your-server-ip:8096>
- **Sonarr**: <http://your-server-ip:8989>
- **Radarr**: <http://your-server-ip:7878>
- **qBittorrent**: <http://your-server-ip:8080> (routed via Gluetun)
- **Prowlarr**: <http://your-server-ip:9696>

### qBittorrent Setup

1. **Get Initial Password**: The temporary password is in the container logs:

   ```bash
   docker logs qbittorrent
   ```

   Look for a line like: `The WebUI administrator password was not set. A temporary password is provided for this session: XXXXXXXX`

2. **Configure Download Paths** (Settings → Downloads):
   - **Default Save Path**: `/data/downloads/qbittorrent/completed`
   - **Keep incomplete torrents in**: `/data/downloads/qbittorrent/incomplete`
   - **Copy .torrent files to**: `/data/downloads/qbittorrent/torrents`

3. **Change Default Credentials** (Settings → Web UI → Authentication):
   - Set a secure username and password

### Prowlarr Setup

1. Complete the initial setup wizard
2. Add indexers (Settings → Indexers → Add Indexer). Indexers like **YTS**, **1337x**, etc. will now resolve properly via Gluetun's VPN, bypassing Indian ISP blocks.
3. Connect to Sonarr and Radarr (Settings → Apps → Add Application):
   - **Sonarr**: <http://sonarr:8989> or <http://172.17.0.1:8989> (Docker host IP)
   - **Radarr**: <http://radarr:7878> or <http://172.17.0.1:7878>
   - **Prowlarr Server URL**: <http://gluetun:9696> (or <http://172.17.0.1:9696>) so Sonarr/Radarr can reach Prowlarr through Gluetun
   - Get API keys from Sonarr/Radarr (Settings → General)
4. **Configure FlareSolverr Proxy (for Cloudflare-protected indexers like 1337x)**:
   - Go to **Settings** ➔ **Indexers**
   - Under **Proxies**, click **+** and choose **FlareSolverr**
   - **Name**: `FlareSolverr`
   - **Tags**: `flaresolverr`
   - **Host**: `http://localhost:8191` (or `http://127.0.0.1:8191`)
   - Click **Test** and **Save**
   - When adding or editing **1337x**, add the tag `flaresolverr` so Prowlarr routes its requests through FlareSolverr.
5. (Optional) Connect Download Client (Settings → Download Clients → Add → qBittorrent):
   - **Host**: `127.0.0.1` or `gluetun` (since both qBittorrent and Prowlarr share Gluetun's network)
   - **Port**: `8080`
   - **Username/Password**: Your qBittorrent credentials

### Sonarr Setup

1. **Add Root Folder** (Settings → Media Management → Root Folders):
   - Add `/data/shows`

2. **Add Download Client** (Settings → Download Clients → Add → qBittorrent):
   - **Host**: `gluetun` (or use Docker host IP `172.17.0.1`)
   - **Port**: `8080`
   - **Username/Password**: Your qBittorrent credentials
   - **Category**: `sonarr`
   > **Connecting behind Gluetun**: Because qBittorrent uses `network_mode: "service:gluetun"`, it shares the network stack with Gluetun. Sonarr should connect to `gluetun` on port `8080` (or the Docker host gateway IP `172.17.0.1:8080`).

3. Indexers will be automatically added from Prowlarr

### Radarr Setup

1. **Add Root Folder** (Settings → Media Management → Root Folders):
   - Add `/data/movies`

2. **Add Download Client** (Settings → Download Clients → Add → qBittorrent):
   - **Host**: `gluetun` (or use Docker host IP `172.17.0.1`)
   - **Port**: `8080`
   - **Username/Password**: Your qBittorrent credentials
   - **Category**: `radarr`
   > **Connecting behind Gluetun**: Because qBittorrent shares Gluetun's network stack, set the host to `gluetun` (port `8080`) or the Docker host gateway IP (`172.17.0.1:8080`).

3. Indexers will be automatically added from Prowlarr

### Jellyfin Setup

1. Complete the initial setup wizard
2. Create an admin account
3. **Add Media Libraries**:
   - **Movies**: `/data/movies`
   - **TV Shows**: `/data/shows`

4. **Enable Hardware Transcoding** (Dashboard → Playback → Transcoding):
   - Select **Intel QuickSync** (if using Intel CPU)
   - Enable hardware encoding for relevant codecs

5. **Verify Hardware Access**:

   ```bash
   docker exec jellyfin ls -l /dev/dri
   ```

   You should see `renderD128` listed.

## Usage

### Adding Content

**TV Shows**:

1. Go to Sonarr (<http://your-server-ip:8989>)
2. Click "Add Series" and search for your show
3. Select quality profile and monitor options
4. Click "Add Series"

**Movies**:

1. Go to Radarr (<http://your-server-ip:7878>)
2. Click "Add Movie" and search for your movie
3. Select quality profile and monitor options
4. Click "Add Movie"

### Monitoring Downloads

- View active downloads in qBittorrent (<http://your-server-ip:8080>)
- Track import progress in Sonarr/Radarr → Activity → Queue

### Watching Content

1. Open Jellyfin (<http://your-server-ip:8096>)
2. Browse your organized libraries
3. Content appears automatically after Sonarr/Radarr imports it

## Troubleshooting

### VPN / Gluetun Issues

1. **Check VPN Connection Status**:

   ```bash
   docker logs gluetun
   ```

   Look for `VPN agent status: HEALTHY` and IP allocation.

2. **Verify Public IP is Masked**:
   Check the external IP reported through the VPN container:

   ```bash
   docker exec gluetun wget -qO- https://ipinfo.io
   ```

   Verify that the returned IP and country match your VPN server and not your home ISP.

3. **Sonarr/Radarr Cannot Connect to qBittorrent**:
   - Confirm that `FIREWALL_OUTBOUND_SUBNETS=192.168.0.0/16,172.16.0.0/12,10.0.0.0/8` is present in Gluetun's environment so that traffic from Docker bridges is allowed.
   - Set the download client host in Sonarr/Radarr to `gluetun` (port `8080`) or `172.17.0.1` (port `8080`).
   - Check that qBittorrent is running (`docker compose ps`). Remember that qBittorrent will wait for Gluetun to become healthy before starting.

### Permission Issues

If you see permission errors, verify ownership:

```bash
# Check data directory permissions
ls -la ~/data

# Fix if needed (usually not necessary in home directory)
chmod -R 755 ~/data

# Check config directory permissions
ls -la ~/home_lab/media-stack
```

### Hardware Transcoding Not Working

1. **Verify device passthrough**:

   ```bash
   docker exec jellyfin ls -l /dev/dri
   ```

2. **Check render group**:

   ```bash
   getent group render
   ```

3. **Add your user to render group**:

   ```bash
   sudo usermod -aG render $USER
   ```

4. **Restart the container**:

   ```bash
   docker compose restart jellyfin
   ```

### Sonarr/Radarr Can't See Downloads

1. Verify qBittorrent download paths match the configuration above
2. Check that all containers use `/data:/data` mount
3. Ensure qBittorrent categories are set correctly

### Containers Won't Start

View logs to identify the issue:

```bash
docker compose logs <service-name>
```

Common fixes:

```bash
# Restart the stack
docker compose restart

# Rebuild and restart
docker compose up -d --force-recreate

# Check for port conflicts
sudo netstat -tulpn | grep -E ':(8096|8989|7878|8080|9696)'
```

### Reset Everything

To start fresh (⚠️ **WARNING**: This deletes all configurations):

```bash
docker compose down -v
rm -rf gluetun/ jellyfin/ qbittorrent/ prowlarr/ sonarr/ radarr/
```

Then follow installation steps again.

## Credits

This setup is based on best practices from:

- [TechHutTV Homelab](https://github.com/TechHutTV/homelab)
- [Gluetun Wiki](https://github.com/qdm12/gluetun-wiki)
- [Servarr Wiki](https://wiki.servarr.com/)
- [Trash Guides](https://trash-guides.info/)

## Additional Resources

- [Gluetun Documentation](https://github.com/qdm12/gluetun)
- [Jellyfin Documentation](https://jellyfin.org/docs/)
- [Sonarr Wiki](https://wiki.servarr.com/sonarr)
- [Radarr Wiki](https://wiki.servarr.com/radarr)
- [Prowlarr Wiki](https://wiki.servarr.com/prowlarr)
- [qBittorrent Documentation](https://github.com/qbittorrent/qBittorrent/wiki)

---
