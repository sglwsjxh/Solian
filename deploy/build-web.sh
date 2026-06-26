#!/bin/bash
# Build Flutter Web for self-hosted Solian deployment
set -e

DOMAIN="${DOMAIN:-akiromusic.art}"
API_URL="https://api.${DOMAIN}"

echo "Building Flutter Web for ${DOMAIN}..."
echo "API_BASE_URL=${API_URL}"

cd "$(dirname "$0")/.."

# Clean previous build
rm -rf build/web

# Build release
flutter build web \
  --release \
  --dart-define=API_BASE_URL=${API_URL} \
  --dart-define=FLUTTER_WEB_CANVAS_TO_KV=true

echo ""
echo "✓ Build complete!"
echo "  Output: build/web/"
echo "  Size:   $(du -sh build/web | cut -f1)"
echo ""
echo "Deploy the build/web/ directory to your web server."
echo "See deploy/README.md for nginx + Cloudflare Tunnel setup."
