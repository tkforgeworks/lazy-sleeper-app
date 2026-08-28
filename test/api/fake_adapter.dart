import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lazy_sleeper_app/api/lazy_sleeper_api.dart';

/// Answers every request with a canned [ResponseBody] and records what it saw.
class FakeAdapter implements HttpClientAdapter {
  FakeAdapter(this._respond);

  final ResponseBody Function(RequestOptions) _respond;
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return _respond(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody jsonBody(Object body, {int status = 200}) =>
    ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

({HttpLazySleeperApi api, FakeAdapter adapter}) fakeClient(
  ResponseBody Function(RequestOptions) respond,
) {
  final adapter = FakeAdapter(respond);
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local'))
    ..httpClientAdapter = adapter;
  return (api: HttpLazySleeperApi(dio), adapter: adapter);
}
