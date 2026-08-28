# Lazy Sleeper — component specs (Flutter)

Dark values listed; light equivalents in ls_theme.dart. "JBM" = JetBrains Mono, "Pop" = Poppins, "SS4" = Source Serif 4. All radii/paddings in dp. Rendered reference: design_reference/Component Library.html.

## Atoms

### PosChip
Container: bg purpleTint, r4, pad 1×6. Text: JBM 500/10, purplePrimary. One style for all positions.

### TierBadge
Container: transparent, 1px border tierColor, r4, pad 1×5. Text JBM 600/10 tierColor.
Tier palette (both themes): T1 #C495F4 · T2 #38BDF8 · T3 #4ADE80 · T4 #FBBF24 · T5 #F87171.

### StatusFlag
Container: semantic light bg, r4, pad 1×6–7. Text JBM 500–600/9.5 semantic text color.
Variants: SPLIT ±n (warning, shown when source spread ≥ 24 pts) · Q / OUT (error) · RUN (info). Never forge colors.

### DeltaText
JBM 500–600/11–12. success when favorable, error when unfavorable, textSecondary when |Δ| ≤ 1. The widget takes `goodIsPositive` — ADP delta: + good; MAE delta: ▼ good.

### FilterChip
Capsule (r-full), pad 4×10, JBM 600/11. Active: purpleTint bg + 1px purplePrimary border + purplePrimary text. Inactive: 1px border token, textSecondary. → ChoiceChip.

### SegmentedTabs
Shared 1px border r6; cells Pop 500/11.5–12.5 pad 5×12; active cell purpleTint bg + purplePrimary text. → SegmentedButton with custom style.

### Buttons
Primary: purplePrimary fill, ink #141327 (dark theme) / #FFFFFF (light), Pop 600/13–16, pad 11×22, r8; hover/press → purpleDark. Secondary: purpleTint fill + 1px purplePrimary border, purplePrimary text, pad 6×14, r8. No gradients, no elevation.

### Toggle
Track 30×16 r-full (on purplePrimary / off rgba #334155 .8), knob 12 white, 200ms.

### ForgeSlider
Material Slider, active track + thumb forgeOrange #F9A03F, inactive rgba(#334155,.5). Forge accent = ForgeModel controls only; a generic slider elsewhere is purple.

### LiveDot
7 dp circle successPrimary + JBM 400/11 textSecondary caption. Stale source: warningPrimary; dead: errorPrimary (Data Health reuses this).

## Molecules

### StatCard
backgroundLight, 1px purpleTint border, r8, pad 10×14, flat. Label JBM 600/9 +8% tracking secondary → value JBM 700/21 purple → sub JBM 400/10.5 secondary. Mobile 2×2 grid: value 17.

### AlertCard
Semantic light bg + 1px semantic primary border + semantic text fg, r8, pad 9×12. Title Pop 600/11, body SS4 400/11.5 lh1.45. Severities: warning=tier cliff, info=run, success=value faller, error=injury. Mobile: capsule chip (title only) in horizontal rail.

### SourceProjectionBar
Row: label 78 / track flex / value 44. Track 10 r3 rgba(#334155,.5); fill = source color, widthFactor = value ÷ max. Source palette: Sleeper #A05CF7 · ESPN #38BDF8 · ForgeModel #F9A03F · Ensemble #C495F4.

### Sparkline (CustomPaint)
Polyline 1.6–1.8 stroke, no dots/fill/axes/labels. Purple default, info for snap%, success/warning for ADP trend direction.

### RangeBand (CustomPaint)
Track 12 r-full rgba(#334155,.5); band purpleTint from floor→ceiling fractions; median tick 2×16 purplePrimary. Caption row above: JBM 400/9.5 "floor x · median y · ceiling z".

### SurvivalBar
Track 5 r-full; fill + % label colored: success ≥ 70, warning 45–69, error < 45. Label JBM 500/10.5 right, 32 wide.

### AvailabilityCell
30×22 (desktop) / flex×14 (mobile), r4, JBM 500/9 centered. played: successLight bg + pts in successText · played-Q: warningLight + pts · out: errorLight + "O" · bye: rgba(#334155,.45) + "B" · upcoming: 1px rgba(#334155,.4) outline only ("Q" if flagged).

### WeekBarColumn
Column pad 6,6,8, r6, tap target. Bars: projected purpleTint + actual purplePrimary, 3 gap, r3 top, height = pts/140 of 112 (desktop) / 72 (mobile). Footer: week JBM 500/10 + W/L pill (semantic light/text, r4 pad 1×5) + score JBM 600/10.5. Selected: bg rgba(196,149,244,.12).

### RosterSlotChip
minW 64, pad 4×8, r6. Empty: 1px dashed border, "—" secondary. Filled: 1px solid purplePrimary + purpleTint bg, name Pop 500/10.5 textPrimary. Slot label JBM 600/8.5 +6%.

### RecommendationCard
r8, backgroundLight, pad 12–14×16–18. States: idle (purpleTint border, no CTA) · live (forgePrimary border, eyebrow forgePrimary, "Draft him" primary CTA) · done (success pill). Eyebrow JBM 600/9.5 +10% · name Pop 700/26 (21 mobile) purple · why SS4 italic 12.5/1.5 — exactly one line of reasoning · alternates as purpleTint chips (Pop 500/12, r6, pad 4×10).

### TimerBlock
JBM 700/32 (22 mobile); color: textPrimary > 20s → warningPrimary ≤ 20 → errorPrimary ≤ 10. Progress 220×3 r-full under, fill = remaining fraction, same color.

### PanicOverlay
Full-screen rgba(11,16,29,.97). Eyebrow JBM 600/13 +24% errorPrimary → name Pop 800/64 (38 mobile) with forge-gradient shader (ShaderMask, linear 100°: #FBDF19 → #F68F25 52% → #EE3423) → context SS4 400/15 secondary → primary CTA → alternates JBM 400/11. Trigger: myTurn && timer ≤ 30.

### BoardRow / TierBreak
Row 29 px: grid 40/flex/46/42/60/60/62/68/58/46/56/56/148, pad 4×18, divider rgba(#334155,.35), hover rgba(196,149,244,.07), full row tappable. Name Pop 500/12.5 + sub JBM 400/10 secondary; numerics JBM 400/12 right (ENS + VORP 600; FORGE col forgePrimary; VORP purple). TierBreak: JBM 600/10 +10% tier color + 1 px rule + gap note right.

### WeightStackBar
Track 14 r4 rgba(#334155,.5); segments Sleeper/ESPN/Forge in source colors; split text JBM 400/9.5 right. Disabled (overrides off): 45% opacity.

### TopNav / MobileTabBar
Desktop: 45 header, 1px bottom border, mark 22, name Pop 700/15 purple, nav pills Pop 500/12.5 (active purpleTint bg r6 pad 5×11), right meta JBM 400/11 + LiveDot.
Mobile: bottom bar, Heroicons outline 21/2px stroke, active purplePrimary, labels Pop 500/9, pad 8,10,16. Tabs: Board · Draft · Garage/Team · Health.

### Drawer / BottomSheet (Player Detail)
Desktop: 404 w, right overlay below nav, backgroundLight, 1px left border, shadow (-16,0,32 rgba(0,0,0,.4)), pad 18×22, gap 16.
Mobile: 62% height sheet, r22 top, drag handle 38×4 border-token, scrim rgba(11,17,32,.55), pad 14×20.

## Screen-only compositions
MAE scoreboard, best-available table, pick ticker, starters matrix — see README screen specs; they compose the atoms above.
