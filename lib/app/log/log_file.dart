// Opens the session log file where the platform has a filesystem, else
// resolves to null (web). The conditional export keeps `dart:io` out of
// the web build.
export 'log_file_stub.dart' if (dart.library.io) 'log_file_io.dart';
