# dolphin-copy-locations

Patch for KDE Dolphin that makes Copy Location work with multiple selected files.

Before:
Select many files -> Copy Location -> only one path copied.

After:
Select many files -> Copy Location / F9 -> all selected paths copied, newline-separated.

Build:
./scripts/build-patched-dolphin.sh

Run:
~/dev/dolphin-f9/build/bin/dolphin

Then in Dolphin:
Settings -> Configure Keyboard Shortcuts -> Copy Location -> F9
