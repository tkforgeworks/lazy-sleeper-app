import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/lazy_sleeper_api.dart';

/// Answers every request with a canned [ResponseBody] and records what it saw.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter(this._respond);

  final ResponseBody Function(RequestOptions) _respond;
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return _respond(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(Object body, {int status = 200}) => ResponseBody.fromString(
  jsonEncode(body),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

({HttpLazySleeperApi api, _FakeAdapter adapter}) _client(
  ResponseBody Function(RequestOptions) respond,
) {
  final adapter = _FakeAdapter(respond);
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local'))
    ..httpClientAdapter = adapter;
  return (api: HttpLazySleeperApi(dio), adapter: adapter);
}

void main() {
  // Captured from a live backend (v0.1.0, 2026-08-27), trimmed to rows that
  // cover every nullable field and flag value.
  final fixture = jsonDecode(
    File('assets/fixtures/board.json').readAsStringSync(),
  ) as Map<String, dynamic>;

  group('GET /board', () {
    test('parses the captured board response', () async {
      final (:api, adapter: _) = _client((_) => _json(fixture));

      final board = await api.board();

      expect(board.board.season, 2026);
      expect(board.board.provider, 'ensemble');
      expect(board.board.rowCount, 672);
      expect(board.board.generatedAt.isUtc, isTrue);
      expect(board.board.config['cliff_gap'], 15.0);
      expect(board.rows, hasLength((fixture['rows'] as List).length));

      final first = board.rows.first;
      expect(first.rank, 1);
      expect(first.name, 'Jahmyr Gibbs');
      expect(first.position, 'RB');
      expect(first.team, 'DET');
      expect(first.tier, 1);
      expect(first.injuryStatus, isNull);
      expect(first.components, containsPair('sleeper', closeTo(331.4, 0.01)));
      expect(first.components, contains('espn'));
    });

    test('tolerates every nullable field the backend leaves empty', () async {
      final (:api, adapter: _) = _client((_) => _json(fixture));

      final rows = (await api.board()).rows;

      expect(rows.any((r) => r.team == null), isTrue, reason: 'team');
      expect(rows.any((r) => r.tier == null), isTrue, reason: 'tier');
      expect(rows.any((r) => r.spread == null), isTrue, reason: 'spread');
      expect(rows.any((r) => r.gapToNext == null), isTrue, reason: 'gapToNext');
      expect(rows.any((r) => r.adpFlag == null), isTrue, reason: 'adpFlag');
      expect(
        rows.map((r) => r.adpFlag).toSet(),
        containsAll(['value', 'reach']),
      );
      expect(rows.map((r) => r.injuryStatus).toSet(), contains('Questionable'));
      expect(rows.any((r) => r.cliff), isTrue, reason: 'cliff');
      expect(rows.any((r) => r.disagree), isTrue, reason: 'disagree');
    });

    test('forwards only the filters that were given', () async {
      final (:api, :adapter) = _client((_) => _json(fixture));

      await api.board(position: 'RB', limit: 10);

      final request = adapter.requests.single;
      expect(request.path, '/board');
      expect(request.queryParameters, {'position': 'RB', 'limit': 10});
    });

    test('non-2xx becomes an ApiException carrying the status', () async {
      final (:api, adapter: _) = _client(
        (_) => _json({'detail': 'no board yet'}, status: 404),
      );

      await expectLater(
        api.board(),
        throwsA(
          isA<ApiException>().having((e) => e.statusCode, 'statusCode', 404),
        ),
      );
    });

    test(
      'an unreachable server becomes an ApiException without a status',
      () async {
        final (:api, adapter: _) = _client(
          (options) => throw DioException.connectionError(
            requestOptions: options,
            reason: 'refused',
          ),
        );

        await expectLater(
          api.board(),
          throwsA(
            isA<ApiException>().having(
              (e) => e.statusCode,
              'statusCode',
              isNull,
            ),
          ),
        );
      },
    );

    test('a body the models cannot read becomes an ApiException', () async {
      final (:api, adapter: _) = _client(
        (_) => _json({'board': {}, 'rows': []}),
      );

      await expectLater(
        api.board(),
        throwsA(
          isA<ApiException>().having((e) => e.statusCode, 'statusCode', 200),
        ),
      );
    });
  });
}
