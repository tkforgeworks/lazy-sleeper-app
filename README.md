# lazy-sleeper-app

The companion app for [Lazy Sleeper](https://github.com/tkforgeworks/lazy-sleeper) — a draft-day companion and
in-season roster assistant for [Sleeper](https://sleeper.com) NFL fantasy leagues.

This repo is the **client**: presentation only. All domain logic (ingestion, scoring, projections, draft
state) lives in the Python/FastAPI backend at `tkforgeworks/lazy-sleeper`; this app is a pure consumer of
that API and never reimplements it.

## Status

Flutter app on Windows, web and Android, covering LS-39 in full:

- **Big Board** — ranked, filterable player table (projections, VORP, tier, ADP, bye week) with a player
  detail drawer, over `GET /board`.
- **Draft Command Center** — read-only draft-night view over `GET /draft/{id}/state`: pick clock, on-the-clock
  team, picks-until-you, your roster seats, the backend's recommendation with one line of why and two
  fallbacks, best-available table with bye weeks and survival bars, tier-cliff / run / value / injury
  alerts, pick ticker.
  At your turn with 30 s or less the panic overlay highlights the pick — **the app never submits a pick;
  that happens in Sleeper.** The runner (`POST /draft/{id}/start|stop`) is driven from the same screen.
- **Logs** — `package:logging` capture with a per-session file on desktop/mobile and an in-app Logs view
  (copy / save / verbose), for reading alongside the backend's log during a live test.
- **Settings** (gear) — API address, `/state` poll interval (1–5 s, default 2), panic threshold, best-available
  depth, per-alert switches, theme (dark / light / system) and log level. Saved across launches, applied
  live; "Reset to defaults" clears the lot.

The view redraws on the backend's `recompute.seq`, so how quickly a new pick shows up is mostly the poll
interval — drop it to 1 s on draft night if the room is fast. The draft-night fallback remains the backend's
own `/draft.html`.

## Running it

Requires Flutter 3.47+ and a running backend (`lazy serve`, port 8000 by default).

```sh
flutter pub get
flutter run -d windows          # or -d chrome
flutter run -d windows --dart-define=LS_API_URL=http://100.x.y.z:8000   # e.g. the tailnet address
flutter run -d chrome --dart-define=LS_FAKE_DATA=true                   # bundled fixture, no backend
```

The API address can also be changed in-app (gear → Settings) and is remembered across launches, as is the
draft id. `--dart-define=LS_LOG_LEVEL=FINE` sets the start-up log level; the Verbose switch in Settings (or
the Logs view, icon beside the gear) overrides it and is remembered. The Logs view shows where the session
log file is.

Draft night: start `lazy serve`, open Draft, enter the Sleeper draft id, **Start runner** before the room
opens, and leave the tab there. The runner is polled only while it is up — a stopped, complete or unknown
draft is fetched once and then left alone until you press Start again.

Checks, as CI runs them from the repo root:

```sh
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Models under `lib/api/models/` are generated (`freezed` + `json_serializable`); after editing one run
`dart run build_runner build --delete-conflicting-outputs` and commit the output.

## Releasing

The same tagless model as the org's Electron pipeline, done for Flutter in `.github/workflows/release-flutter.yml`
(a `workflow_call` reusable, written here so it can move to `tkforgeworks/.github` unchanged; `release.yml` is the
thin caller). Every push to `main` or a `v*/main` branch runs it and it decides for itself:

| `pubspec.yaml` version | on branch | result |
|---|---|---|
| `X.Y.Z-rc.N+B` | `vX.Y.Z/main` | prerelease `vX.Y.Z-rc.N` |
| `X.Y.Z+B` | `main` (via the release PR) | release `vX.Y.Z` |
| anything else, or the tag exists | — | no-op |

Version bumps are ordinary commits made by the bump helper (PowerShell and bash do the same thing):

```sh
scripts/release/bump-version.sh rc      # on v0.1.0/main: 0.1.0-rc.1+2, commit, push → CI publishes the prerelease
scripts/release/bump-version.sh final   # 0.1.0+3, commit, push, opens the release PR into main → merge cuts v0.1.0
```

The base version comes from the release-branch name; `+BUILD` goes up on every bump. The tag is created
server-side when CI publishes, so nothing here needs to bypass branch protection. CI's jobs: check-release
(the gate above) → release notes (org `release-notes.yml`) + `ci-flutter.yml` as the quality gate → Windows
installer on `windows-latest`, signed APK on `ubuntu-latest` (keystore from the `ANDROID_KEYSTORE_BASE64` /
`ANDROID_KEYSTORE_PASSWORD` / `ANDROID_KEY_ALIAS` repo secrets) → draft release, upload, publish.

The build scripts CI runs are the same ones you can run locally; artifacts land in `release/` (gitignored):

```sh
scripts/release/build-windows.ps1   # flutter build windows → release/lazy-sleeper-app-<v>-windows-x64-setup.exe + .zip
scripts/release/build-android.sh    # flutter build apk (signed) → release/lazy-sleeper-app-<v>-android.apk  (.ps1 too)
```

- **Windows**: an [Inno Setup 6](https://jrsoftware.org/isinfo.php) installer (`winget install JRSoftware.InnoSetup`;
  script in `windows/installer/lazy-sleeper.iss`) — a wizard with the per-user / all-users choice, an install
  directory page, Start Menu and optional desktop shortcut, the same shape as the org's NSIS assisted installer
  for Electron apps. The build script copies the VC++ runtime DLLs into the bundle from the local Visual Studio
  redist. The installer is **not code-signed**: SmartScreen shows "Windows protected your PC" on first run —
  *More info → Run anyway*. The zip is the bare bundle for anyone who prefers no installer.
- **Android**: signed with the upload keystore named in `android/key.properties`. Both files are gitignored and
  live in 1Password; `scripts/release/new-android-keystore.ps1` creates a fresh pair the first time (never
  regenerate one that has shipped — Android ties updates to the key). Without `key.properties`, `flutter run
  --release` falls back to the debug key and the release script refuses to build.
- **Icons**: `assets/brand/app_icon.png` (dark tile) and `app_icon_foreground.png` (adaptive foreground), both
  512×512 renders of the brand mark; `dart run flutter_launcher_icons` regenerates the Windows `.ico` and the
  Android mipmaps from them.
- **Version**: `pubspec.yaml` `version: X.Y.Z[-rc.N]+BUILD`. `X.Y.Z[-rc.N]` names the tag, installer and
  release; `+BUILD` is the Android `versionCode` and must go up on every APK that reaches a device — the bump
  helper does that.

## Design

`docs/design_handoff_lazy_sleeper/` holds the design handoff (screens, component specs, HTML prototypes,
fonts). `docs/LS-39-plan.md` is the implementation plan for the first increments.

## Contributing / branch policy

`main` is protected by the TK ForgeWorks standard repository ruleset (see
[`tkforgeworks/.github/docs/branch-protection-ruleset.md`](https://github.com/tkforgeworks/.github/blob/main/docs/branch-protection-ruleset.md)):
no direct pushes, no force-push/delete, all changes via PR, no bypass. CI consumes the org's reusable
Flutter workflow. Commit subjects follow `LS-N: ...` (Jira project `LS`).

Work flows through a version branch: topic branches (`vX.Y.Z/LS-N-topic`) are PR'd into the current release
branch (`vX.Y.Z/main`, currently `v0.1.0/main`), and the release branch reaches `main` via a release PR.
