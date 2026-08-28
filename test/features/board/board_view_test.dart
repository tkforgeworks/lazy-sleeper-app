import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/models/board.dart';
import 'package:lazy_sleeper_app/features/board/board_view.dart';

BoardRow row({
  required int rank,
  String position = 'RB',
  double points = 100,
  int? tier,
  double? adp,
  double? sleeper,
  double? espn,
  String? injury,
  double? spread,
  bool disagree = false,
  int? bye,
}) => BoardRow(
  rank: rank,
  sleeperId: '$rank',
  name: 'Player $rank',
  position: position,
  team: 'DET',
  injuryStatus: injury,
  bye: bye,
  points: points,
  baseline: 50,
  vorp: points - 50,
  posRank: rank,
  tier: tier,
  cliff: false,
  adp: adp,
  adpDelta: null,
  spread: spread,
  disagree: disagree,
  components: {'sleeper': ?sleeper, 'espn': ?espn},
);

void main() {
  group('filterRows', () {
    test('keeps only the position and leaves rank alone', () {
      final rows = [
        row(rank: 1, position: 'RB'),
        row(rank: 2, position: 'QB'),
        row(rank: 3, position: 'QB'),
      ];

      final qb = filterRows(rows, 'QB');

      expect(qb.map((r) => r.rank), [2, 3]);
      expect(filterRows(rows, null), rows);
    });
  });

  group('bye week', () {
    test('formats as a number, dash when the schedule has none', () {
      expect(fmtBye(6), '6');
      expect(fmtBye(null), dash);
    });

    test('rowSub carries the bye only where asked, and never when null', () {
      expect(rowSub(row(rank: 1, bye: 6)), 'DET · RB1');
      expect(rowSub(row(rank: 1, bye: 6), withBye: true), 'DET · RB1 · bye 6');
      expect(rowSub(row(rank: 1), withBye: true), 'DET · RB1');
    });
  });

  group('sortRows', () {
    final rows = [
      row(rank: 1, sleeper: 300, espn: 250, adp: 3.0),
      row(rank: 2, sleeper: 280, espn: 290, adp: 1.5),
      row(rank: 3, sleeper: null, espn: 260, adp: null),
    ];

    test('ensemble and forge keep board order', () {
      expect(sortRows(rows, BoardSort.ensemble), rows);
      expect(sortRows(rows, BoardSort.forge), rows);
    });

    test('source sorts rank by that source, missing values last', () {
      expect(sortRows(rows, BoardSort.sleeper).map((r) => r.rank), [1, 2, 3]);
      expect(sortRows(rows, BoardSort.espn).map((r) => r.rank), [2, 3, 1]);
    });

    test('adp sorts ascending with null last', () {
      expect(sortRows(rows, BoardSort.adp).map((r) => r.rank), [2, 1, 3]);
    });
  });

  group('withTierBreaks', () {
    test('opens a break where the tier changes, up to tier 5', () {
      final rows = [
        row(rank: 1, tier: 1, points: 300),
        row(rank: 2, tier: 1, points: 290),
        row(rank: 3, tier: 2, points: 270),
        row(rank: 4, tier: 5, points: 200),
        row(rank: 5, tier: 6, points: 150),
        row(rank: 6, tier: null, points: 100),
      ];

      final lines = withTierBreaks(rows);

      final breaks = lines.whereType<TierBreakLine>().toList();
      expect(breaks.map((b) => b.tier), [1, 2, 5]);
      expect(breaks.first.note, 'the ones you brag about');
      expect(breaks[1].note, '−20 pts off the last tier');
      expect(lines.whereType<PlayerLine>().length, rows.length);
      expect(lines.first, isA<TierBreakLine>());
    });

    test('untiered rows never open a break', () {
      final lines = withTierBreaks([row(rank: 1), row(rank: 2)]);

      expect(lines.whereType<TierBreakLine>(), isEmpty);
    });
  });

  group('formatting', () {
    test('points are whole numbers, adp one decimal, deltas signed', () {
      expect(fmtPts(347.3), '347');
      expect(fmtPts(null), '—');
      expect(fmtAdp(1.25), '1.3');
      expect(fmtDelta(0.3), '+0.3');
      expect(fmtDelta(-12.0), '−12.0');
      expect(fmtDelta(null), '—');
    });

    test('flags derive from injury status and spread', () {
      expect(injuryLabel(row(rank: 1)), isNull);
      expect(injuryLabel(row(rank: 1, injury: 'Questionable')), 'Q');
      expect(injuryLabel(row(rank: 1, injury: 'IR')), 'OUT');
      expect(splitLabel(row(rank: 1, spread: 23.6)), '±24');
    });
  });
}
