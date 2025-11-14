#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Creating Ansible sandbox Docker node (node1)..."

# Remove any existing container
docker rm -f node1 2>/dev/null || true

# Create node1, exposed on host port 80 -> container port 80
docker run -d \
  --name node1 \
  -p 80:80 \
  ubuntu:22.04 \
  sleep infinity

echo "[INFO] Installing Python and basic tools inside node1..."
docker exec -it node1 bash -c '
  apt-get update -y &&
  apt-get install -y python3 python3-apt curl
'

echo "[INFO] node1 is ready for Ansible."
