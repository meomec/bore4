#!/usr/bin/env bash
set -euo pipefail

DEST="/usr/local/bin/bore4"

echo "Installing bore4..."
chmod +x bore4
sudo cp bore4 "$DEST"

echo "✅ Installed! Run: bore4 --help"
