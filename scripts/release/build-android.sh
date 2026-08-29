#!/usr/bin/env bash
# Builds the signed Android release APK into release/. Same behaviour as
# build-android.ps1 (keep them in step); this is the one CI runs on
# ubuntu-latest.
#
# flutter build apk --release, signed with the keystore named in
# android/key.properties (create one with new-android-keystore.ps1, or let
# release-flutter.yml write it from the ANDROID_KEYSTORE_* secrets). Refuses
# to run without it — a debug-signed APK is not a release. The version and
# build number come from pubspec.yaml (`version: X.Y.Z+BUILD`; BUILD is the
# Android versionCode and must go up on every APK that reaches a device).
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$root"

if [[ ! -f android/key.properties ]]; then
  echo "android/key.properties is missing. Run scripts/release/new-android-keystore.ps1 (or restore the keystore + key.properties from 1Password)." >&2
  exit 1
fi

full="$(sed -n 's/^version:[[:space:]]*//p' pubspec.yaml | tr -d '[:space:]')"
app_version="${full%%+*}"
echo "Lazy Sleeper $full → APK version $app_version"

flutter build apk --release

mkdir -p release
apk="release/lazy-sleeper-app-$app_version-android.apk"
cp build/app/outputs/flutter-apk/app-release.apk "$apk"
ls -l "$apk"
