import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/lazy_sleeper_api.dart';
import '../../api/models/board.dart';
import '../../app/theme/ls_theme.dart';
import '../../app/widgets/atoms.dart';
import 'board_providers.dart';
import 'widgets/board_list.dart';
import 'widgets/board_table.dart';
import 'widgets/board_toolbar.dart';
import 'widgets/player_detail.dart';

/// The ranked, filterable player table: the app's home.
///
/// Desktop: toolbar, 13-column grid, right-anchored detail drawer.
/// Mobile: toolbar, condensed rows, detail as a bottom sheet.
/// Row taps never navigate away from the board.
class BoardScreen extends ConsumerWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(boardProvider);
    return board.when(
      loading: () => const _Loading(),
      error: (e, _) =>
          _Error(error: e, onRetry: () => ref.invalidate(boardProvider)),
      data: (data) =>
          context.isDesktop ? _Desktop(meta: data.board) : const _Mobile(),
    );
  }
}

class _Desktop extends ConsumerWidget {
  const _Desktop({required this.meta});

  final BoardMeta meta;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedRowProvider);
    final select = ref.read(selectedRowProvider.notifier).select;
    return Stack(
      children: [
        Column(
          children: [
            const BoardToolbar(),
            Expanded(
              child: BoardTable(meta: meta, onOpen: select),
            ),
          ],
        ),
        if (selected != null)
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: PlayerDrawer(row: selected, onClose: () => select(null)),
          ),
      ],
    );
  }
}

class _Mobile extends StatelessWidget {
  const _Mobile();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const BoardToolbar(),
      Expanded(
        child: BoardList(onOpen: (row) => showPlayerSheet(context, row)),
      ),
    ],
  );
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      'Fetching the board. The backend is thinking about it.',
      style: LsText.aside.copyWith(color: context.ls.textSecondary),
    ),
  );
}

class _Error extends StatelessWidget {
  const _Error({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final detail = error is ApiException
        ? (error as ApiException).message
        : '$error';
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No board.',
              style: LsText.drawerName.copyWith(color: ls.textPrimary),
            ),
            const SizedBox(height: LsSpacing.xs),
            Text(
              'The API did not answer. Check the address, or that it is running.',
              textAlign: TextAlign.center,
              style: LsText.aside.copyWith(color: ls.textSecondary),
            ),
            const SizedBox(height: LsSpacing.sm),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: LsText.caption.copyWith(color: ls.textSecondary),
            ),
            const SizedBox(height: LsSpacing.lg),
            SecondaryButton(label: 'Try again', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
