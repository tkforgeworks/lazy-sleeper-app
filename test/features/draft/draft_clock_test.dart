import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/fixture_api.dart';
import 'package:lazy_sleeper_app/features/draft/draft_clock.dart';
import 'package:lazy_sleeper_app/features/draft/draft_view.dart';

import '../../support.dart';

void main() {
  final myTurn = loadDraftState(FixtureLazySleeperApi.draftStateMyTurn);
  final clock = myTurn.clock;
  final deadline = clock.pickDeadline!;

  test('seconds remaining counts down from the deadline, floors at 0', () {
    expect(
      secondsRemaining(clock, deadline.subtract(const Duration(seconds: 90))),
      90,
    );
    expect(
      secondsRemaining(
        clock,
        deadline.subtract(const Duration(milliseconds: 1500)),
      ),
      2,
      reason: 'partial seconds round up so the display never skips 0 early',
    );
    expect(secondsRemaining(clock, deadline), 0);
    expect(
      secondsRemaining(clock, deadline.add(const Duration(minutes: 5))),
      0,
    );
  });

  test('local time is compared in UTC', () {
    final local = deadline.subtract(const Duration(seconds: 30)).toLocal();
    expect(secondsRemaining(clock, local), 30);
  });

  test('no deadline or a complete draft means no countdown', () {
    expect(
      secondsRemaining(clock.copyWith(pickDeadline: null), deadline),
      null,
    );
    expect(secondsRemaining(clock.copyWith(complete: true), deadline), null);
  });

  test('tone thresholds: calm > 20, warning ≤ 20, error ≤ 10', () {
    expect(timerTone(21), TimerTone.calm);
    expect(timerTone(20), TimerTone.warning);
    expect(timerTone(11), TimerTone.warning);
    expect(timerTone(10), TimerTone.error);
    expect(timerTone(0), TimerTone.error);
  });

  test('progress fraction against the pick timer', () {
    expect(timerFraction(clock, 150), 0.5);
    expect(timerFraction(clock, 400), 1.0);
    expect(timerFraction(clock, null), isNull);
    expect(timerFraction(clock.copyWith(pickTimerS: null), 10), isNull);
  });

  test('panic: my turn and 30 s or less, never without a countdown', () {
    expect(isPanic(clock, 30), isTrue);
    expect(isPanic(clock, 31), isFalse);
    expect(isPanic(clock, null), isFalse);
    expect(isPanic(clock.copyWith(myTurn: false), 5), isFalse);
  });

  group('recommendation and alerts', () {
    test('the first row is the pick; the next two are the fallbacks', () {
      expect(recommended(myTurn)!.name, 'Nico Collins');
      expect(alternates(myTurn).map((r) => r.name), [
        'Rashee Rice',
        'Chris Olave',
      ]);
      expect(recommended(myTurn.copyWith(rows: [])), isNull);
      expect(alternates(myTurn.copyWith(rows: [myTurn.rows.first])), isEmpty);
    });

    test('why line is one sentence from the row signals', () {
      expect(
        whyLine(myTurn.rows.first),
        'T6 WR, 84 VORP, 32% to survive to your next pick.',
      );
      final loaded = myTurn.rows.first.copyWith(
        cliff: true,
        run: true,
        adpFlag: 'value',
        adp: 25.4,
        adpDelta: 7.4,
      );
      expect(
        whyLine(loaded),
        endsWith('Last of the tier. WR run on. Falling: ADP 25.4.'),
      );
    });

    test('alerts come from the top rows in a fixed order, one each', () {
      final alerts = alertsFor(myTurn);

      expect(alerts.map((a) => a.severity), [
        AlertSeverity.warning,
        AlertSeverity.success,
        AlertSeverity.error,
      ]);
      expect(alerts[0].title, 'Tier cliff at TE');
      expect(alerts[0].body, contains('Trey McBride is the last T2 TE'));
      expect(alerts[1].title, endsWith('is falling'));
      expect(alerts[1].body, contains('still here at pick 23'));
      expect(alerts[2].title, 'Injury watch');
      expect(alerts[2].body, contains('Malik Nabers is questionable'));
    });

    test('a run adds an info alert; an empty board has none', () {
      final rows = [...myTurn.rows];
      rows[3] = rows[3].copyWith(run: true, runCount: 4);
      final alerts = alertsFor(myTurn.copyWith(rows: rows));

      expect(alerts[1].severity, AlertSeverity.info);
      expect(alerts[1].title, 'WR run');
      expect(alerts[1].body, startsWith('4 WRs went in the last few picks.'));
      expect(alertsFor(myTurn.copyWith(rows: [])), isEmpty);
    });
  });
}
