#!/bin/bash
set -e

# is running under WSL?
if [ $(uname -r | grep -i "microsoft") ]; then
    ADB="adb.exe"
else
    ADB="adb"
fi

# check device is connected
if ! $ADB get-state >/dev/null 2>&1; then
    echo "Error: no device connected via adb" >&2
    exit 1
fi

search_package() {
    read -p 'Search for package: ' PKG
    RESULTS=$($ADB shell 'pm list packages' | sed 's/.*://' | sort | grep -F "$PKG")
    if [ -z "$RESULTS" ]; then
        RESULTS_COUNT=0
    else
        RESULTS_COUNT=$(echo "$RESULTS" | wc -l)
    fi
    echo "$RESULTS"
    echo ""
    echo "$RESULTS_COUNT results"
}

search_package
while [ "$RESULTS_COUNT" -ne 1 ]; do
    search_package
done

PACKAGE=$(echo "$RESULTS" | tr -d '\r' | tr -d '\n')

BASE_APK_PATH=$($ADB shell pm path "$PACKAGE" | grep "base.apk" | awk -F ':' '{print $2}' | tr -d '\r' | tr -d '\n')

if [ -z "$BASE_APK_PATH" ]; then
    echo "Error: base.apk not found for package $PACKAGE" >&2
    exit 1
fi

read -p "Save location [default: current directory]: " DEST
DEST="${DEST:-.}"
mkdir -p "$DEST"

"$ADB" pull "$BASE_APK_PATH" "$DEST/"

echo "Saved to: $DEST/base.apk"
# --- signature verification ---
if command -v apksigner >/dev/null 2>&1; then
    echo ""
    echo "Verifying signature..."
    apksigner verify --print-certs "$DEST/base.apk" || {
        echo "Warning: apksigner verification failed for $DEST/base.apk" >&2
    }
else
    echo ""
    echo "Note: apksigner not found on PATH, skipping signature verification."
    echo "Install Android SDK build-tools to enable this check."
fi