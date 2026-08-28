# lazy-sleeper-app — Claude reference

Client app for Lazy Sleeper (Sleeper NFL fantasy draft/in-season helper). **Presentation only** — all domain
logic lives in the Python/FastAPI backend repo `tkforgeworks/lazy-sleeper`; this app consumes its API and
never reimplements logic. Keep this file in sync as decisions land.

## Repo state (2026-08-28)

- Flutter app exists (LS-39 increment 1): scaffold, theme, API client, Big Board screen, API-address
  setting, and a Draft screen that drives the backend draft runner (`GET /draft`,
  `POST /draft/{id}/start|stop`; the draft id is remembered in prefs). Increment 2 (live companion view)
  is landing in slices under the same ticket: **2a** = `/draft/{id}/state` models (`lib/api/models/
  draft_state.dart`), `draftLiveProvider` (polls every 2 s, swaps `DraftLive.state` only when
  `recompute.seq` moves, 404 → `notRunning`, other failures keep the last good state), and a LIVE STATE
  strip on the Draft screen; **2b** = the Command Center layout (header, roster chips, best-available
  table, pick ticker); **2c** = pick clock ticking from `clock.pick_deadline`, RecommendationCard live
  state, panic highlight, alert cards. Fixtures for every phase live in `assets/fixtures/draft_state_*.json`
  (`FixtureLazySleeperApi.draftState*`), captured from mocks on 2026-08-28. Sleeper delivers mock CPU picks
  out of order (`picks_made` 3 with `current_pick` 7) — render from `current_pick`/`on_the_clock` only.
- Backend `lazy serve` runs on port **8000**, v0.1.2: LS-56 (`pick_deadline`, `on_the_clock_team_name`,
  `recent_picks`) and the LS-69/70 hang fixes are in. `/board`
  rows are untyped in its OpenAPI until LS-55, so `lib/api/models/board.dart` is transcribed by hand from
  `lazy-sleeper/docs/api/GUIDE.md`; `/state` is typed (`DraftStateOut`) and `draft_state.dart` mirrors it.
  Remaining backend gaps: LS-57..61 (none block draft night). Draft night: Fri 2026-09-04; the backend's
  `/draft.html` is the guaranteed fallback. `startDraft` uses a 60 s receive timeout (pre-draft load).
