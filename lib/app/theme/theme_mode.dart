import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../prefs.dart';

final _log = Logger('settings');

/// Dark is the primary design target; light is first-class and one toggle
/// away. The choice is saved across launches (`system` follows the OS).
class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const prefsKey = 'theme_mode';
  static const defaultMode = ThemeMode.dark;

  @override
  ThemeMode build() {
    final saved = ref.watch(sharedPreferencesProvider).getString(prefsKey);
    return ThemeMode.values.where((m) => m.name == saved).firstOrNull ??
        defaultMode;
  }

  Future<void> set(ThemeMode mode) async {
    await ref.read(sharedPreferencesProvider).setString(prefsKey, mode.name);
    _log.info('theme set to ${mode.name}');
    state = mode;
  }

  Future<void> toggle() =>
      set(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);

  Future<void> reset() async {
    await ref.read(sharedPreferencesProvider).remove(prefsKey);
    state = defaultMode;
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);
