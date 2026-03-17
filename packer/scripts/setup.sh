#!/bin/bash
set -euo pipefail

echo "==> Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

echo "==> Installing base dependencies..."
sudo apt-get install -y \
  curl \
  wget \
  nginx \
  jq

echo "==> System setup complete."
