import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/ls_theme.dart';
import '../../../app/widgets/atoms.dart';
import '../board_providers.dart';
import '../board_view.dart';

/// Position filter chips, RANK BY tabs, row count, and the (stub) export
/// button. Controls wrap onto extra lines on narrow widths instead of
/// clipping.
class BoardToolbar extends ConsumerWidget {
  const BoardToolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ls = context.ls;
    final position = ref.watch(positionFilterProvider);
    final sort = ref.watch(boardSortProvider);
    final count = ref.watch(visibleRowsProvider).length;
    final desktop = context.isDesktop;

    final chips = Wrap(
      spacing: LsSpacing.xs,
      runSpacing: LsSpacing.xs,
      children: [
        LsFilterChip(
          label: 'ALL',
          selected: position == null,
          onTap: () => ref.read(positionFilterProvider.notifier).set(null),
        ),
        for (final p in boardPositions)
          LsFilterChip(
            label: p,
            selected: position == p,
            onTap: () => ref.read(positionFilterProvider.notifier).set(p),
          ),
      ],
    );

    final rankBy = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'RANK BY',
          style: LsText.microLabel.copyWith(color: ls.textSecondary),
        ),
        const SizedBox(width: LsSpacing.sm),
        SegmentedTabs<BoardSort>(
          values: BoardSort.values,
          selected: sort,
          label: (s) => s.label,
          onSelect: (s) => ref.read(boardSortProvider.notifier).set(s),
        ),
      ],
    );

    final countText = Text(
      '$count players',
      style: LsText.caption.copyWith(fontSize: 11, color: ls.textSecondary),
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: desktop ? 18 : LsSpacing.md,
        vertical: LsSpacing.sm,
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: ls.border)),
      ),
      child: desktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: LsSpacing.xl,
                    runSpacing: LsSpacing.sm,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [chips, rankBy, countText],
                  ),
                ),
                const SizedBox(width: LsSpacing.lg),
                SecondaryButton(
                  label: 'Export tier sheet',
                  onPressed: () => _notYet(context),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chips,
                const SizedBox(height: LsSpacing.sm),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: rankBy,
                ),
                const SizedBox(height: LsSpacing.xs),
                countText,
              ],
            ),
    );
  }

  void _notYet(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'The printer is still warming up. Tier sheets come later.',
          style: LsText.aside,
        ),
      ),
    );
  }
}
