import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fixture_api.dart';
import 'lazy_sleeper_api.dart';

/// Build-time defaults. Override at build/run time, e.g.
/// `flutter run --dart-define=LS_API_URL=http://100.x.y.z:8000` for the
/// tailnet, or `--dart-define=LS_FAKE_DATA=true` to run on bundled fixtures.
///
/// Note the Android emulator reaches the host at `10.0.2.2`, not `127.0.0.1`.
const lsApiUrlDefault = String.fromEnvironment(
  'LS_API_URL',
  defaultValue: 'http://127.0.0.1:8000',
);
const lsFakeData = bool.fromEnvironment('LS_FAKE_DATA');

/// The API base URL. Starts at [lsApiUrlDefault]; an in-app settings sheet
/// will [set] it without a rebuild (LS-39 acceptance criterion).
class ApiBaseUrl extends Notifier<String> {
  @override
  String build() => lsApiUrlDefault;

  void set(String url) => state = url;
}

final apiBaseUrlProvider = NotifierProvider<ApiBaseUrl, String>(ApiBaseUrl.new);

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ref.watch(apiBaseUrlProvider),
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
    ),
  );
  ref.onDispose(dio.close);
  return dio;
});

/// The one place the app picks real vs fixture data.
final lazySleeperApiProvider = Provider<LazySleeperApi>((ref) {
  if (lsFakeData) return const FixtureLazySleeperApi();
  return HttpLazySleeperApi(ref.watch(dioProvider));
});
