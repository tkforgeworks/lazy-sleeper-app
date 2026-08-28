import 'package:dio/dio.dart';

import 'models/board.dart';

/// The lazy-sleeper FastAPI contract, as much of it as the app consumes.
///
/// Implementations: [HttpLazySleeperApi] (the real thing) and
/// `FixtureLazySleeperApi` (bundled JSON, for `--dart-define=LS_FAKE_DATA=true`).
abstract interface class LazySleeperApi {
  /// `GET /board`: the latest persisted board, ranked rows first.
  ///
  /// [position] filters server-side (`rank` stays overall); [limit] truncates.
  Future<BoardResponse> board({
    int? season,
    String? provider,
    String? position,
    int? limit,
  });
}

/// Anything that stopped a call from producing a parsed response: transport
/// failure, non-2xx status, or a body the models could not read.
class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode, this.cause});

  final String message;

  /// HTTP status when the server answered; null for transport failures.
  final int? statusCode;
  final Object? cause;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class HttpLazySleeperApi implements LazySleeperApi {
  const HttpLazySleeperApi(this._dio);

  final Dio _dio;

  @override
  Future<BoardResponse> board({
    int? season,
    String? provider,
    String? position,
    int? limit,
  }) => _get('/board', BoardResponse.fromJson, {
    'season': season,
    'provider': provider,
    'position': position,
    'limit': limit,
  });

  Future<T> _get<T>(
    String path,
    T Function(Map<String, dynamic>) parse,
    Map<String, Object?> query,
  ) async {
    final Response<Map<String, dynamic>> response;
    try {
      response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: {
          for (final e in query.entries)
            if (e.value != null) e.key: e.value,
        },
      );
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      throw ApiException(
        status == null
            ? 'Could not reach the API: ${e.message}'
            : 'GET $path returned $status',
        statusCode: status,
        cause: e,
      );
    }
    final body = response.data;
    if (body == null) {
      throw ApiException(
        'GET $path returned no body',
        statusCode: response.statusCode,
      );
    }
    try {
      return parse(body);
    } on Object catch (e) {
      throw ApiException(
        'GET $path: unexpected shape: $e',
        statusCode: response.statusCode,
        cause: e,
      );
    }
  }
}
