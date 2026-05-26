#!/usr/bin/env bash
set -euo pipefail

SRC="$HOME/dev/dolphin-f9"

if [ ! -d "$SRC/.git" ]; then
    echo "No git repo found at $SRC"
    exit 1
fi

cd "$SRC"

git reset --hard
git clean -fd

echo
echo "Dolphin source reset to upstream state."
