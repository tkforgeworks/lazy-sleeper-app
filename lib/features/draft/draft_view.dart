// Client-side derivations for the Command Center: labels, seat layout,
// survival tone. Pure functions over the `/state` payload; nothing here
// recomputes a number the backend owns.

import '../../api/models/draft_state.dart';

const dash = '—';

/// Pick within the round for [currentPick] in a [teams]-team draft
/// (snake or linear: the numbering is the same).
int pickInRound(int currentPick, int teams) => (currentPick - 1) % teams + 1;

/// `2.11` for round 2, pick 11. Dash once the draft is complete.
String pickLabel(DraftClock clock, DraftSpec spec) {
  if (clock.complete || clock.round == null) return dash;
  return '${clock.round}.${pickInRound(clock.currentPick, spec.teams)}';
}

/// `overall 23 · round 2 of 15`.
String pickSubLabel(DraftClock clock, DraftSpec spec) {
  if (clock.complete) return '${clock.picksMade} picks · draft complete';
  final round = clock.round == null
      ? ''
      : ' · round ${clock.round} of ${spec.rounds}';
  return 'overall ${clock.currentPick}$round';
}

/// Team name when Sleeper has assigned `draft_order`, else the slot.
String onTheClockLabel(DraftClock clock) {
  if (clock.complete) return 'Draft complete';
  if (clock.onTheClockTeamName case final name?) return name;
  if (clock.onTheClock case final slot?) return 'Slot $slot';
  return 'Waiting for the room';
}

/// The picks-until-you box: big value and its caption.
({String value, String caption}) untilYou(DraftClock clock) {
  if (clock.complete) return (value: dash, caption: 'ALL DONE');
  if (clock.myTurn) return (value: 'YOU', caption: 'ON THE CLOCK');
  return switch (clock.picksUntilMyTurn) {
    null => (value: dash, caption: 'NO PICK LEFT'),
    1 => (value: '1', caption: 'PICK UNTIL YOU'),
    final n => (value: '$n', caption: 'PICKS UNTIL YOU'),
  };
}

/// One chip in the roster strip.
class RosterSeat {
  const RosterSeat(this.label, {this.player});

  /// `QB`, `RB`, `FLEX`, …
  final String label;

  /// Null when the seat is open.
  final String? player;

  bool get filled => player != null;
}

const _seatOrder = ['QB', 'RB', 'WR', 'TE', 'FLEX', 'K', 'DEF'];

/// Starters and flex seats in lineup order, filled seats first within a
/// position, from `my_roster`. Bench is summarised by [benchLabel].
List<RosterSeat> rosterSeats(DraftRoster roster) {
  final bySeat = <String, List<RosterPick>>{};
  for (final p in roster.picks) {
    bySeat.putIfAbsent(p.seat ?? p.position ?? '?', () => []).add(p);
  }
  final open = {...roster.openStarters, 'FLEX': roster.openFlex};
  final labels = [
    ..._seatOrder.where((s) => bySeat.containsKey(s) || (open[s] ?? 0) > 0),
    ...bySeat.keys.where((s) => s != 'BN' && !_seatOrder.contains(s)),
  ];
  return [
    for (final label in labels) ...[
      for (final p in bySeat[label] ?? const <RosterPick>[])
        RosterSeat(label, player: p.name ?? dash),
      for (var i = 0; i < (open[label] ?? 0); i++) RosterSeat(label),
    ],
  ];
}

/// `bench 1 of 6`.
String benchLabel(DraftRoster roster) {
  final onBench = roster.picks.where((p) => p.seat == 'BN').length;
  return 'bench $onBench of ${onBench + roster.openBench}';
}

enum SurvivalTone { success, warning, error }

/// Success ≥ 70 %, warning 45–69 %, error below.
SurvivalTone survivalTone(double survival) => survival >= 0.70
    ? SurvivalTone.success
    : survival >= 0.45
    ? SurvivalTone.warning
    : SurvivalTone.error;

String fmtSurvival(double? survival) =>
    survival == null ? dash : '${(survival * 100).round()}%';

String fmtPts(double v) => v.round().toString();

/// `HOU · WR8 · bye 8`.
String rowSub(DraftRow r) => [
  r.team ?? 'FA',
  '${r.position}${r.posRank}',
  if (r.bye case final bye?) 'bye $bye',
].join(' · ');

