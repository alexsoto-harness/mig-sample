#!/bin/bash
set -euo pipefail

echo "==> Configuring nginx as demo application..."

# Create a simple demo page that shows instance metadata
sudo tee /var/www/html/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>MIG Demo App</title>
  <style>
    body { font-family: sans-serif; margin: 40px; background: #f5f5f5; }
    .card { background: white; padding: 24px; border-radius: 8px; max-width: 500px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
    h1 { color: #0278d5; }
    .meta { color: #666; font-size: 14px; }
  </style>
</head>
<body>
  <div class="card">
    <h1>MIG Demo Application</h1>
    <p>This instance was provisioned by <b>Packer</b> and deployed by <b>Harness</b>.</p>
    <div class="meta" id="info">Loading instance metadata...</div>
  </div>
  <script>
    fetch('http://metadata.google.internal/computeMetadata/v1/instance/name', {headers:{'Metadata-Flavor':'Google'}})
      .then(r => r.text())
      .then(name => {
        document.getElementById('info').innerHTML = 'Instance: <b>' + name + '</b>';
      })
      .catch(() => {
        document.getElementById('info').innerHTML = 'Running locally (no GCP metadata)';
      });
  </script>
</body>
</html>
EOF

# Enable and configure nginx
sudo systemctl enable nginx
sudo systemctl start nginx

echo "==> Application installed successfully."
