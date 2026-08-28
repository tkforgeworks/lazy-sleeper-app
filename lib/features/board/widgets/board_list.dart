import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/models/board.dart';
import '../../../app/theme/ls_theme.dart';
import '../../../app/widgets/atoms.dart';
import '../board_providers.dart';
import '../board_view.dart';

/// Mobile rows: rank / T-badge + pos / name + sub / ENS / VORP. No tier
/// breaks; the position chips do that job on a phone.
class BoardList extends ConsumerWidget {
  const BoardList({super.key, required this.onOpen});

  final ValueChanged<BoardRow> onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rows = ref.watch(visibleRowsProvider);
    return ListView.builder(
      itemCount: rows.length,
      itemBuilder: (context, i) =>
          _MobileRow(row: rows[i], onTap: () => onOpen(rows[i])),
    );
  }
}

class _MobileRow extends StatelessWidget {
  const _MobileRow({required this.row, required this.onTap});

  final BoardRow row;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final r = row;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: LsSpacing.md,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: ls.divider)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '${r.rank}',
                style: LsText.dataCell.copyWith(color: ls.textSecondary),
              ),
            ),
            SizedBox(
              width: 56,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TierBadge(r.tier),
                  const SizedBox(height: 2),
                  PosChip(r.position),
                ],
              ),
            ),
            const SizedBox(width: LsSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    r.name,
                    overflow: TextOverflow.ellipsis,
                    style: LsText.rowTitle.copyWith(color: ls.textPrimary),
                  ),
                  Text(
                    rowSub(r),
                    style: LsText.caption.copyWith(
                      fontSize: 10,
                      color: ls.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 52,
              child: Text(
                fmtPts(r.points),
                textAlign: TextAlign.right,
                style: LsText.dataCellBold.copyWith(color: ls.textPrimary),
              ),
            ),
            SizedBox(
              width: 48,
              child: Text(
                fmtPts(r.vorp),
                textAlign: TextAlign.right,
                style: LsText.dataCellBold.copyWith(color: ls.purplePrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
