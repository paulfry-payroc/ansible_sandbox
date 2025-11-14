#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Removing Ansible sandbox Docker node (node1)..."
docker rm -f node1 2>/dev/null || true
