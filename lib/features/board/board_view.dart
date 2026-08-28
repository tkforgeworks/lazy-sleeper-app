// Client-side board presentation logic: sort, position filter, tier breaks,
// number formatting. The handoff assigns exactly these to the client; every
// number still comes from the backend untouched.

import '../../api/models/board.dart';

/// "RANK BY" tabs. [ensemble] is the board's own order; the source sorts
/// re-rank by that provider's points; [adp] is ascending draft position.
/// [forge] is a stub until ForgeModel ships: it keeps ensemble order.
enum BoardSort {
  ensemble('Ensemble'),
  sleeper('Sleeper'),
  espn('ESPN'),
  forge('ForgeModel'),
  adp('ADP');

  const BoardSort(this.label);

  final String label;

  /// Key into `BoardRow.components`, when the sort is a projection source.
  String? get component => switch (this) {
    sleeper => 'sleeper',
    espn => 'espn',
    _ => null,
  };
}

const boardPositions = ['QB', 'RB', 'WR', 'TE', 'K', 'DEF'];

/// Tier breaks are drawn only for the tiers the design's five-colour scale
/// distinguishes; deeper tiers all wear the T5 colour and flow together.
const maxTierBreak = 5;

List<BoardRow> filterRows(List<BoardRow> rows, String? position) =>
    position == null
    ? rows
    : rows.where((r) => r.position == position).toList();

List<BoardRow> sortRows(List<BoardRow> rows, BoardSort sort) {
  switch (sort) {
    case BoardSort.ensemble:
    case BoardSort.forge:
      return rows;
    case BoardSort.sleeper:
    case BoardSort.espn:
      final key = sort.component!;
      return _sortedBy(rows, (r) => r.components[key], descending: true);
    case BoardSort.adp:
      return _sortedBy(rows, (r) => r.adp, descending: false);
  }
}

/// Stable sort with nulls last, ties broken by board rank.
List<BoardRow> _sortedBy(
  List<BoardRow> rows,
  double? Function(BoardRow) key, {
  required bool descending,
}) {
  final sorted = [...rows];
  sorted.sort((a, b) {
    final ka = key(a), kb = key(b);
    if (ka == null && kb == null) return a.rank.compareTo(b.rank);
    if (ka == null) return 1;
    if (kb == null) return -1;
    final c = descending ? kb.compareTo(ka) : ka.compareTo(kb);
    return c != 0 ? c : a.rank.compareTo(b.rank);
  });
  return sorted;
}

/// One line of the desktop table: a player row or a tier-break rule.
sealed class BoardLine {
  const BoardLine();
}

class PlayerLine extends BoardLine {
  const PlayerLine(this.row);

  final BoardRow row;
}

class TierBreakLine extends BoardLine {
  const TierBreakLine({required this.tier, required this.note});

  final int tier;

  /// Right-aligned gap note, e.g. "−12 pts off the last tier".
  final String note;
}

/// Interleaves tier-break lines where the tier changes, for tiers up to
/// [maxTierBreak]. Untiered rows (tier null) never open a break.
List<BoardLine> withTierBreaks(List<BoardRow> rows) {
  final lines = <BoardLine>[];
  int? lastTier;
  for (var i = 0; i < rows.length; i++) {
    final row = rows[i];
    final tier = row.tier;
    if (tier != null && tier <= maxTierBreak && tier != lastTier) {
      final note = i == 0
          ? 'the ones you brag about'
          : '−${(rows[i - 1].points - row.points).round()} pts off the last tier';
      lines.add(TierBreakLine(tier: tier, note: note));
      lastTier = tier;
    }
    lines.add(PlayerLine(row));
  }
  return lines;
}

// ---- formatting -----------------------------------------------------------

const dash = '—';

/// Season points and VORP: whole numbers.
String fmtPts(double? v) => v == null ? dash : v.round().toString();

String fmtAdp(double? v) => v == null ? dash : v.toStringAsFixed(1);

/// Signed, one decimal: "+3.2", "−1.0".
String fmtDelta(double? v) {
  if (v == null) return dash;
  final s = v.abs().toStringAsFixed(1);
  return v < 0 ? '−$s' : '+$s';
}

/// "DET · RB1"; free agents show FA.
String rowSub(BoardRow r) => '${r.team ?? 'FA'} · ${r.position}${r.posRank}';

/// SPLIT flag text: "±24" from the ensemble spread.
String splitLabel(BoardRow r) => '±${(r.spread ?? 0).round()}';

/// Q for questionable; anything else Sleeper reports is OUT for our purposes.
String? injuryLabel(BoardRow r) => switch (r.injuryStatus) {
  null => null,
  'Questionable' => 'Q',
  _ => 'OUT',
};
