import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';
import 'theme/ls_theme.dart';
import 'theme/theme_mode.dart';

class LazySleeperApp extends ConsumerWidget {
  const LazySleeperApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final mode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'Lazy Sleeper',
      theme: lsLightTheme(),
      darkTheme: lsDarkTheme(),
      themeMode: mode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
