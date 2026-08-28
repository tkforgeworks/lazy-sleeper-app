import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/logging_interceptor.dart';
import 'package:lazy_sleeper_app/app/log/app_log.dart';
import 'package:logging/logging.dart';

import 'fake_adapter.dart';

void main() {
  late AppLog log;

  Dio client(ResponseBody Function(RequestOptions) respond) =>
      Dio(BaseOptions(baseUrl: 'http://test.local'))
        ..httpClientAdapter = FakeAdapter(respond)
        ..interceptors.add(LoggingInterceptor());

  setUp(() {
    log = AppLog(initialLevel: Level.INFO, echo: false)
      ..install(captureFlutterErrors: false);
    addTearDown(log.uninstall);
  });

  test(
    'a successful call logs one INFO line with path, query, status',
    () async {
      final dio = client((_) => jsonBody({'rows': []}));

      await dio.get<Object>('/board', queryParameters: {'limit': 1});

      expect(log.lines, hasLength(1));
      expect(
        log.lines.single,
        matches(r'INFO    api: GET /board\?limit=1 -> 200 \(\d+ ms\)$'),
      );
    },
  );

  test('a non-2xx answer logs a WARNING with the status', () async {
    final dio = client((_) => jsonBody({'detail': 'nope'}, status: 500));

    await expectLater(
      dio.post<Object>('/draft/1/start'),
      throwsA(isA<DioException>()),
    );

    expect(
      log.lines.single,
      contains('WARNING api: POST /draft/1/start failed: badResponse 500'),
    );
    expect(
      log.lines.single,
      isNot(contains('nope')),
      reason: 'bodies only when verbose',
    );
  });

  test('verbose adds request and response bodies', () async {
    log.verbose = true;
    final dio = client((_) => jsonBody({'ok': true}));

    await dio.post<Object>('/draft/1/start', data: {'season': 2026});

    final text = log.lines.join('\n');
    expect(
      text,
      contains('FINE    api: -> POST /draft/1/start body={season: 2026}'),
    );
    expect(text, contains('api: POST /draft/1/start -> 200'));
    expect(text, contains('body: {ok: true}'));
  });

  test('long bodies are cut at the limit with the full length noted', () {
    final long = 'x' * (LoggingInterceptor.bodyLimit + 5);

    expect(
      LoggingInterceptor.trim(long),
      '${'x' * LoggingInterceptor.bodyLimit}... (${long.length} chars)',
    );
  });
}
