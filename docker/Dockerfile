# Minimal base with Python 3 preinstalled for Ansible
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends python3 ca-certificates \
 && ln -sf /usr/bin/python3 /usr/bin/python \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Keep the container alive like your current flow
CMD ["sleep", "infinity"]
