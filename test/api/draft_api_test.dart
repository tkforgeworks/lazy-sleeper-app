import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/lazy_sleeper_api.dart';

import 'fake_adapter.dart';

void main() {
  group('GET /draft', () {
    test('parses the known-draft list', () async {
      final (:api, adapter: _) = fakeClient(
        (_) => jsonBody([
          {'draft_id': '123', 'running': true, 'season': 2026},
          {'draft_id': '456', 'running': false, 'season': null},
        ]),
      );

      final drafts = await api.drafts();

      expect(drafts.map((d) => d.draftId), ['123', '456']);
      expect(drafts.first.running, isTrue);
      expect(drafts.last.season, isNull);
    });
  });

  group('POST /draft/{id}/start', () {
    test('posts the season and parses DraftStartOut', () async {
      final (:api, :adapter) = fakeClient(
        (_) => jsonBody({
          'draft_id': '123',
          'season': 2026,
          'running': true,
          'started_at': '2026-09-04T23:55:00Z',
          'already_running': false,
          'my_slot': null,
          'picks_made': 0,
          'board_rows': 672,
        }),
      );

      final out = await api.startDraft('123');

      final request = adapter.requests.single;
      expect(request.method, 'POST');
      expect(request.path, '/draft/123/start');
      expect(request.data, {'season': 2026});
      expect(out.running, isTrue);
      expect(out.alreadyRunning, isFalse);
      expect(out.mySlot, isNull);
      expect(out.startedAt?.isUtc, isTrue);
      expect(out.boardRows, 672);
    });
  });

  group('POST /draft/{id}/stop', () {
    test('parses the stop response', () async {
      final (:api, :adapter) = fakeClient(
        (_) => jsonBody({'draft_id': '123', 'running': false}),
      );

      final out = await api.stopDraft('123');

      expect(adapter.requests.single.path, '/draft/123/stop');
      expect(out.running, isFalse);
    });

    test('404 surfaces the FastAPI detail', () async {
      final (:api, adapter: _) = fakeClient(
        (_) => jsonBody({'detail': 'draft 123 is not running'}, status: 404),
      );

      await expectLater(
        api.stopDraft('123'),
        throwsA(
          isA<ApiException>()
              .having((e) => e.statusCode, 'statusCode', 404)
              .having((e) => e.message, 'message', contains('not running')),
        ),
      );
    });
  });
}
