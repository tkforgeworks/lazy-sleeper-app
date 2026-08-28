import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

/// One INFO line per completed request (`GET /board?limit=1 -> 200 (87 ms)`),
/// WARNING on failure, and request/response bodies at FINE so `/state`
/// polling does not flood the log unless verbose is on.
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor([Logger? log]) : _log = log ?? Logger('api');

  final Logger _log;

  static const _startedAt = 'ls.startedAt';
  static const bodyLimit = 2000;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[_startedAt] = DateTime.now();
    if (_log.isLoggable(Level.FINE)) {
      final body = options.data == null ? '' : ' body=${trim(options.data)}';
      _log.fine('-> ${options.method} ${target(options)}$body');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<Object?> response,
    ResponseInterceptorHandler handler,
  ) {
    final o = response.requestOptions;
    _log.info(
      '${o.method} ${target(o)} -> ${response.statusCode} (${_elapsed(o)} ms)',
    );
    if (_log.isLoggable(Level.FINE)) {
      _log.fine('   body: ${trim(response.data)}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final o = err.requestOptions;
    final status = err.response?.statusCode;
    _log.warning(
      '${o.method} ${target(o)} failed: ${err.type.name}'
      '${status == null ? '' : ' $status'} (${_elapsed(o)} ms)'
      '${err.message == null ? '' : ': ${err.message}'}',
    );
    if (err.response?.data != null && _log.isLoggable(Level.FINE)) {
      _log.fine('   body: ${trim(err.response!.data)}');
    }
    handler.next(err);
  }

  static int _elapsed(RequestOptions o) {
    final started = o.extra[_startedAt];
    if (started is! DateTime) return 0;
    return DateTime.now().difference(started).inMilliseconds;
  }

  /// Path plus query, without the base URL: `/board?limit=1`.
  static String target(RequestOptions o) {
    if (o.queryParameters.isEmpty) return o.path;
    final query = Uri(
      queryParameters: {
        for (final e in o.queryParameters.entries) e.key: '${e.value}',
      },
    ).query;
    return '${o.path}?$query';
  }

  /// Bodies are cut at [bodyLimit] characters with the full length noted.
  static String trim(Object? body) {
    final text = '$body';
    if (text.length <= bodyLimit) return text;
    return '${text.substring(0, bodyLimit)}... (${text.length} chars)';
  }
}
