import 'package:flutter/material.dart';

import '../../../api/models/draft_state.dart';
import '../../../app/theme/ls_theme.dart';
import '../draft_view.dart';

/// The backend's best pick, with one line of why and two fallbacks.
/// Idle (not my turn): purpleTint border. Live (my turn): forge border and
/// eyebrow — the highlight is the whole feature; the pick is made in
/// Sleeper, never here.
class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.state,
    this.compact = false,
  });

  final DraftState state;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final rec = recommended(state);
    final live = state.clock.myTurn && !state.clock.complete;
    final alts = alternates(state);
    final border = live ? ls.forgeOrange : ls.purpleTint;
    final eyebrow = state.clock.complete
        ? 'DRAFT COMPLETE'
        : live
        ? 'YOUR PICK · MAKE IT IN SLEEPER'
        : 'IF YOU WERE UP NOW';
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 14 : 18,
        vertical: compact ? 12 : 14,
      ),
      decoration: BoxDecoration(
        color: ls.backgroundLight,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(LsRadius.card),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow,
                  style: LsText.microLabel.copyWith(
                    fontSize: 9.5,
                    letterSpacing: 1,
                    color: live ? ls.forgeOrange : ls.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  rec?.name ?? 'Nothing to recommend yet',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: LsText.recName.copyWith(
                    fontSize: compact ? 21 : 26,
                    color: ls.purplePrimary,
                  ),
                ),
                if (rec != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    rowSub(rec),
                    style: LsText.caption.copyWith(
                      fontSize: 10.5,
                      color: ls.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  rec == null
                      ? 'The first recompute fills this in.'
                      : whyLine(rec),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: LsText.aside.copyWith(
                    fontSize: 12.5,
                    color: ls.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (alts.isNotEmpty) ...[
            const SizedBox(width: LsSpacing.lg),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "IF HE'S GONE",
                  style: LsText.caption.copyWith(
                    fontSize: 9.5,
                    color: ls.textSecondary,
                  ),
                ),
                for (final a in alts) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ls.purpleTint,
                      borderRadius: BorderRadius.circular(LsRadius.segment),
                    ),
                    child: Text(
                      a.name,
                      style: LsText.rowTitle.copyWith(
                        fontSize: 12,
                        color: ls.textPrimary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
