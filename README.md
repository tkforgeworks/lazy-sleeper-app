# lazy-sleeper-app

The companion app for [Lazy Sleeper](https://github.com/tkforgeworks/lazy-sleeper) — a draft-day companion and
in-season roster assistant for [Sleeper](https://sleeper.com) NFL fantasy leagues.

This repo is the **client**: presentation only. All domain logic (ingestion, scoring, projections, draft
state) lives in the Python/FastAPI backend at `tkforgeworks/lazy-sleeper`; this app is a pure consumer of
that API and never reimplements it.

## Status

Flutter app, first increment of LS-39: the **Big Board** (ranked, filterable player table with a player
detail drawer) over the backend's `GET /board`, on Windows, web and Android. Next: the draft companion view
over `GET /draft/{id}/state`. The draft-night fallback remains the backend's own `/draft.html`.

## Running it

Requires Flutter 3.47+ and a running backend (`lazy serve`, port 8000 by default).

```sh
flutter pub get
flutter run -d windows          # or -d chrome
flutter run -d windows --dart-define=LS_API_URL=http://100.x.y.z:8000   # e.g. the tailnet address
flutter run -d chrome --dart-define=LS_FAKE_DATA=true                   # bundled fixture, no backend
```

The API address can also be changed in-app (gear icon) and is remembered across launches.

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
