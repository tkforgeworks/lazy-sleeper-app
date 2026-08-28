import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

/// Where captured lines go besides the in-memory buffer: a file on desktop
/// and mobile (see `log_file_io.dart`), nothing on web.
abstract interface class LogSink {
  /// Human-readable location for the Logs dialog; null when there is none.
  String? get location;

  void write(String line);

  Future<void> close();
}

/// Build-time default level; `--dart-define=LS_LOG_LEVEL=FINE` for verbose
/// (request/response bodies). The Logs dialog can toggle it at runtime.
const lsLogLevelDefault = String.fromEnvironment(
  'LS_LOG_LEVEL',
  defaultValue: 'INFO',
);

/// The `package:logging` level named [name] (case-insensitive), else INFO.
Level parseLogLevel(String name) => Level.LEVELS.firstWhere(
  (l) => l.name == name.trim().toUpperCase(),
  orElse: () => Level.INFO,
);

/// Captures every `package:logging` record the root logger sees: keeps the
/// last [capacity] formatted lines in memory for the Logs dialog, mirrors
/// them to [sink], and echoes them to the console when [echo] is on. Loggers
/// are named per area (`api`, `draft`, `settings`, `app`).
///
/// `main()` builds one, calls [install], and overrides [appLogProvider] with
/// it; tests do the same with no sink. Listeners are notified per record.
class AppLog extends ChangeNotifier {
  AppLog({this.sink, this.capacity = 4000, Level? initialLevel, bool? echo})
    : _initialLevel = initialLevel ?? parseLogLevel(lsLogLevelDefault),
      echo = echo ?? kDebugMode;

  final LogSink? sink;
  final int capacity;

  /// Mirror lines to the console (`debugPrint`); on by default in debug
  /// builds, off in tests to keep their output readable.
  final bool echo;
  final Level _initialLevel;
  final _lines = ListQueue<String>();
  StreamSubscription<LogRecord>? _subscription;
  FlutterExceptionHandler? _previousFlutterOnError;
  bool _capturingFlutterErrors = false;

  static final _log = Logger('app');

  /// Captured lines, oldest first.
  List<String> get lines => List.unmodifiable(_lines);

  int get length => _lines.length;

  Level get level => Logger.root.level;

  set level(Level value) {
    if (Logger.root.level == value) return;
    Logger.root.level = value;
    _log.config('log level set to ${value.name}');
    notifyListeners();
  }

  /// Verbose means FINE or lower: request/response bodies are recorded.
  bool get verbose => level <= Level.FINE;

  set verbose(bool on) => level = on ? Level.FINE : Level.INFO;

  /// Starts capturing. [captureFlutterErrors] hooks `FlutterError.onError`
  /// and `PlatformDispatcher.onError` so framework and uncaught async errors
  /// land in the log; widget tests leave it off because the test binding
  /// owns those hooks.
  void install({bool captureFlutterErrors = true}) {
    if (_subscription != null) return;
    Logger.root.level = _initialLevel;
    _subscription = Logger.root.onRecord.listen(_onRecord);
    if (captureFlutterErrors) {
      _capturingFlutterErrors = true;
      _previousFlutterOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        _log.severe(
          'Flutter error: ${details.exceptionAsString()}',
          details.exception,
          details.stack,
        );
        _previousFlutterOnError?.call(details);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        _log.severe('Uncaught error', error, stack);
        return false;
      };
    }
  }

  void _onRecord(LogRecord record) {
    final line = formatRecord(record);
    if (_lines.length >= capacity) _lines.removeFirst();
    _lines.addLast(line);
    sink?.write(line);
    if (echo) debugPrint(line);
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    notifyListeners();
  }

  /// The whole buffer with a header, for copy/save.
  String export() {
    final b = StringBuffer()
      ..writeln('Lazy Sleeper app log')
      ..writeln(
        'exported ${formatTimestamp(DateTime.now())}  '
        'level ${level.name}  '
        'lines ${_lines.length}/$capacity  '
        'file ${sink?.location ?? 'none'}',
      )
      ..writeln('---');
    for (final line in _lines) {
      b.writeln(line);
    }
    return b.toString();
  }

  /// Stops capturing and closes the sink. Restores the error hooks it took.
  Future<void> uninstall() async {
    await _subscription?.cancel();
    _subscription = null;
    if (_capturingFlutterErrors) {
      FlutterError.onError = _previousFlutterOnError;
      _capturingFlutterErrors = false;
    }
    await sink?.close();
  }

  /// `2026-09-04 19:30:01.042 INFO    api: GET /board -> 200 (87 ms)`, with
  /// the error and stack trace (when present) on following lines.
  static String formatRecord(LogRecord r) {
    final b = StringBuffer()
      ..write(formatTimestamp(r.time))
      ..write(' ')
      ..write(r.level.name.padRight(7))
      ..write(' ')
      ..write(r.loggerName)
      ..write(': ')
      ..write(r.message);
    if (r.error != null) b.write('\n  error: ${r.error}');
    if (r.stackTrace != null) {
      b.write('\n  ${r.stackTrace.toString().trimRight()}');
    }
    return b.toString();
  }

  /// Local time, `yyyy-MM-dd HH:mm:ss.SSS`, without pulling in intl.
  static String formatTimestamp(DateTime t) {
    String two(int n) => n.toString().padLeft(2, '0');
    final ms = t.millisecond.toString().padLeft(3, '0');
    return '${t.year}-${two(t.month)}-${two(t.day)} '
        '${two(t.hour)}:${two(t.minute)}:${two(t.second)}.$ms';
  }
}

/// The installed [AppLog]. `main()` overrides this before the first frame;
/// tests override it in `pumpApp`. Reading it without an override is a
/// programming error, hence the throw.
final appLogProvider = Provider<AppLog>(
  (ref) => throw StateError(
    'appLogProvider must be overridden at the ProviderScope root',
  ),
);
