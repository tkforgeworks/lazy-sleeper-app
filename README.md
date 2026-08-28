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
