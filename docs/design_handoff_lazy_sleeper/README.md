# Handoff: Lazy Sleeper — Flutter app design

## Overview
Complete UI design for **Lazy Sleeper**, a fantasy-football decision tool backed by the `tkforgeworks/lazy-sleeper` API (FastAPI). Four screens are designed at high fidelity in desktop (1280) and mobile (390) form factors: **Big Board + Player Detail**, **Draft Command Center** (with panic mode), **Tuning Garage**, and **Season Monitor**. Remaining screens (Waiver Room, Lineup View, Data Health, printable tier sheet, email digests) reuse the same components — see COMPONENTS.md.

Visual identity is the **TK ForgeWorks design system** (purple primary, forge-orange accent for ForgeModel only, Poppins / Source Serif 4 / JetBrains Mono, dark mode primary).

## About the design files
Files in `design_reference/` are **design references created in HTML** — interactive prototypes showing intended look and behavior, NOT production code. The task is to **recreate these designs in Flutter** using the token file (`lib/ls_theme.dart`) and the component specs (COMPONENTS.md). Open `design_reference/Lazy Sleeper.html` and `design_reference/Component Library.html` in a browser to inspect (they need the sibling js/css/font files kept next to them).

## Fidelity
**High-fidelity.** Colors, typography, spacing, and interactions are final. Recreate pixel-perfectly with Flutter widgets. All data in the prototypes is mock but mirrors the real API row shapes (below).

## Target
- Flutter, desktop + mobile from one codebase. Breakpoint: **≥ 1024 dp = desktop layout** (top text-pill nav, side panels/drawers), **< 1024 dp = mobile layout** (bottom NavigationBar, bottom sheets, stacked cards).
- Dark theme is the default; light theme is first-class (both palettes in ls_theme.dart, values from the design system).
- Fonts via google_fonts (Poppins, Source Serif 4, JetBrains Mono) or bundle the ttf files in `design_reference/fonts/`.

## Screens

### 1 · Big Board (+ Player Detail drawer)
- **Purpose:** the ranked, filterable player table; the app's home.
- **Layout (desktop):** 45px top nav (mark 22px, app name Poppins 700/15 purple, text-pill nav, league meta + snapshot LiveDot right) → toolbar (position FilterChips, "RANK BY" SegmentedTabs: Ensemble/Sleeper/ESPN/ForgeModel/ADP, count, "Export tier sheet" secondary button) → 13-column grid table. Columns: # 40 / player flex / pos 46 / bye 42 / SLPR 60 / ESPN 60 / FORGE 62 / ENS 68 / VORP 58 / TIER 46 / ADP 56 / ΔADP 56 / FLAGS 148. Rows 29px, padding 4×18, divider rgba(51,65,85,.35), hover rgba(196,149,244,.07). TierBreak rows only in ensemble sort. Footer strip: ensemble formula + ΔADP legend, JBMono 10.5 secondary.
- **Player Detail:** overlay drawer, 404px, right-anchored below nav, shadow −16px 0 32px rgba(0,0,0,.4). Content top→bottom: name (Poppins 600/20 purple) + meta + injury flag + close ×; SourceProjectionBars ×4; 3 actuals stat tiles (2023–25, “—” for pre-rookie years); usage sparkline pair (target share + snap%, purple/info strokes); floor/median/ceiling RangeBand; ADP trend sparkline card (falling = success, rising = warning); depth chart line; news (Source Serif italic 13/1.6).
- **Mobile:** condensed 5-col list rows (rank / T-badge+pos / name+sub / ENS / VORP), drawer becomes a 62%-height bottom sheet (r22 top corners, drag handle 38×4, scrim rgba(11,17,32,.55)), bottom tab bar.
- **Data:** `GET /board` — rank, player, team, pos, bye, per-source season pts, ensemble, vorp, tier, adp, adp_delta, disagreement (spread ≥ 24 pts → SPLIT flag), injury. Sort is client-side.

