# dolphin-copy-locations

`dolphin-copy-locations` is a small source patch for KDE Dolphin that makes the native **Copy Location** action work with **multiple selected files**, not just one.

The goal is simple:

```text
Select files in Dolphin
Press Copy Location, or a shortcut like F9
Paste newline-separated absolute paths anywhere
```

Before this patch, Dolphin's `Copy Location` action was effectively single-item oriented. It copied the location of the first/current selected file and disabled the context-menu action when multiple items were selected. This project removes that artificial limitation.

## Important assumptions

Right now, the helper scripts in this repository are designed primarily for:

- Arch Linux
- Garuda Linux
- KDE Plasma
- Dolphin

The scripts also assume the following local layout:

```text
~/dev/dolphin-copy-locations
~/dev/dolphin-f9
```

Where:

- `dolphin-copy-locations` is this repository
- `dolphin-f9` is the local cloned Dolphin source tree

The scripts are intentionally simple and inspectable.

If you use another distro or another directory layout, modify the scripts accordingly.

## What changes

Before:

```text
Select five files
Use Copy Location
Only one path is copied
```

After:

```text
Select five files
Use Copy Location
All five paths are copied, one per line
```

Example clipboard output:

```text
/home/user/Pictures/one.png
/home/user/Pictures/two.png
/home/user/Videos/clip.mp4
/home/user/Documents/report.pdf
/home/user/Downloads/archive.zip
```

## Why this matters

This turns Dolphin into a better bridge between graphical file selection and shell/script/AI workflows.

A file manager already knows what you selected. The clipboard should be able to carry that selection as clean text, so it can be pasted into terminals, scripts, notes, manifests, chat tools, documentation, build commands, batch processors, and local-first workflows.

This is not a new file manager. It is a tiny behavioral correction to an existing one.

## Features

- Enables `Copy Location` for multiple selected files.
- Copies all selected paths, newline-separated.
- Preserves single-file behavior.
- Works with Dolphin's native `Copy Location` action.
- Works with a keyboard shortcut such as `F9` when assigned inside Dolphin.
- No `xdotool` hacks.
- No clipboard scraping.
- No service-menu trampoline required.

## Quick start on Arch / Garuda

From this repo:

```bash
./scripts/build-patched-dolphin.sh
```

Run the patched Dolphin without replacing your system Dolphin:

```bash
./scripts/run-patched-dolphin.sh
```

Then in Dolphin:

```text
Settings -> Configure Keyboard Shortcuts -> Copy Location -> bind F9
```

Now test:

```text
Select multiple files -> press F9 -> paste
```

You should get all selected file locations, one per line.

## Scripts

### `scripts/build-patched-dolphin.sh`

Installs build dependencies on Arch/Garuda, clones KDE Dolphin into `~/dev/dolphin-f9` if needed, applies the patch, and builds it locally.

### `scripts/run-patched-dolphin.sh`

Kills currently running Dolphin windows and launches the patched local build from `~/dev/dolphin-f9/build/bin/dolphin`.

### `scripts/verify-patch.sh`

Checks the patched Dolphin source tree for the expected multi-selection copy-location changes.

### `scripts/reset-dolphin-source.sh`

Resets the local `~/dev/dolphin-f9` source tree back to upstream clean state. Useful before rebuilding.

## Patch summary

The patch changes three areas:

1. `src/dolphinmainwindow.cpp`

Enables `Copy Location` whenever the selection is not empty instead of only when exactly one item is selected.

2. `src/dolphincontextmenu.cpp`

Enables the context-menu `Copy Location` action for multiple selected items.

3. `src/views/dolphinview.cpp`

Changes `copyPathToClipboard()` from copying only `list.at(0)` to collecting every selected item into a `QStringList` and copying the paths joined by `\n`.

## Philosophy

The filesystem is not just storage. It is a working surface.

Dolphin already lets users select multiple files visually. This patch makes that selection immediately useful as plain, composable text.

Tiny patch. Big workflow upgrade.

## License

This repository is released under the included custom source-available non-commercial license. See `LICENSE`.
