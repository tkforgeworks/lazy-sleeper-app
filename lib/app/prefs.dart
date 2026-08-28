import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The loaded [SharedPreferences] instance. `main()` loads it before the
/// first frame and overrides this provider; tests override it with a mock.
/// Reading it without an override is a programming error, hence the throw.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw StateError(
    'sharedPreferencesProvider must be overridden at the ProviderScope root',
  ),
);
