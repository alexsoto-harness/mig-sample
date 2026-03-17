#!/bin/bash
set -euo pipefail

echo "==> Cleaning up..."

# Clean apt cache
sudo apt-get clean
sudo apt-get autoremove -y
sudo rm -rf /var/lib/apt/lists/*

# Clear logs
sudo truncate -s 0 /var/log/syslog || true
sudo truncate -s 0 /var/log/auth.log || true

# Remove SSH keys (Packer's temporary key)
sudo rm -f /home/packer/.ssh/authorized_keys 2>/dev/null || true

echo "==> Cleanup complete. Image is ready."
