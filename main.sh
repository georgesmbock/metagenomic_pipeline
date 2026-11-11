#!/usr/bin/env bash
set -Eeuo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
command -v docker >/dev/null 2>&1 || { echo "ERROR: Docker is required." >&2; exit 127; }
docker compose version >/dev/null 2>&1 || { echo "ERROR: Docker Compose v2 is required." >&2; exit 127; }
mkdir -p results logs
docker compose run --rm pipeline snakemake \
  --snakefile workflow/Snakefile \
  --cores 4 \
  --resources mem_mb=7000 \
  --printshellcmds \
  --rerun-incomplete \
  --show-failed-logs \
  "$@"
