#!/usr/bin/env bash
set -euo pipefail

# Use same default list as create script
read -r -a NODES_ARR <<< "${NODES:-node1 node2}"

echo "🗑️  Removing Docker containers: ${NODES_ARR[*]}"
for node in "${NODES_ARR[@]}"; do
    if [ -n "$(docker ps -aq -f name="$node")" ]; then
        docker rm -f "$node" >/dev/null 2>&1 || true
        echo "✅ Removed $node"
    else
        echo "ℹ️  $node not found, skipping"
    fi
done