### 2 · Draft Command Center
- **Purpose:** everything glanceable on draft night; zero navigation.
- **Layout (desktop):** header (round.pick Poppins 700/17, on-the-clock team, TimerBlock JBMono 700/32 with 220×3 progress, picks-until-you box — highlights solid purple at my-turn) → RosterSlotChips strip ×10 → main split: left = RecommendationCard (idle/live/done states) + best-available table (#/tier/player/pos/ENS/VORP/SurvivalBar → next pick/RUN flag); right rail 316px = AlertCards (tier cliff, positional run, value faller, injury watch) + PickTicker.
- **Panic mode:** my turn AND timer ≤ 30s → full-screen overlay rgba(11,16,29,.97): countdown eyebrow (JBMono 600/13, +24% tracking, error), player name Poppins 800/64 filled with the forge gradient, one-line context, primary CTA, alternates line. Mobile: same at 800/38.
- **Mobile:** compact header (pick + timer + until-you), alert chips in horizontal rail, RecommendationCard, best-available list (tier+pos / name / VORP / surv%).
- **Data:** `GET /draft/{id}/state` — order by pick_score; survival % to next pick per row; alerts computed from signals (tier-cliff, run, faller).
- **Timer states:** text-primary > 20s, warning ≤ 20s, error ≤ 10s. Demo prototype runs at 6× — real app ticks 1×/s from websocket or poll.

### 3 · Tuning Garage
- **Purpose:** tune ForgeModel + ensemble weights with evidence.
- **Layout (desktop):** 3 columns, cause→effect left to right: 330px knobs (3 ForgeSliders — recency half-life 2–16 wks, usage/efficiency 0–100, injury haircut 0–40% — each with live value in forge-orange JBMono 600/11.5 and a Source Serif italic explainer) + "Re-run backtest" primary button (running state: gray fill + label swap, ~1s); 430px ensemble weights (per-position WeightStackBars + forge slider sets ForgeModel share, Sleeper/ESPN split remainder at fitted inverse-MAE ratio; manual-overrides Toggle, off = 45% opacity); flex = MAE scoreboard (POS × SLPR/ESPN/FORGE/ENS/NAIVE/ΔRUN; ENS column highlighted rgba(196,149,244,.08); Δ chips ▼ success / ▲ error).
- **Mobile:** stacked; scoreboard condensed to pos / best source / ENS / Δ.
- **Data:** `GET /ensemble/weights`, `PUT /ensemble/overrides`, `POST /board/regen`; MAE from data/benchmarks (season_scoreboard.csv). ForgeModel is not a provider yet — FORGE column stubs until it ships.

### 4 · Season Monitor
- **Purpose:** post-draft weekly tracking of the drafted team.
- **Layout (desktop):** top nav (team name, week n of 14, waiver deadline) → 4 StatCards (record, points for, vs projection, roster health) → split: WeekBarColumns ×8 (projected purple-tint vs actual purple-primary, W/L pill, tap to select; scale = pts/140) + 300px box-score card (top scorer / biggest miss / bench regret); → starters matrix: grid 150 / 34 / 14×30 / spark flex / 56 / 52 — name, PosChip, AvailabilityCells W1–14, W1–8 sparkline, season total, Δ vs projection (DeltaText).
- **Mobile:** 2×2 StatCards, compact chart with inline box-score line, per-player rows with 14-cell availability strip.
- **Data:** same weekly payload as the Sunday digest email. Availability states: played / played-Q / out / bye / upcoming(-Q).

## Interactions & behavior
- Board row tap → drawer (desktop overlay slide, mobile bottom sheet). Never navigate away from the board.
- Sort tabs re-rank client-side; sorted column header tints purple-primary; ensemble sort shows TierBreaks.
- All motion: **200ms ease, color/background only.** No entry animations, bounces, or parallax. Hover (desktop): row bg rgba(196,149,244,.07); links → purple-primary; cards gain shadow-md.
- Draft clock drives everything on the Command Center; the panic overlay auto-fires at `myTurn && timer ≤ 30` and **highlights the recommended pick only — it never submits a pick to Sleeper** (product decision 2026-08-26, LS-56: the app is display-only; picks are made in the Sleeper app). The prototype's auto-pick at 0 is not to be built. The timer comes from the API (`clock.pick_deadline`, fixed per pick — tick it locally; see the backend `docs/api/GUIDE.md` Workflow 1).
- Garage: slider changes are local until "Re-run backtest"; the button shows a fitting state, then Δ chips appear on the scoreboard.
- Season Monitor: week bar tap swaps the box-score card. No other state.

## State management
- Board: sort key, position filter, selected player (nullable), snapshot freshness.
- Draft: server-pushed state (current pick, taken set, timer), derived best-available + survival, my-turn flag, panic = myTurn && timer ≤ 30.
- Garage: 3 knob values, per-position forge weights, overrides toggle, backtest run status + result deltas, weights version.
- Monitor: selected week only; everything else is payload-derived.

## Design tokens
See `lib/ls_theme.dart` (both themes, tier + source palettes, text styles, spacing, radii). Canonical CSS source: `design_reference/colors_and_type.css`.

## Rules that keep it on-brand
- Purple leads. Forge-orange = ForgeModel/brand spark ONLY (its sliders, its column, panic name, logo) — never for status; warning-amber is a different token.
- Semantic colors always ship as trio (primary / light bg / text fg).
- No gradients except forge-gradient (logo + panic name) and anvil-gradient (logo).
- Borders 1px everywhere; cards flat, shadow only on hover/drawer; radii 4/6/8/12/full.
- Heroicons outline only, 2px stroke, currentColor. No emoji anywhere.
- Numbers are JetBrains Mono, right-aligned in tables. Editorial asides are Source Serif italic — the app's voice: dry, self-aware, one line.

## Assets
- `design_reference/assets/tkforgeworks-mark.svg` — hammer & anvil logomark (works both themes).
- Fonts in `design_reference/fonts/` (subset; full set in the design-system repo, or use google_fonts).
- No photography anywhere in the app.

## Files
- `design_reference/Lazy Sleeper.html` — all four screens, interactive (drawer, draft sim, backtest, week picker).
- `design_reference/Component Library.html` — every component isolated with specs.
- `COMPONENTS.md` — component-by-component Flutter specs.
- `lib/ls_theme.dart` — drop-in token file.
