import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/prefs.dart';
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

/// The API base URL: the value saved in-app if there is one, else
/// [lsApiUrlDefault]. Changing it here re-creates the client and re-fetches.
class ApiBaseUrl extends Notifier<String> {
  static const prefsKey = 'api_base_url';

  @override
  String build() =>
      ref.watch(sharedPreferencesProvider).getString(prefsKey) ??
      lsApiUrlDefault;

  /// Persists [url] (already validated by [normalizeApiUrl]) and applies it.
  Future<void> set(String url) async {
    await ref.read(sharedPreferencesProvider).setString(prefsKey, url);
    state = url;
  }

  /// Drops the saved value and returns to the build-time default.
  Future<void> reset() async {
    await ref.read(sharedPreferencesProvider).remove(prefsKey);
    state = lsApiUrlDefault;
  }
}

final apiBaseUrlProvider = NotifierProvider<ApiBaseUrl, String>(ApiBaseUrl.new);

/// Trims and validates an API address; returns the canonical form or null
/// when it is not an absolute http(s) URL with a host. No trailing slash.
String? normalizeApiUrl(String input) {
  final text = input.trim();
  final uri = Uri.tryParse(text);
  if (uri == null || !uri.isAbsolute || uri.host.isEmpty) return null;
  if (uri.scheme != 'http' && uri.scheme != 'https') return null;
  final path = uri.path.endsWith('/')
      ? uri.path.substring(0, uri.path.length - 1)
      : uri.path;
  return uri.replace(path: path, query: null, fragment: null).toString();
}

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
  if (lsFakeData) return FixtureLazySleeperApi();
  return HttpLazySleeperApi(ref.watch(dioProvider));
});
