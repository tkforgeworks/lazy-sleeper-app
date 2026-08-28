; Lazy Sleeper — Windows installer (Inno Setup 6).
;
; The Flutter analogue of the org's electron-builder NSIS "assisted" installer:
; a wizard with a per-user / all-users choice, an install-directory page,
; Start Menu + optional desktop shortcut, and an uninstaller that leaves
; app data alone. Built by scripts/release/build-windows.ps1, which passes
; /DAppVersion=<pubspec version> and /DSourceDir=<flutter release bundle>.
; Run ISCC by hand only with both defines set.

#ifndef AppVersion
  #error Pass /DAppVersion=x.y.z (scripts/release/build-windows.ps1 does)
#endif
#ifndef SourceDir
  #define SourceDir "..\..\build\windows\x64\runner\Release"
#endif
#define AppName "Lazy Sleeper"
#define AppExe "lazy_sleeper_app.exe"
#define Publisher "TK ForgeWorks"

[Setup]
; Stable per app: Windows uses it to recognise upgrades. Never change it.
AppId={{6F3B9C1E-5A2D-4E7B-9C0A-2D8F1B4E7A61}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#Publisher}
AppPublisherURL=https://github.com/tkforgeworks/lazy-sleeper-app
AppSupportURL=https://github.com/tkforgeworks/lazy-sleeper-app/issues
; {autopf} is Program Files for an all-users install and
; %LOCALAPPDATA%\Programs for the current user only.
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\{#AppExe}
; Per-user by default; the wizard offers all-users (elevating) as a choice.
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputDir=..\..\release
OutputBaseFilename=lazy-sleeper-app-{#AppVersion}-windows-x64-setup
SetupIconFile=..\runner\resources\app_icon.ico
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
; Unsigned: SmartScreen will warn on first run ("More info" → "Run anyway").

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "{#SourceDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExe}"; Description: "{cm:LaunchProgram,{#StringChange(AppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
