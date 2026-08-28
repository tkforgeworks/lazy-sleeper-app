import 'app_log.dart';

/// No filesystem on this platform: in-memory buffer only.
Future<LogSink?> openFileLogSink() async => null;
