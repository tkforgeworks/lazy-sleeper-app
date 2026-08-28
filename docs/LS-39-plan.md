# LS-39 — Flutter board + companion view: implementation plan

Status: **planned, not started** (2026-08-26). Design review done; backend gap tickets filed (LS-56–LS-61).
Pick up here when kicking off work.

## Context

- Design handoff: `docs/design_handoff_lazy_sleeper/` (README, COMPONENTS, `lib/ls_theme.dart`, HTML prototypes).
  **Not yet committed** — land it as the first commit on the feature branch.
- Backend contract: `C:\Code\lazy-sleeper\docs\api\` (README, GUIDE, openapi.json). `/board` and
  `/draft/{id}/state` exist today (backend v0.1.0); `/board` rows are untyped until LS-55.
- Draft night: Fri 2026-09-04. HTML fallback (`/draft.html`) is the guaranteed surface.

## Backend gaps (filed 2026-08-26)

| Key | Gap | Blocks |
|---|---|---|
| LS-56 | pick clock (`pick_deadline`), on-the-clock team name, `recent_picks` in `/draft/{id}/state` | TimerBlock, PanicOverlay, PickTicker — **only draft-night blocker** |
| LS-57 | `bye` on board/draft rows | BYE column |
| LS-58 | `GET /players/{id}` | Player Detail drawer content |
| LS-59 | `GET /benchmarks/scoreboard` + run deltas (+ ensemble row) | Garage MAE scoreboard |
| LS-60 | `GET /season/state` weekly payload | Season Monitor (blocked on LS-49) |
| LS-61 | `/model/knobs`, `/model/backtest` (+ reconcile slider names with LS-42) | Garage knobs (blocked on LS-42/43/59) |

Product decisions: **panic overlay is a highlight only — the app never submits a pick to Sleeper**
(LS-56 owns fixing the handoff README line that says "auto-drafts"). ForgeModel column stays a stub.

## Toolchain (do first)

- Installed: Flutter 3.16.5 / Dart 3.2.3 (Dec 2023). **Run `flutter upgrade`** — riverpod/freezed/google_fonts
  current versions need Dart ≥ 3.5. `flutter doctor` otherwise green for Windows, web, Chrome, Android (SDK 35).

## Increment 1 (this PR): skeleton + theme + API client + Big Board + stub drawer

Increment 2 (separate PR, same ticket): draft companion view — poll `/draft/{id}/state?limit=40` every ~2 s,
redraw only when `recompute.seq` changes, read-only, no timer/panic until LS-56.

### Decisions

| | Choice | Why / tradeoff |
|---|---|---|
| Platforms | windows, web, android | What the doctor supports. macOS/iOS/linux added later, never removed. |
| State | `flutter_riverpod` (no codegen) | Constructor injection via providers, easy test overrides. Bare `ChangeNotifier` is fine for 2 screens but awkward once draft polling lands. |
| API client | Hand-written `dio` + `freezed`/`json_serializable` models mirroring `docs/api` | OpenAPI codegen yields `Object` for `/board` until LS-55; dart-dio generator is heavy magic for 2 endpoints. Revisit codegen after LS-55. |
| Routing | `go_router`, shell route: top text-pill nav ≥ 1024 dp, bottom `NavigationBar` below | Per handoff. |
| Base URL | `--dart-define=LS_API_URL` default + in-app override (settings sheet, `shared_preferences`) | LS-39 AC: tailnet address configurable without rebuild. |
| Fonts | **Bundle** handoff TTFs (Poppins static 400–800, JetBrains Mono + Source Serif 4 variable) — not `google_fonts` | Draft night is over Tailscale; runtime font fetch is a failure point. Variable fonts need `FontVariation('wght', w)` — one helper in `ls_theme.dart`. |
| Layout | `lib/app/` (theme, router, shell) · `lib/api/` (client, models) · `lib/features/board/` | Feature-first. Client-side logic limited to sort / position filter / tier-break grouping (handoff assigns these to the client). |
| Tests | Widget tests for sort/filter/tier-breaks; repository test with fake Dio adapter + fixture JSON | Behavior, not implementation. |
| CI | Not in this PR | Needs a reusable `ci-flutter.yml` in `tkforgeworks/.github` first — file as a follow-up task; then PATCH the branch ruleset to require it (see `.claude/CLAUDE.md`). |

### Board screen specifics (from handoff README §1)

- Desktop: 45 px top nav → toolbar (position FilterChips, RANK BY SegmentedTabs: Ensemble/Sleeper/ESPN/ForgeModel/ADP,
  count, "Export tier sheet" secondary button — stub) → 13-col grid, cols `40/flex/46/42/60/60/62/68/58/46/56/56/148`,
  rows 29 px. TierBreak rows only in ensemble sort. Footer strip with formula + ΔADP legend.
- Mobile (< 1024 dp): 5-col rows (rank / T-badge+pos / name+sub / ENS / VORP); drawer → 62 %-height bottom sheet.
- Data mapping: SLPR/ESPN = `components.sleeper/espn`; ENS = `points`; FORGE = "—"; BYE = "—" until LS-57;
  SPLIT flag = `disagree` (show `spread`); Q/OUT = `injury_status`; ΔADP = `adp_delta` (+ = value, `adp_flag`).
- Drawer (stub): name/team/pos/injury + SourceProjectionBars from `components`; other sections render an
  "arrives with LS-58" placeholder in the app's editorial voice.

### Branch mechanics

`LS-39-flutter-board` from `main`. Commits (subjects `LS-39: ...`):
1. Add design handoff docs (+ this plan)
2. Scaffold Flutter app, theme, bundled fonts, router shell
3. Add API client + board models + fixture tests
4. Add Big Board screen (desktop + mobile) + stub drawer
5. Update `.claude/CLAUDE.md` (backend `/board` + `/state` exist; skeleton unblocked; stack decisions)

PR to `main`, self-merge.

## Open question (needs Tim)

- **Fixture source for `/board`:** run the backend locally (`lazy serve` in `C:\Code\lazy-sleeper` — needs DB
  access) and capture a real response, or build the fixture from the backend's test fixtures?
