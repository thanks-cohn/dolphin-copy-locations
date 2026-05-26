#!/usr/bin/env bash
set -euo pipefail

SRC="$HOME/dev/dolphin-f9"

if [ ! -d "$SRC" ]; then
    echo "dolphin-f9 source tree not found."
    exit 1
fi

cd "$SRC"

echo

echo "Checking dolphinmainwindow.cpp"
grep -n "copyLocation->setEnabled(!list.isEmpty())" src/dolphinmainwindow.cpp

echo

echo "Checking dolphincontextmenu.cpp"
grep -n "copyPathAction->setEnabled(!m_selectedItems.isEmpty())" src/dolphincontextmenu.cpp

echo

echo "Checking dolphinview.cpp"
grep -n "paths.join(QStringLiteral" src/views/dolphinview.cpp

echo

echo "Patch verification complete."
