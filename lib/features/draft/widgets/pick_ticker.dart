import 'package:flutter/material.dart';

import '../../../api/models/draft_state.dart';
import '../../../app/theme/ls_theme.dart';
import '../draft_view.dart';

/// League-wide feed, most recent first: pick no / name · owner / pos.
class PickTicker extends StatelessWidget {
  const PickTicker({super.key, required this.picks, this.mySlot});

  final List<RecentPick> picks;

  /// My picks get the purple pick number.
  final int? mySlot;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PICK TICKER',
          style: LsText.microLabel.copyWith(color: ls.textSecondary),
        ),
        const SizedBox(height: LsSpacing.sm),
        if (picks.isEmpty)
          Text(
            'Nothing yet. The room is quiet.',
            style: LsText.aside.copyWith(fontSize: 12, color: ls.textSecondary),
          ),
        for (final p in picks)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                SizedBox(
                  width: 36,
                  child: Text(
                    '${p.pickNo}',
                    style: LsText.caption.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      fontVariations: const [FontVariation('wght', 500)],
                      color: mySlot != null && p.slot == mySlot
                          ? ls.purplePrimary
                          : ls.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: p.name ?? dash,
                          style: LsText.rowTitle.copyWith(
                            fontSize: 11.5,
                            color: ls.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: ' · ${pickOwner(p)}',
                          style: LsText.caption.copyWith(
                            fontSize: 9.5,
                            color: ls.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    p.position ?? dash,
                    textAlign: TextAlign.right,
                    style: LsText.caption.copyWith(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w500,
                      fontVariations: const [FontVariation('wght', 500)],
                      color: ls.purplePrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