/// `→ pick 26` for the survival column header; dash when there is none.
String nextPickLabel(DraftClock clock) =>
    clock.myNextPick == null ? dash : '→ pick ${clock.myNextPick}';

/// Ticker line owner: the team name, else the slot.
String pickOwner(RecentPick p) =>
    p.teamName ?? (p.slot == null ? dash : 'slot ${p.slot}');

/// Same reading as the board: Q for questionable, OUT for anything else
/// Sleeper reports; null when healthy.
String? injuryFlag(String? status) => switch (status) {
  null => null,
  'Questionable' => 'Q',
  _ => 'OUT',
};

/// The backend's best pick: rows arrive in `pick_score` order.
DraftRow? recommended(DraftState s) => s.rows.isEmpty ? null : s.rows.first;

/// Up to two fallbacks for "if he's gone".
List<DraftRow> alternates(DraftState s) =>
    s.rows.length > 1 ? s.rows.sublist(1, s.rows.length.clamp(1, 3)) : const [];

/// Exactly one line of reasoning, composed from the row's signals — the
/// numbers are the backend's, only the sentence is ours.
String whyLine(DraftRow r) {
  final parts = <String>[
    if (r.tier case final t?) 'T$t ${r.position}' else r.position,
    '${fmtPts(r.vorp)} VORP',
    if (r.survival case final s?)
      '${(s * 100).round()}% to survive to your next pick',
  ];
  final tail = <String>[
    if (r.cliff) 'Last of the tier.',
    if (r.run) '${r.position} run on.',
    if (r.adpFlag == 'value' && r.adpDelta != null)
      'Falling: ADP ${fmtAdp(r.adp)}.',
  ];
  return '${parts.join(', ')}.${tail.isEmpty ? '' : ' ${tail.join(' ')}'}';
}

String fmtAdp(double? v) => v == null ? dash : v.toStringAsFixed(1);

enum AlertSeverity { warning, info, success, error }

/// One card in the rail (chip on mobile).
class DraftAlert {
  const DraftAlert({
    required this.severity,
    required this.title,
    required this.body,
  });

  final AlertSeverity severity;
  final String title;
  final String body;
}

/// How far down the table alerts look; deeper rows are not decisions.
const alertDepth = 12;

/// Alerts from the backend's signals on the top rows, in a fixed order:
/// tier cliff (warning), positional run (info), value faller (success),
/// injury watch (error). At most one of each.
List<DraftAlert> alertsFor(DraftState s) {
  final top = s.rows.take(alertDepth).toList();
  final alerts = <DraftAlert>[];

  final cliff = top.where((r) => r.cliff).firstOrNull;
  if (cliff != null) {
    final gap = cliff.gapToNext == null
        ? ''
        : ' ${fmtPts(cliff.gapToNext!)} pts to the next ${cliff.position}.';
    alerts.add(
      DraftAlert(
        severity: AlertSeverity.warning,
        title: 'Tier cliff at ${cliff.position}',
        body:
            '${cliff.name} is the last T${cliff.tier ?? '?'} '
            '${cliff.position} on the board.$gap',
      ),
    );
  }

  final run = top.where((r) => r.run).firstOrNull;
  if (run != null) {
    alerts.add(
      DraftAlert(
        severity: AlertSeverity.info,
        title: '${run.position} run',
        body:
            '${run.runCount} ${run.position}s went in the last few picks. '
            '${run.name} is the best one left.',
      ),
    );
  }

  final fallers = top.where(
    (r) => r.adpFlag == 'value' && r.adpDelta != null && r.adp != null,
  );
  if (fallers.isNotEmpty) {
    final f = fallers.reduce((a, b) => a.adpDelta! >= b.adpDelta! ? a : b);
    alerts.add(
      DraftAlert(
        severity: AlertSeverity.success,
        title: '${f.name} is falling',
        body:
            'ADP ${fmtAdp(f.adp)}, still here at pick ${s.clock.currentPick} '
            '(+${fmtAdp(f.adpDelta)}).',
      ),
    );
  }

  final hurt = top.where((r) => r.injuryStatus != null).firstOrNull;
  if (hurt != null) {
    alerts.add(
      DraftAlert(
        severity: AlertSeverity.error,
        title: 'Injury watch',
        body:
            '${hurt.name} is ${hurt.injuryStatus!.toLowerCase()} and ranked '
            '#${hurt.rank}. Price the risk in.',
      ),
    );
  }
  return alerts;
}
