# Media Stack - Self-Hosted Automation

A complete media automation stack using Docker Compose with Jellyfin, Sonarr, Radarr, qBittorrent, and Prowlarr.

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
- Manage torrent downloads securely
- Search and index content across multiple sources

## Stack Components

| Service | Purpose | Web UI Port |
|---------|---------|-------------|
| **Jellyfin** | Media server for streaming | `8096` |
| **Sonarr** | TV show management & automation | `8989` |
| **Radarr** | Movie management & automation | `7878` |
| **qBittorrent** | Torrent download client | `8080` |
| **Prowlarr** | Indexer manager for Sonarr/Radarr | `9696` |

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
├── docker-compose.yml
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
mkdir -p jellyfin/{config,cache} qbittorrent/config prowlarr/config sonarr/config radarr/config
```

### 2. Deploy the Stack

Place your `docker-compose.yml` in the `~/home_lab/media-stack` directory, then start the services:

```bash
docker compose up -d
```

### 3. Verify Services

Check that all containers are running:

```bash
docker compose ps
```

All services should show as "running" or "healthy".

## Configuration

### Initial Access

After deployment, access each service's web interface:

- **Jellyfin**: http://your-server-ip:8096
- **Sonarr**: http://your-server-ip:8989
- **Radarr**: http://your-server-ip:7878
- **qBittorrent**: http://your-server-ip:8080
- **Prowlarr**: http://your-server-ip:9696

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
2. Add indexers (Settings → Indexers → Add Indexer)
3. Connect to Sonarr and Radarr (Settings → Apps → Add Application):
   - **Sonarr**: http://172.17.0.1:8989 (use Docker host IP)
   - **Radarr**: http://172.17.0.1:7878
   - Get API keys from Sonarr/Radarr (Settings → General)

### Sonarr Setup

1. **Add Root Folder** (Settings → Media Management → Root Folders):
   - Add `/data/shows`

2. **Add Download Client** (Settings → Download Clients → Add → qBittorrent):
   - **Host**: Use Docker host IP (usually `172.17.0.1`)
   - **Port**: `8080`
   - **Username/Password**: Your qBittorrent credentials
   - **Category**: `sonarr`

3. Indexers will be automatically added from Prowlarr

### Radarr Setup

1. **Add Root Folder** (Settings → Media Management → Root Folders):
   - Add `/data/movies`

2. **Add Download Client** (Settings → Download Clients → Add → qBittorrent):
   - **Host**: Use Docker host IP (usually `172.17.0.1`)
   - **Port**: `8080`
   - **Username/Password**: Your qBittorrent credentials
   - **Category**: `radarr`

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
1. Go to Sonarr (http://your-server-ip:8989)
2. Click "Add Series" and search for your show
3. Select quality profile and monitor options
4. Click "Add Series"

**Movies**:
1. Go to Radarr (http://your-server-ip:7878)
2. Click "Add Movie" and search for your movie
3. Select quality profile and monitor options
4. Click "Add Movie"

### Monitoring Downloads

- View active downloads in qBittorrent (http://your-server-ip:8080)
- Track import progress in Sonarr/Radarr → Activity → Queue

### Watching Content

1. Open Jellyfin (http://your-server-ip:8096)
2. Browse your organized libraries
3. Content appears automatically after Sonarr/Radarr imports it

## Troubleshooting

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
rm -rf jellyfin/ qbittorrent/ prowlarr/ sonarr/ radarr/
```

Then follow installation steps again.

## Credits

This setup is based on best practices from:
- [TechHutTV Homelab](https://github.com/TechHutTV/homelab)
- [Servarr Wiki](https://wiki.servarr.com/)
- [Trash Guides](https://trash-guides.info/)

## Additional Resources

- [Jellyfin Documentation](https://jellyfin.org/docs/)
- [Sonarr Wiki](https://wiki.servarr.com/sonarr)
- [Radarr Wiki](https://wiki.servarr.com/radarr)
- [Prowlarr Wiki](https://wiki.servarr.com/prowlarr)
- [qBittorrent Documentation](https://github.com/qbittorrent/qBittorrent/wiki)

---

