#!/usr/bin/env bash
set -euo pipefail

BIN="$HOME/dev/dolphin-f9/build/bin/dolphin"

if [ ! -x "$BIN" ]; then
    echo "Patched Dolphin binary not found."
    echo "Run ./scripts/build-patched-dolphin.sh first."
    exit 1
fi

killall dolphin 2>/dev/null || true

sleep 0.5

"$BIN" &

echo "Launched patched Dolphin:"
echo "$BIN"
