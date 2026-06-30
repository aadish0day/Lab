# Hadoop on Docker Compose

A 4-node Hadoop cluster (HDFS + YARN) using the **official `apache/hadoop` image** (currently `3.5.0`, published by the Apache Hadoop project itself — not a third-party rebuild).

| Service        | Role                       | Web UI                              |
|----------------|----------------------------|--------------------------------------|
| namenode       | HDFS master                | http://localhost:9870                |
| datanode       | HDFS storage node          | (no UI exposed by default)           |
| resourcemanager| YARN master                | http://localhost:8088                |
| nodemanager    | YARN worker                | http://localhost:8042                |

HDFS RPC is also exposed on `localhost:8020` if you want to talk to the cluster from outside Docker (e.g. a Spark job running on the host).

## Requirements

- Docker + Docker Compose v2 (the `docker compose` subcommand, not the old standalone `docker-compose` v1 binary)
- Give Docker at least **4–6 GB RAM** (Docker Desktop → Settings → Resources). Four JVM-based daemons in default config will OOM-loop on the default 2GB.

## Start it

```bash
docker compose up -d
```

First boot takes a minute: the image is ~760MB and the NameNode has to format itself. Watch it come up:

```bash
docker compose logs -f namenode
```

Once `namenode` reports healthy (`docker compose ps`), check the cluster:

```bash
# HDFS report — should show 1 live datanode
docker exec -it namenode hdfs dfsadmin -report

# YARN nodes — should show 1 RUNNING nodemanager
docker exec -it resourcemanager yarn node -list
```

Or just open http://localhost:9870 and http://localhost:8088.

## Smoke test (run an actual job)

```bash
docker exec -it resourcemanager bash -c \
  'hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar pi 2 4'
```

This runs Pi estimation across the cluster — no HDFS input data needed, good first check that YARN can actually schedule and run containers. If you want an HDFS-based test:

```bash
docker exec -it namenode bash -c '
  hdfs dfs -mkdir -p /user/root/input &&
  hdfs dfs -put $HADOOP_HOME/etc/hadoop/*.xml /user/root/input &&
  hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar wordcount /user/root/input /user/root/output &&
  hdfs dfs -cat /user/root/output/part-r-00000
'
```

## Scaling DataNodes / NodeManagers

`datanode` and `nodemanager` have no fixed hostname or container name, so they scale cleanly:

```bash
docker compose up -d --scale datanode=3 --scale nodemanager=3
```

## Stopping / wiping data

```bash
docker compose down          # stop + remove containers, keep HDFS data (named volumes)
docker compose down -v       # also wipe HDFS data — next start is a fresh format
```

## Why a few things are set the way they are

- **`user: root` on every service** — the stock image runs as an unprivileged `hadoop` user, which works fine until you bind-mount your own volume onto a brand-new path (e.g. for persistence below); Docker creates that mount point as root, and the `hadoop` user can't write to it. Running as root sidesteps that permission mismatch. This is fine for a local/dev cluster; don't do it for anything internet-facing.
- **Explicit `dfs.namenode.name.dir` / `dfs.datanode.data.dir`** — the image's published example config doesn't set these, so Hadoop falls back to a default under `/tmp` that's keyed to the *current user name*. That default actually changed recently when the image's default user moved from `root` to `hadoop`, which broke restart-persistence for anyone relying on it ([HDFS-17307](https://issues.apache.org/jira/browse/HDFS-17307)). Pointing both at fixed, explicit paths and mounting named volumes there sidesteps that entirely — data survives `docker compose down` / `up` cycles.
- **`dfs.permissions.enabled=false`** — avoids permission-denied errors when you `hdfs dfs` as whatever user you happen to be. Fine for local dev, turn it back on (and configure real users) before anything resembling production.
- **Healthcheck on namenode, `depends_on: condition: service_healthy`** — without this, `datanode`/`resourcemanager` can start before the NameNode has finished formatting/coming up, which just means noisier logs while they retry — but waiting for the healthcheck keeps first-boot logs clean.
- **`ENSURE_NAMENODE_DIR` points to the `current/` subdirectory** — Docker volume mounts create the target directory, so the image's starter.sh skips formatting if the directory already exists (even if empty). By pointing at `current/` (which HDFS creates during format), the fresh-volume check works correctly.
- **`$$HADOOP_HOME` in the env_file** — docker-compose interpolates `$VARIABLE` in env_files against the host environment. `$$` escapes it so the literal `$HADOOP_HOME` is passed to the container, where it resolves at runtime.

## Changing the Hadoop version

Edit the `image:` tag in `docker-compose.yml` (all four services). Tags are published at https://hub.docker.com/r/apache/hadoop/tags.
