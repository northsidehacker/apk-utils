# apk-utils

A collection of tools and checklist for android bug hunting

## Requirements

- `adb` installed and available in your `PATH`
- A connected Android device with USB debugging enabled
- Bash (scripts auto-detect WSL and use `adb.exe` where needed)

## Structure

    apk-utils/
    ├── scripts/
    │   └── pull-base-apk.sh
    └── README.md

## Scripts

### `scripts/pull-base-apk.sh`

Search for an installed package by name and pull only its `base.apk` via ADB.

**Usage:**

```bash
chmod +x scripts/pull-base-apk.sh
./scripts/pull-base-apk.sh
```

You'll be prompted to:

1. Enter a search term to find the target package (partial match supported)
2. If multiple packages match, refine your search until exactly one result remains
3. Enter a save location, or press Enter to save in the current directory

**Example:**

$ ./scripts/pull-base-apk.sh

Search for package: chrome
com.android.chrome

1 results

Save location [default: current directory]: ./apks

Saved to: ./apks/base.apk

---

More scripts and checklists will be added here as the collection grows.

## License

MIT
