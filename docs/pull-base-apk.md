# pull-base-apk.sh

Search for an installed package by name and pull only its `base.apk` via ADB. Optionally verifies the pulled APK's signature with `apksigner` if installed.

## Requirements

- `adb` installed and available in your `PATH`
- A connected Android device with USB debugging enabled
- Bash (auto-detects WSL and uses `adb.exe` where needed)
- (optional) `apksigner` on your `PATH` for signature verification — part of Android SDK build-tools

## Usage

```
chmod +x scripts/pull-base-apk.sh
./scripts/pull-base-apk.sh
```

You'll be prompted to:

1. Enter a search term to find the target package (partial match supported)
2. If multiple packages match, refine your search until exactly one result remains
3. Enter a save location, or press Enter to save in the current directory

If `apksigner` is available on your `PATH`, the script automatically verifies the pulled APK's signing certificate and prints the result.

## Example

```
$ ./scripts/pull-base-apk.sh

Search for package: chrome
com.android.chrome

1 results

Save location [default: current directory]: ./apks

Saved to: ./apks/base.apk

Verifying signature...
Signer #1 certificate DN: ...
Signer #1 certificate SHA-256 digest: ...
```
