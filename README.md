# lazy-sleeper-app

The companion app for [Lazy Sleeper](https://github.com/tkforgeworks/lazy-sleeper) — a draft-day companion and
in-season roster assistant for [Sleeper](https://sleeper.com) NFL fantasy leagues.

This repo is the **client**: presentation only. All domain logic (ingestion, scoring, projections, draft
state) lives in the Python/FastAPI backend at `tkforgeworks/lazy-sleeper`; this app is a pure consumer of
that API and never reimplements it.

## Status

Greenfield — repository initialized, no application code yet. The backend API is still in development and
not ready to build against. Per the backend's decision log:

- Client stack: **Flutter** (desktop + web + mobile from one codebase)
- App skeleton starts once the backend's `/board` endpoint exists (backend milestone M3); first client
  story is LS-39 (read-only draft board / companion view)
- Draft-night fallback is an HTML page served by the backend, not this repo

## Contributing / branch policy

`main` is protected by the TK ForgeWorks standard repository ruleset (see
[`tkforgeworks/.github/docs/branch-protection-ruleset.md`](https://github.com/tkforgeworks/.github/blob/main/docs/branch-protection-ruleset.md)):
no direct pushes, no force-push/delete, all changes via PR, no bypass. A required CI status check will be
added to the ruleset once CI exists. Commit subjects follow `LS-N: ...` (Jira project `LS`).
