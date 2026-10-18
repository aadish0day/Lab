# Fast pull for cyber_lab

Everything that actually makes `docker compose` pull images faster for this
collection. The compose files themselves can't change network speed — pull
performance is a **Docker daemon** setting — so the real work happens here.

## 1. Daemon config (the part that makes it faster)

```bash
./install-daemon.sh
```

This installs `/etc/docker/daemon.json`:

| Key                        | Value                   | Why                                                                                                                                                                                      |
| :------------------------- | :---------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `registry-mirrors`         | `https://mirror.gcr.io` | Docker Hub pull-through cache. Faster layer fetches and it sidesteps the anonymous Docker Hub limit of **100 pulls / 6 h per IP**, the usual cause of "slow" pulls across a big lab set. |
| `max-concurrent-downloads` | `16`                    | Downloads 16 layers at once instead of 3 (the default).                                                                                                                                  |
| `max-concurrent-uploads`   | `8`                     | Same, for pushes.                                                                                                                                                                        |
| `max-download-attempts`    | `10`                    | More retries on flaky layer fetches.                                                                                                                                                     |

**It restarts Docker**, which stops running containers. Run it when idle.

Requires `sudo`, so it can't be applied automatically from a non-root shell.

> The mirror only accelerates **Docker Hub** (`docker.io`) images. Most images in
> `cyber_lab` are Docker Hub (`vulhub/*`, `mysql`, `postgres`, …), but images from
> `ghcr.io`, `quay.io`, etc. still come straight from their registry.

Verify:

```bash
docker info | grep -A2 'Registry Mirrors'
```

## 2. Parallel pre-pull (warm the cache)

```bash
./prepull-all.sh                 # every lab (tens of GB — be careful)
JOBS=8 ./prepull-all.sh          # 8 labs at a time
./prepull-all.sh Classes/02_web_penetration_tester/16_advanced_sql_injection
```

`COMPOSE_PARALLEL_LIMIT` (default 16) controls per-lab concurrency; `JOBS`
(default 4) controls how many labs pull at once.

## 3. Per-compose-file change already made

Every service that pulls an image now carries:

```yaml
pull_policy: missing
```

`missing` is Compose's default for `up`, so this mainly makes the intent
explicit: use the local image if it exists and don't hit the registry at all.
It was added to 1904 services across 1799 files. Services that **build** their
image (or inherit one through a YAML anchor) were intentionally left alone.
