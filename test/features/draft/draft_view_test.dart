import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/fixture_api.dart';
import 'package:lazy_sleeper_app/api/models/draft_state.dart';
import 'package:lazy_sleeper_app/features/draft/draft_view.dart';

import '../../support.dart';

void main() {
  final myTurn = loadDraftState(FixtureLazySleeperApi.draftStateMyTurn);
  final complete = loadDraftState(FixtureLazySleeperApi.draftStateComplete);
  final mid = loadDraftState(FixtureLazySleeperApi.draftStateMid);

  group('pick labels', () {
    test('round.pick from current_pick, never from picks_made', () {
      expect(pickInRound(23, 12), 11);
      expect(pickInRound(12, 12), 12);
      expect(pickInRound(13, 12), 1);
      expect(pickLabel(myTurn.clock, myTurn.spec), '2.11');
      expect(pickLabel(mid.clock, mid.spec), '1.7');
      expect(
        pickSubLabel(myTurn.clock, myTurn.spec),
        'overall 23 · round 2 of 15',
      );
    });

    test('complete draft shows dashes and the count', () {
      expect(pickLabel(complete.clock, complete.spec), dash);
      expect(
        pickSubLabel(complete.clock, complete.spec),
        '180 picks · draft complete',
      );
      expect(onTheClockLabel(complete.clock), 'Draft complete');
    });
  });

  group('on the clock', () {
    test('team name wins, slot is the fallback', () {
      expect(onTheClockLabel(myTurn.clock), 'Tiny T Terrors');
      expect(
        onTheClockLabel(myTurn.clock.copyWith(onTheClockTeamName: null)),
        'Slot 2',
      );
      expect(
        onTheClockLabel(
          myTurn.clock.copyWith(onTheClockTeamName: null, onTheClock: null),
        ),
        'Waiting for the room',
      );
    });
  });

  group('until you', () {
    test('my turn, counts, none left, complete', () {
      expect(untilYou(myTurn.clock), (value: 'YOU', caption: 'ON THE CLOCK'));
      expect(untilYou(mid.clock), (value: '16', caption: 'PICKS UNTIL YOU'));
      expect(untilYou(mid.clock.copyWith(picksUntilMyTurn: 1)), (
        value: '1',
        caption: 'PICK UNTIL YOU',
      ));
      expect(untilYou(mid.clock.copyWith(picksUntilMyTurn: null)), (
        value: dash,
        caption: 'NO PICK LEFT',
      ));
      expect(untilYou(complete.clock), (value: dash, caption: 'ALL DONE'));
    });
  });

  group('roster seats', () {
    test('lineup order, filled before open, bench summarised', () {
      final seats = rosterSeats(myTurn.myRoster!);

      expect(seats.map((s) => s.label), [
        'QB',
        'RB',
        'RB',
        'WR',
        'WR',
        'TE',
        'FLEX',
        'FLEX',
        'K',
        'DEF',
      ]);
      expect(seats[1].player, 'Bijan Robinson');
      expect(seats[2].filled, isFalse);
      expect(benchLabel(myTurn.myRoster!), 'bench 0 of 5');
    });

    test('bench and unknown seats', () {
      final roster = myTurn.myRoster!.copyWith(
        picks: [
          const RosterPick(pickNo: 2, name: 'A', position: 'RB', seat: 'RB'),
          const RosterPick(pickNo: 26, name: 'B', position: 'WR', seat: 'BN'),
          const RosterPick(pickNo: 30, name: 'C', position: 'DL', seat: 'IDP'),
        ],
        openBench: 4,
      );

      final seats = rosterSeats(roster);
      expect(seats.where((s) => s.label == 'BN'), isEmpty);
      expect(seats.last.label, 'IDP');
      expect(seats.last.player, 'C');
      expect(benchLabel(roster), 'bench 1 of 5');
    });
  });

  group('survival', () {
    test('tone thresholds and formatting', () {
      expect(survivalTone(0.70), SurvivalTone.success);
      expect(survivalTone(0.69), SurvivalTone.warning);
      expect(survivalTone(0.45), SurvivalTone.warning);
      expect(survivalTone(0.44), SurvivalTone.error);
      expect(fmtSurvival(0.318), '32%');
      expect(fmtSurvival(null), dash);
    });
  });

  test('injury flag matches the board', () {
    expect(injuryFlag(null), isNull);
    expect(injuryFlag('Questionable'), 'Q');
    expect(injuryFlag('IR'), 'OUT');
  });

  test('row sub line and ticker owner', () {
    expect(rowSub(myTurn.rows.first), 'HOU · WR8 · bye 8');
    expect(nextPickLabel(myTurn.clock), '→ pick ${myTurn.clock.myNextPick}');
    expect(pickOwner(myTurn.recentPicks.first), 'slot 3');
    expect(
      pickOwner(myTurn.recentPicks.first.copyWith(teamName: 'Bots')),
      'Bots',
    );
  });
}
