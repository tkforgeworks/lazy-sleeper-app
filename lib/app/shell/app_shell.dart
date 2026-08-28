import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router.dart';
import '../settings/logs_dialog.dart';
import '../settings/settings_screen.dart';
import '../theme/ls_theme.dart';
import 'top_nav.dart';

/// Responsive chrome around every section.
///
/// At or above [lsDesktopBreakpoint]: a 45 px top bar with text-pill nav.
/// Below it: a bottom [NavigationBar], hidden on non-section routes
/// (Settings) which carry their own Back. The section body is the same
/// widget either way; screens adapt their own internals via
/// `context.isDesktop`.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final current = LsSection.fromLocation(GoRouterState.of(context).uri.path);
    void select(LsSection section) => context.go(section.path);

    if (context.isDesktop) {
      return Scaffold(
        body: Column(
          children: [
            TopNav(
              current: current,
              onSelect: select,
              trailing: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [LogsButton(), SettingsButton()],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: current == null
          ? null
          : NavigationBar(
              selectedIndex: current.index,
              onDestinationSelected: (i) => select(LsSection.values[i]),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: [
                for (final s in LsSection.values)
                  NavigationDestination(icon: Icon(s.icon), label: s.label),
              ],
            ),
    );
  }
}
