import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/board/board_screen.dart';
import '../features/draft/draft_screen.dart';
import 'shell/app_shell.dart';
import 'shell/placeholder_screen.dart';

/// Top-level sections, in nav order. The path doubles as the route.
enum LsSection {
  board('/board', 'Board', Icons.table_rows_outlined),
  draft('/draft', 'Draft', Icons.timer_outlined),
  garage('/garage', 'Garage', Icons.tune_outlined),
  season('/season', 'Season', Icons.calendar_month_outlined);

  const LsSection(this.path, this.label, this.icon);

  final String path;
  final String label;

  /// Material outlined stand-ins; the design calls for Heroicons outline,
  /// which lands with the first real icon-bearing screen.
  final IconData icon;

  static LsSection fromLocation(String location) => values.firstWhere(
    (s) => location.startsWith(s.path),
    orElse: () => board,
  );
}

final routerProvider = Provider<GoRouter>((ref) => buildRouter());

GoRouter buildRouter() => GoRouter(
  initialLocation: LsSection.board.path,
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        _section(LsSection.board, const BoardScreen()),
        _section(LsSection.draft, const DraftScreen()),
        _section(
          LsSection.garage,
          const PlaceholderScreen(
            title: 'Tuning Garage',
            aside: 'Knobs arrive with LS-61. Nothing to turn yet.',
          ),
        ),
        _section(
          LsSection.season,
          const PlaceholderScreen(
            title: 'Season Monitor',
            aside: 'Waits on LS-60. So does the season.',
          ),
        ),
      ],
    ),
  ],
);

/// No entry animations anywhere in the app: sections swap in place.
GoRoute _section(LsSection section, Widget screen) => GoRoute(
  path: section.path,
  pageBuilder: (context, state) =>
      NoTransitionPage(key: state.pageKey, child: screen),
);
