#!/usr/bin/env bash
set -euo pipefail

APP_NAME="NativeRazerMacOS"
DISPLAY_NAME="Razer macOS Native"
BUNDLE_ID="com.w2ysw3m.NativeRazerMacOS"
MIN_SYSTEM_VERSION="14.0"
APP_VERSION="${APP_VERSION:-0.4.14}"
SIGNING_MODE="${MACOS_SIGNING_MODE:-auto}"
SIGN_IDENTITY="${MACOS_CODESIGN_IDENTITY:-}"
NOTARIZE="${MACOS_NOTARIZE:-0}"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE_DIR="$ROOT_DIR/NativeRazerMacOS"
DIST_ROOT="$ROOT_DIR/dist"
DIST_DIR="$DIST_ROOT/release"
BUILD_DIR="$DIST_ROOT/native-release"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"
APP_CONTENTS="$APP_BUNDLE/Contents"
APP_MACOS="$APP_CONTENTS/MacOS"
APP_BINARY="$APP_MACOS/$APP_NAME"
INFO_PLIST="$APP_CONTENTS/Info.plist"
ZIP_PATH="$DIST_DIR/$APP_NAME-$APP_VERSION-macOS.zip"
DMG_PATH="$DIST_DIR/$APP_NAME-$APP_VERSION-macOS.dmg"
NOTARY_ZIP="$DIST_DIR/$APP_NAME-$APP_VERSION-notary.zip"
CHECKSUM_PATH="$DIST_DIR/SHA256SUMS.txt"

usage() {
  cat >&2 <<USAGE
usage: APP_VERSION=0.4.14 MACOS_SIGNING_MODE=auto|required|adhoc|none ./script/package_native.sh

Environment:
  APP_VERSION                 Release version written into Info.plist and artifact names.
  MACOS_SIGNING_MODE          auto, required, adhoc, or none. Default: auto.
  MACOS_CODESIGN_IDENTITY     Signing identity name. Developer ID Application is preferred.
  MACOS_NOTARIZE              1 to notarize with notarytool. Default: 0.
  APPLE_API_KEY_PATH          Path to AuthKey_*.p8 when MACOS_NOTARIZE=1.
  APPLE_API_KEY_ID            App Store Connect API key id when MACOS_NOTARIZE=1.
  APPLE_API_ISSUER_ID         App Store Connect issuer id when MACOS_NOTARIZE=1.
USAGE
}

find_signing_identity() {
  security find-identity -p codesigning -v | awk -F '"' '/Developer ID Application/ { print $2; exit }'
}

resolve_signing_identity() {
  case "$SIGNING_MODE" in
    none)
      echo ""
      ;;
    adhoc)
      echo "-"
      ;;
    required)
      if [[ -z "$SIGN_IDENTITY" ]]; then
        SIGN_IDENTITY="$(find_signing_identity)"
      fi
      if [[ -z "$SIGN_IDENTITY" ]]; then
        echo "Developer ID Application identity is required when MACOS_SIGNING_MODE=required." >&2
        exit 1
      fi
      echo "$SIGN_IDENTITY"
      ;;
    auto)
      if [[ -n "$SIGN_IDENTITY" ]]; then
        echo "$SIGN_IDENTITY"
        return
      fi
      local identity
      identity="$(find_signing_identity)"
      if [[ -n "$identity" ]]; then
        echo "$identity"
      else
        echo "-"
      fi
      ;;
    -h|--help|help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown MACOS_SIGNING_MODE: $SIGNING_MODE" >&2
      usage
      exit 2
      ;;
  esac
}

write_info_plist() {
  cat >"$INFO_PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleExecutable</key>
  <string>$APP_NAME</string>
  <key>CFBundleIdentifier</key>
  <string>$BUNDLE_ID</string>
  <key>CFBundleName</key>
  <string>$DISPLAY_NAME</string>
  <key>CFBundleDisplayName</key>
  <string>$DISPLAY_NAME</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>CFBundleShortVersionString</key>
  <string>$APP_VERSION</string>
  <key>CFBundleVersion</key>
  <string>$APP_VERSION</string>
  <key>LSMinimumSystemVersion</key>
  <string>$MIN_SYSTEM_VERSION</string>
  <key>NSPrincipalClass</key>
  <string>NSApplication</string>
</dict>
</plist>
PLIST
}

