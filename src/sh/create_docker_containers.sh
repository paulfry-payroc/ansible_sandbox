#!/usr/bin/env bash
set -euo pipefail

IMAGE="${IMAGE:-ubuntu:22.04}"
# NODES can be space-separated: "node1 node2"
read -r -a NODES_ARR <<< "${NODES:-node1 node2}"

echo "🚀 Spinning up Docker containers with image: $IMAGE"
for node in "${NODES_ARR[@]}"; do
    if [ -z "$(docker ps -aq -f name="$node")" ]; then
        docker run -d --name "$node" --hostname "$node" "$IMAGE" sleep infinity
        echo "✅ Created $node"
    else
        echo "ℹ️  $node already exists, skipping"
    fi
done
