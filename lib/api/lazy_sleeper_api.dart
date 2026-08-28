import 'package:dio/dio.dart';

import 'models/board.dart';
import 'models/draft.dart';

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

  /// `GET /draft`: drafts this API process knows about.
  Future<List<DraftSummary>> drafts();

  /// `POST /draft/{id}/start`: pre-draft load and start polling Sleeper.
  /// Idempotent while the runner is alive (`alreadyRunning`).
  Future<DraftStartOut> startDraft(String draftId, {int season = 2026});

  /// `POST /draft/{id}/stop`: stop polling. 404 when it is not running.
  Future<DraftStopOut> stopDraft(String draftId);
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
  }) => _request(
    'GET',
    '/board',
    query: {
      'season': season,
      'provider': provider,
      'position': position,
      'limit': limit,
    },
    parse: (body) => BoardResponse.fromJson(body as Map<String, dynamic>),
  );

  @override
  Future<List<DraftSummary>> drafts() => _request(
    'GET',
    '/draft',
    parse: (body) => [
      for (final e in body as List<dynamic>)
        DraftSummary.fromJson(e as Map<String, dynamic>),
    ],
  );

  @override
  Future<DraftStartOut> startDraft(String draftId, {int season = 2026}) =>
      _request(
        'POST',
        '/draft/$draftId/start',
        data: {'season': season},
        parse: (body) => DraftStartOut.fromJson(body as Map<String, dynamic>),
      );

  @override
  Future<DraftStopOut> stopDraft(String draftId) => _request(
    'POST',
    '/draft/$draftId/stop',
    parse: (body) => DraftStopOut.fromJson(body as Map<String, dynamic>),
  );

  Future<T> _request<T>(
    String method,
    String path, {
    Map<String, Object?> query = const {},
    Object? data,
    required T Function(Object body) parse,
  }) async {
    final Response<Object> response;
    try {
      response = await _dio.request<Object>(
        path,
        data: data,
        queryParameters: {
          for (final e in query.entries)
            if (e.value != null) e.key: e.value,
        },
        options: Options(method: method),
      );
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      throw ApiException(
        status == null
            ? 'Could not reach the API: ${e.message}'
            : '$method $path returned $status${_detail(e.response?.data)}',
        statusCode: status,
        cause: e,
      );
    }
    final body = response.data;
    if (body == null) {
      throw ApiException(
        '$method $path returned no body',
        statusCode: response.statusCode,
      );
    }
    try {
      return parse(body);
    } on Object catch (e) {
      throw ApiException(
        '$method $path: unexpected shape: $e',
        statusCode: response.statusCode,
        cause: e,
      );
    }
  }

  /// FastAPI error bodies carry `{"detail": "..."}`; surface it when present.
  static String _detail(Object? body) {
    if (body is Map && body['detail'] is String) return ': ${body['detail']}';
    return '';
  }
}
