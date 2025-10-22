#!/usr/bin/env bash
set -euo pipefail

IMAGE_TAG="ansible-node:22.04"

echo "🔧 Ensuring image ${IMAGE_TAG} exists..."
if ! docker image inspect "${IMAGE_TAG}" >/dev/null 2>&1; then
  docker build -t "${IMAGE_TAG}" -f docker/Dockerfile docker
  echo "✅ Built ${IMAGE_TAG}"
else
  echo "ℹ️  Found existing ${IMAGE_TAG}"
fi

echo "🚀 Creating Docker containers (node1, node2) from ${IMAGE_TAG}"
for node in node1 node2; do
  if [ -z "$(docker ps -aq -f name="$node")" ]; then
    docker run -d --name "$node" --hostname "$node" "${IMAGE_TAG}"
    echo "✅ Created $node"
  else
    echo "ℹ️  $node already exists; ensuring it's running"
    docker start "$node" >/dev/null 2>&1 || true
  fi
done
