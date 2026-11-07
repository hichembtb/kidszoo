#!/bin/bash
set -eo pipefail

PROJECT="kidsZoo.xcodeproj"
SCHEME="kidsZoo"
DERIVED_DATA_DIR="build/DerivedData"
APP="$DERIVED_DATA_DIR/Build/Products/Debug-iphonesimulator/kidsZoo.app"

echo "🔍 Resolving target iOS Simulator..."

# 1. Check for an already booted simulator device
DEVICE_UDID=$(xcrun simctl list devices 2>/dev/null | grep -E '\(Booted\)' | grep -E -o '[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}' | head -n 1 || true)

if [ -n "$DEVICE_UDID" ]; then
    DEVICE_NAME=$(xcrun simctl list devices 2>/dev/null | grep "$DEVICE_UDID" | sed -E 's/^[[:space:]]*//; s/[[:space:]]*\([0-9A-F-]+\).*//' | head -n 1)
    echo "📱 Using currently booted simulator: $DEVICE_NAME ($DEVICE_UDID)"
else
    # 2. Look for an available iPhone simulator
    DEVICE_UDID=$(xcrun simctl list devices available 2>/dev/null | grep -i "iPhone" | grep -E -o '[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}' | head -n 1 || true)

    # 3. Fall back to any listed iPhone simulator
    if [ -z "$DEVICE_UDID" ]; then
        DEVICE_UDID=$(xcrun simctl list devices 2>/dev/null | grep -i "iPhone" | grep -E -o '[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}' | head -n 1 || true)
    fi

    if [ -z "$DEVICE_UDID" ]; then
        echo "" >&2
        echo "❌ Error: No iPhone simulator found on this machine." >&2
        echo "Please install an iOS Simulator runtime in Xcode:" >&2
        echo "  Xcode -> Settings -> Platforms -> iOS Simulator" >&2
        echo "or create a device using:" >&2
        echo "  xcrun simctl create \"My iPhone\" \"iPhone 16 Pro\"" >&2
        exit 1
    fi

    DEVICE_NAME=$(xcrun simctl list devices 2>/dev/null | grep "$DEVICE_UDID" | sed -E 's/^[[:space:]]*//; s/[[:space:]]*\([0-9A-F-]+\).*//' | head -n 1)
    echo "📱 Booting simulator: $DEVICE_NAME ($DEVICE_UDID)..."
    xcrun simctl boot "$DEVICE_UDID" 2>/dev/null || true
    open -a Simulator 2>/dev/null || true
fi

echo "🏗️  Building $SCHEME for $DEVICE_NAME..."

xcodebuild \
  -project "$PROJECT" \
  -scheme "$SCHEME" \
  -destination "platform=iOS Simulator,id=$DEVICE_UDID" \
  -derivedDataPath "$DERIVED_DATA_DIR" \
  build || exit 1

echo "📦 Installing application on simulator..."

# Ensure InjectionIII discovery paths and bundles are linked
mkdir -p DerivedData
rm -f DerivedData/kidsZoo /tmp/injection.link
ln -s "../$DERIVED_DATA_DIR" DerivedData/kidsZoo
ln -s "$PWD/$APP" /tmp/injection.link

xcrun simctl install "$DEVICE_UDID" "$APP"

BUNDLE_ID=$(/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" "$APP/Info.plist")

echo "🚀 Launching application ($BUNDLE_ID)..."

SIMCTL_CHILD_INJECTION_DERIVED_DATA="$PWD/$DERIVED_DATA_DIR" xcrun simctl launch "$DEVICE_UDID" "$BUNDLE_ID"

echo ""
echo "╔══════════════════════════════════════╗"
echo "║                                      ║"
echo "║       🦊  kidsZoo is ready! 🐻       ║"
echo "║                                      ║"
echo "║       🚀 Build successful            ║"
echo "║       📱 App launched in Simulator   ║"
echo "║                                      ║"
echo "╚══════════════════════════════════════╝"
echo ""