- `main` is protected by the org ruleset (PR-only, no bypass). CI (`.github/workflows/ci.yml`) consumes
  the org reusable `ci-flutter.yml`; the check **`ci / ci`** is required by the ruleset (strict, added
  2026-08-28 after its first green run on PR #1). Note: the GitHub ruleset update endpoint is `PUT`, not
  `PATCH` as `tkforgeworks/.github/docs/branch-protection-ruleset.md` says — fix that doc when next in
  the org repo. `ci-flutter.yml` was a stub; this repo is its first (passing) adopter.
- Plan and design handoff: `docs/LS-39-plan.md`, `docs/design_handoff_lazy_sleeper/` (README, COMPONENTS,
  HTML prototypes). Product decisions: panic overlay is a highlight only, the app never submits a pick;
  ForgeModel column is a stub until it ships.

## Stack and layout

- Flutter 3.47 / Dart 3.13, targets windows, web, android (others added later, never removed). Windows
  renders with **Skia**: `windows/runner/main.cpp` sets `ImpellerSwitch::Disabled` because Impeller's GL
  backend crashes at startup on AMD drivers. Revisit when Windows Impeller leaves GL.
- State: `flutter_riverpod` 3 without codegen (`Notifier`/`FutureProvider`; constructor-style injection via
  provider overrides). `boardProvider` sets `retry: null` — Riverpod 3 otherwise retries failures with
  backoff for ~1 min while showing loading. Routing: `go_router` `ShellRoute`, `NoTransitionPage`.
- API: `lib/api/` — `LazySleeperApi` interface, `HttpLazySleeperApi` (dio), `FixtureLazySleeperApi`
  (bundled `assets/fixtures/board.json`, a live capture trimmed to 53 rows). `ApiException` wraps
  transport/status/parse failures. Models are `freezed` + `json_serializable`; **generated files are
  committed** (CI runs no build_runner) — after editing a model run
  `dart run build_runner build --delete-conflicting-outputs`.
- Base URL: `--dart-define=LS_API_URL` (default `http://127.0.0.1:8000`; Android emulator needs
  `10.0.2.2`), overridable in-app (gear → dialog, persisted with `shared_preferences`).
  `--dart-define=LS_FAKE_DATA=true` runs on the fixture with no backend.
- Theme: `lib/app/theme/ls_theme.dart` — tokens from the handoff as an `LsColors` `ThemeExtension`
  (`context.ls`), dark default, light first-class. Fonts are **bundled** (`assets/fonts`, no google_fonts);
  JetBrains Mono and Source Serif 4 are variable fonts and need `FontVariation('wght', …)` (see `LsText`).
  Logomark is the design system's compact `mark-solid.svg` (the handoff file is the full lockup).
- Layout: `lib/app/` (theme, router, shell, settings, widgets/atoms) · `lib/api/` · `lib/features/<feature>/`.
  Client-side logic is limited to what the handoff assigns the client (sort, position filter, tier breaks,
  formatting — `board_view.dart`); numbers are never recomputed.
- Logging: `package:logging`, captured by `lib/app/log/app_log.dart` (`AppLog`, injected via
  `appLogProvider` like prefs). Loggers are named per area (`api`, `draft`, `settings`, `app`); the dio
  `LoggingInterceptor` logs one INFO line per request and bodies only at FINE. Desktop/mobile also write a
  per-session file (`%APPDATA%\<org>\<app>\logs\lazy-sleeper-app-<stamp>.log`, newest 10 kept, via the
  conditional `log_file.dart` export — web is in-memory only). The Logs button (next to the gear) shows a live
  tail with Copy / Save… / Verbose toggle; `--dart-define=LS_LOG_LEVEL=FINE` sets the start-up level. Tests
  install an `AppLog(echo: false)` in `pumpApp` with Flutter error hooks off (the test binding owns them).
- Board rules learned from real data: `tier` is **per position** and runs past 5, so tier breaks are drawn
  only under a position filter and only for tiers 1–5; `TierBadge` clamps deeper tiers to the T5 colour.
  ~65% of rows have `tier: null` (below tiered depth) → "—".
- Tests: behaviour-level widget tests via `test/support.dart` (`pumpApp` with fixture API, sync
  `RepoBundle`, mock prefs). Widget tests run under fake async — real file I/O never completes there.
  Visual checks: render to PNG from a throwaway widget test with `FontLoader` (see git history of LS-39);
  do not screenshot the user's desktop.

## Working conventions

- **Version-branch flow** (org standard, adopted 2026-08-28 after PR #1 went straight to `main`):
  `main` is the released state and only receives release PRs. Work happens on the current release
  branch `vX.Y.Z/main` (now **`v0.1.0/main`**, matching the unreleased `pubspec.yaml` version). Topic
  branches are `vX.Y.Z/LS-N-topic` off the release branch; PR into the release branch; self-merge allowed
  (0 required approvals). Never open a work PR against `main`. Release branches are unprotected today (org
  decision pending — see the handoff in `tkforgeworks/.github`), so check CI is green before merging.
  No release workflow or version-bump scripts yet: the org's are npm/Electron-only; a Flutter release
  pipeline is on the org handoff list, and this repo adopts it when it exists.
- Commit subjects `LS-N: ...`, imperative, `Fix ...` for bug fixes (they become release-note lines).
- CI contract from repo root: `dart format --output=none --set-exit-if-changed .`, `flutter analyze`,
  `flutter test`. `dart format` ignores analyzer excludes, so `.dart` files under `docs/` must stay
  formatted too.
- `.claude/settings.json` has a PreToolUse hook that reminds you to review this file before any
  `git commit` — update it when architecture, conventions, or project status change.
- Org shared standards (reusable CI, release notes, templates) live in `tkforgeworks/.github` — adopt from
  there rather than hand-rolling.
