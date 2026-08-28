import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/app/log/app_log.dart';
import 'package:logging/logging.dart';

class MemorySink implements LogSink {
  final written = <String>[];
  bool closed = false;

  @override
  String? get location => 'memory://sink';

  @override
  void write(String line) => written.add(line);

  @override
  Future<void> close() async => closed = true;
}

void main() {
  late AppLog log;
  late MemorySink sink;

  setUp(() {
    sink = MemorySink();
    log = AppLog(sink: sink, capacity: 3, initialLevel: Level.INFO, echo: false)
      ..install(captureFlutterErrors: false);
    addTearDown(log.uninstall);
  });

  test('captures records at or above the level, formatted one per line', () {
    Logger('api').info('GET /board -> 200 (5 ms)');
    Logger('api').fine('body: {}');

    expect(log.lines, hasLength(1));
    expect(
      log.lines.single,
      matches(
        r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3} INFO    api: '
        r'GET /board -> 200 \(5 ms\)$',
      ),
    );
    expect(sink.written, log.lines);
  });

  test('keeps only the newest [capacity] lines', () {
    for (var i = 1; i <= 5; i++) {
      Logger('t').info('line $i');
    }

    expect(log.lines.map((l) => l.split(': ').last), [
      'line 3',
      'line 4',
      'line 5',
    ]);
    expect(sink.written, hasLength(5), reason: 'the sink is not capped');
  });

  test('error and stack trace follow the message on indented lines', () {
    Logger('draft')
        .severe('boom', StateError('bad'), StackTrace.fromString('#0 here'));

    expect(
      log.lines.single,
      contains('SEVERE  draft: boom\n  error: Bad state: bad\n  #0 here'),
    );
  });

  test('verbose toggles the root level and records the change', () {
    expect(log.verbose, isFalse);
    log.verbose = true;

    expect(Logger.root.level, Level.FINE);
    expect(log.lines.last, contains('CONFIG  app: log level set to FINE'));
    Logger('api').fine('now visible');
    expect(log.lines.last, endsWith('api: now visible'));
  });

  test('export carries a header, the file location and every line', () {
    Logger('app').info('hello');

    final text = log.export();
    expect(text, startsWith('Lazy Sleeper app log\n'));
    expect(text, contains('level INFO  lines 1/3  file memory://sink\n---\n'));
    expect(text.trimRight(), endsWith('app: hello'));
  });

  test('parseLogLevel is case-insensitive and falls back to INFO', () {
    expect(parseLogLevel('fine'), Level.FINE);
    expect(parseLogLevel(' WARNING '), Level.WARNING);
    expect(parseLogLevel('nope'), Level.INFO);
  });

  test('uninstall stops capturing and closes the sink', () async {
    await log.uninstall();
    Logger('app').info('after');

    expect(log.lines, isEmpty);
    expect(sink.closed, isTrue);
  });
}
