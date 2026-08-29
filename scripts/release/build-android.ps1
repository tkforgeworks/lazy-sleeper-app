#Requires -Version 7
<#
.SYNOPSIS
  Builds the signed Android release APK into release/.

.DESCRIPTION
  flutter build apk --release, signed with the keystore named in
  android/key.properties (create one with new-android-keystore.ps1). Refuses
  to run without it — a debug-signed APK is not a release. The version and
  build number come from pubspec.yaml (`version: X.Y.Z+BUILD`; BUILD is the
  Android versionCode and must go up on every APK that reaches a device).
  Same behaviour as build-android.sh (keep them in step); forward slashes so
  it also runs under pwsh on Linux/macOS.
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
Set-Location $root

if (-not (Test-Path 'android/key.properties')) {
    throw 'android/key.properties is missing. Run scripts/release/new-android-keystore.ps1 (or restore the keystore + key.properties from 1Password).'
}

$version = (Select-String -Path pubspec.yaml -Pattern '^version:\s*(\S+)').Matches[0].Groups[1].Value
$appVersion = $version.Split('+')[0]
Write-Host "Lazy Sleeper $version → APK version $appVersion"

flutter build apk --release
if ($LASTEXITCODE) { throw "flutter build apk failed ($LASTEXITCODE)" }

$release = Join-Path $root 'release'
New-Item -ItemType Directory -Force $release | Out-Null
$apk = Join-Path $release "lazy-sleeper-app-$appVersion-android.apk"
Copy-Item 'build/app/outputs/flutter-apk/app-release.apk' $apk -Force

Get-Item $apk | Select-Object Name, @{ n = 'MB'; e = { [math]::Round($_.Length / 1MB, 1) } }