sign_path() {
  local path="$1"
  local identity="$2"

  if [[ -z "$identity" ]]; then
    echo "Skipping codesign for $path"
    return
  fi

  local args=(--force --deep --strict --sign "$identity")
  if [[ "$identity" != "-" ]]; then
    args+=(--options runtime --timestamp)
  fi

  codesign "${args[@]}" "$path"
}

verify_signed_path() {
  local path="$1"
  local identity="$2"

  if [[ -z "$identity" ]]; then
    echo "Skipping codesign verification for unsigned artifact: $path"
    return
  fi

  codesign --verify --deep --strict --verbose=2 "$path"
}

notarize_path() {
  local path="$1"
  local identity="$2"

  if [[ "$NOTARIZE" != "1" ]]; then
    return
  fi

  if [[ -z "$identity" || "$identity" == "-" ]]; then
    echo "Notarization requires a Developer ID Application signing identity." >&2
    exit 1
  fi

  if [[ -z "${APPLE_API_KEY_PATH:-}" || -z "${APPLE_API_KEY_ID:-}" || -z "${APPLE_API_ISSUER_ID:-}" ]]; then
    echo "APPLE_API_KEY_PATH, APPLE_API_KEY_ID, and APPLE_API_ISSUER_ID are required when MACOS_NOTARIZE=1." >&2
    exit 1
  fi

  xcrun notarytool submit "$path" \
    --key "$APPLE_API_KEY_PATH" \
    --key-id "$APPLE_API_KEY_ID" \
    --issuer "$APPLE_API_ISSUER_ID" \
    --wait
}

create_zip() {
  local output="$1"
  rm -f "$output"
  ditto -c -k --keepParent "$APP_BUNDLE" "$output"
}

create_dmg() {
  rm -f "$DMG_PATH"
  hdiutil create \
    -volname "$DISPLAY_NAME" \
    -srcfolder "$APP_BUNDLE" \
    -ov \
    -format UDZO \
    "$DMG_PATH"
}

main() {
  rm -rf "$BUILD_DIR" "$DIST_DIR"
  mkdir -p "$APP_MACOS" "$DIST_DIR"

  swift build -c release --package-path "$PACKAGE_DIR"
  local build_binary
  build_binary="$(swift build -c release --package-path "$PACKAGE_DIR" --show-bin-path)/$APP_NAME"
  cp "$build_binary" "$APP_BINARY"
  chmod +x "$APP_BINARY"
  write_info_plist

  local identity
  identity="$(resolve_signing_identity)"
  sign_path "$APP_BUNDLE" "$identity"
  verify_signed_path "$APP_BUNDLE" "$identity"

  if [[ "$NOTARIZE" == "1" ]]; then
    create_zip "$NOTARY_ZIP"
    notarize_path "$NOTARY_ZIP" "$identity"
    xcrun stapler staple "$APP_BUNDLE"
    rm -f "$NOTARY_ZIP"
  fi

  create_zip "$ZIP_PATH"
  create_dmg
  sign_path "$DMG_PATH" "$identity"
  verify_signed_path "$DMG_PATH" "$identity"
  notarize_path "$DMG_PATH" "$identity"
  if [[ "$NOTARIZE" == "1" ]]; then
    xcrun stapler staple "$DMG_PATH"
  fi

  (
    cd "$DIST_DIR"
    shasum -a 256 "$(basename "$ZIP_PATH")" "$(basename "$DMG_PATH")" >"$CHECKSUM_PATH"
  )

  echo "Artifacts:"
  echo "  $ZIP_PATH"
  echo "  $DMG_PATH"
  echo "  $CHECKSUM_PATH"
}

main "$@"
