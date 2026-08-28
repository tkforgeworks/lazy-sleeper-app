#Requires -Version 7
<#
.SYNOPSIS
  Creates the Android release keystore and android/key.properties.

.DESCRIPTION
  One keystore for the life of the app: Android ties updates to the signing
  key, so a lost keystore means a new app id. Both files are gitignored.
  After running this, put android/upload-keystore.jks and the password
  (in android/key.properties) in 1Password. The password is never printed.

  Uses keytool from the JDK on PATH (Corretto 21 here); Android Studio's
  bundled JBR has one too.
#>
[CmdletBinding()]
param(
    [string]$Alias = 'upload',
    [string]$Dname = 'CN=Lazy Sleeper, O=TK ForgeWorks'
)

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$keystore = Join-Path $root 'android\upload-keystore.jks'
$props = Join-Path $root 'android\key.properties'

if (Test-Path $keystore) { throw "$keystore already exists. Not overwriting a signing key." }
if (-not (Get-Command keytool -ErrorAction SilentlyContinue)) { throw 'keytool not on PATH (install a JDK).' }

$chars = [char[]]((48..57) + (65..90) + (97..122))
$password = -join ((1..32) | ForEach-Object { $chars | Get-Random })

keytool -genkeypair -v -keystore $keystore -storetype PKCS12 -keyalg RSA -keysize 2048 -validity 10000 `
    -alias $Alias -dname $Dname -storepass $password -keypass $password
if ($LASTEXITCODE) { throw "keytool failed ($LASTEXITCODE)" }

@"
storePassword=$password
keyPassword=$password
keyAlias=$Alias
storeFile=../upload-keystore.jks
"@ | Set-Content -Path $props -Encoding ascii -NoNewline

Write-Host ''
Write-Host "Keystore:   $keystore"
Write-Host "Properties: $props  (holds the store/key password, alias '$Alias')"
Write-Host 'Save both files in 1Password now; neither is in git.'
