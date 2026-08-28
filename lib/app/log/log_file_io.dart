import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'app_log.dart';

/// Session files kept in the logs directory; older ones are pruned on open.
const logFilesKept = 10;

/// A per-session `lazy-sleeper-app-<timestamp>.log` under the app-support
/// directory (Windows: `%APPDATA%\<org>\<app>\logs`).
Future<LogSink?> openFileLogSink() async {
  final support = await getApplicationSupportDirectory();
  final dir = Directory('${support.path}${Platform.pathSeparator}logs');
  await dir.create(recursive: true);
  _prune(dir);
  final stamp = DateTime.now()
      .toIso8601String()
      .replaceAll(':', '')
      .replaceAll('-', '')
      .split('.')
      .first;
  final file = File(
    '${dir.path}${Platform.pathSeparator}lazy-sleeper-app-$stamp.log',
  );
  return FileLogSink(file);
}

void _prune(Directory dir) {
  final files =
      dir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.contains('lazy-sleeper-app-'))
          .toList()
        ..sort((a, b) => b.path.compareTo(a.path));
  for (final old in files.skip(logFilesKept - 1)) {
    try {
      old.deleteSync();
    } on FileSystemException {
      // Best effort; a file locked by another instance stays.
    }
  }
}

/// Every line is written and flushed synchronously so a hard crash still
/// leaves the last lines on disk. Volume is a few lines per second at most.
class FileLogSink implements LogSink {
  FileLogSink(this._file) : _raf = _file.openSync(mode: FileMode.writeOnly);

  final File _file;
  final RandomAccessFile _raf;

  @override
  String get location => _file.path;

  @override
  void write(String line) {
    _raf
      ..writeStringSync('$line\n')
      ..flushSync();
  }

  @override
  Future<void> close() => _raf.close();
}
