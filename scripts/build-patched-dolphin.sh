#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/dev"
cd "$HOME/dev"

sudo pacman -S --needed git base-devel cmake extra-cmake-modules qt6-base kio kxmlgui kcoreaddons kconfig kconfigwidgets ki18n kiconthemes kbookmarks kcompletion kcrash kdbusaddons knotifications kparts kservice solid baloo-widgets

if [ ! -d dolphin-f9 ]; then
  git clone https://invent.kde.org/system/dolphin.git dolphin-f9
fi

cd dolphin-f9

patch -p1 < "$HOME/dev/dolphin-copy-locations/patches/dolphin-copy-locations.patch" || true

cmake -B build -S . -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$HOME/.local"
cmake --build build -j"$(nproc)"

echo "Run patched Dolphin:"
echo "$HOME/dev/dolphin-f9/build/bin/dolphin"
