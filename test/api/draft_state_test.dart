import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/fixture_api.dart';
import 'package:lazy_sleeper_app/api/lazy_sleeper_api.dart';

import '../support.dart';
import 'fake_adapter.dart';

void main() {
  group('DraftState fixtures parse', () {
    test('my turn: clock, roster, recent picks, rows', () {
      final s = loadDraftState(FixtureLazySleeperApi.draftStateMyTurn);

      expect(s.spec.teams, 12);
      expect(s.spec.totalPicks, 180);
      expect(s.clock.myTurn, isTrue);
      expect(s.clock.picksUntilMyTurn, 0);
      expect(s.clock.currentPick, 23);
      expect(s.clock.round, 2);
      expect(s.clock.onTheClock, 2);
      expect(s.clock.onTheClockTeamName, 'Tiny T Terrors');
      expect(s.clock.pickTimerS, 300);
      expect(
        s.clock.pickDeadline,
        DateTime.utc(2026, 8, 28, 17, 54, 31, 356, 213),
      );
      expect(s.clock.pickDeadline!.isUtc, isTrue);
      expect(s.myRoster!.slot, 2);
      expect(s.myRoster!.picks.single.name, 'Bijan Robinson');
      expect(s.myRoster!.picks.single.seat, 'RB');
      expect(s.myRoster!.openStarters['WR'], 2);
      expect(s.myRoster!.needs['WR'], closeTo(2.833, 0.001));
      expect(s.recentPicks, hasLength(8));
      expect(s.recentPicks.first.pickNo, 22);
      expect(s.recentPicks.first.name, 'Brock Bowers');
      expect(s.rows, hasLength(40));
      expect(s.rows.first.name, 'Nico Collins');
      expect(s.rows.first.survival, closeTo(0.318, 0.001));
      expect(s.rows.first.pickScore, 103.26);
      expect(s.recompute.seq, 76);
      expect(s.recompute.stale, isFalse);
      expect(s.poller.status, 'drafting');
      expect(s.board.available, 650);
    });

    test('complete: clock fields go null, poller summary is kept raw', () {
      final s = loadDraftState(FixtureLazySleeperApi.draftStateComplete);

      expect(s.clock.complete, isTrue);
      expect(s.clock.onTheClock, isNull);
      expect(s.clock.round, isNull);
      expect(s.clock.pickDeadline, isNull);
      expect(s.clock.picksMade, 180);
      expect(s.poller.summary?['complete'], true);
    });

    test('pre-draft: no deadline yet, my slot known', () {
      final s = loadDraftState(FixtureLazySleeperApi.draftStatePre);

      expect(s.poller.status, 'pre_draft');
      expect(s.clock.pickDeadline, isNull);
      expect(s.clock.currentPick, 1);
      expect(s.clock.mySlot, 2);
      expect(s.recentPicks, isEmpty);
    });

    test('mid-draft: picks can arrive out of order', () {
      final s = loadDraftState(FixtureLazySleeperApi.draftStateMid);

      expect(s.clock.picksMade, 3);
      expect(s.clock.currentPick, 7, reason: 'never derive from picks_made');
      expect(s.recentPicks.map((p) => p.pickNo), [6, 4, 1]);
      expect(s.clock.pickDeadline, isNotNull);
    });
  });

  group('HttpLazySleeperApi.draftState', () {
    test('GETs /draft/{id}/state with the filters it was given', () async {
      final body = loadDraftState().toJson();
      final (:api, :adapter) = fakeClient((_) => jsonBody(body));

      final s = await api.draftState('42', position: 'WR', limit: 40);

      final req = adapter.requests.single;
      expect(req.method, 'GET');
      expect(req.path, '/draft/42/state');
      expect(req.queryParameters, {'position': 'WR', 'limit': 40});
      expect(s.draftId, body['draft_id']);
    });

    test('404 surfaces as an ApiException with the status', () async {
      final (:api, :adapter) = fakeClient(
        (_) => jsonBody({'detail': 'draft 42 is not running'}, status: 404),
      );

      await expectLater(
        api.draftState('42'),
        throwsA(
          isA<ApiException>()
              .having((e) => e.statusCode, 'status', 404)
              .having((e) => e.message, 'message', contains('not running')),
        ),
      );
    });

    test(
      'start gets the long receive timeout; state keeps the default',
      () async {
        final (:api, :adapter) = fakeClient(
          (o) => o.path.endsWith('/start')
              ? jsonBody({
                  'draft_id': '42',
                  'season': 2026,
                  'running': true,
                  'already_running': false,
                  'picks_made': 0,
                  'board_rows': 1,
                })
              : jsonBody(loadDraftState().toJson()),
        );

        await api.startDraft('42');
        await api.draftState('42');

        expect(adapter.requests[0].receiveTimeout, startDraftTimeout);
        expect(
          adapter.requests[1].receiveTimeout,
          isNot(startDraftTimeout),
          reason: 'per-request override must not leak',
        );
      },
    );
  });

  group('FixtureLazySleeperApi.draftState', () {
    test('404s until the runner is started, then serves the capture', () async {
      final api = FixtureLazySleeperApi(bundle: RepoBundle());

      await expectLater(
        api.draftState('9'),
        throwsA(isA<ApiException>().having((e) => e.statusCode, 's', 404)),
      );

      await api.startDraft('9');
      final s = await api.draftState('9', position: 'RB', limit: 3);

      expect(s.draftId, '9');
      expect(s.rows, hasLength(3));
      expect(s.rows.every((r) => r.position == 'RB'), isTrue);
      expect(s.rows.first.rank, isNot(1), reason: 'rank stays overall');
    });
  });
}
