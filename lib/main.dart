import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/providers.dart';
import 'app/app.dart';
import 'app/log/app_log.dart';
import 'app/log/log_file.dart';
import 'app/prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final log = await _openLog();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        appLogProvider.overrideWithValue(log),
      ],
      child: const LazySleeperApp(),
    ),
  );
}

/// The session log: file-backed where the platform allows, in-memory
/// otherwise. A failure to open the file is logged, not fatal.
Future<AppLog> _openLog() async {
  LogSink? sink;
  Object? sinkError;
  try {
    sink = await openFileLogSink();
  } on Object catch (e) {
    sinkError = e;
  }
  final log = AppLog(sink: sink)..install();
  final app = Logger('app');
  app.info(
    'session start: platform=${kIsWeb ? 'web' : defaultTargetPlatform.name} '
    'mode=${kReleaseMode ? 'release' : 'debug'} '
    'defaultApiUrl=$lsApiUrlDefault fakeData=$lsFakeData',
  );
  if (sinkError != null) {
    app.warning('log file unavailable, in-memory only', sinkError);
  }
  return log;
}
