import 'package:flutter/material.dart';

import '../../../api/models/draft_state.dart';
import '../../../app/theme/ls_theme.dart';
import '../../../app/widgets/atoms.dart';
import '../draft_view.dart';

/// `YOUR ROSTER` + one chip per starting/flex seat, bench summarised at
/// the end. Scrolls sideways on narrow screens. Roster null (slot not
/// known yet) renders a one-line explanation instead.
class RosterStrip extends StatelessWidget {
  const RosterStrip({super.key, required this.roster});

  final DraftRoster? roster;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final roster = this.roster;
    final label = Text(
      'YOUR ROSTER',
      style: LsText.microLabel.copyWith(
        fontWeight: FontWeight.w500,
        fontVariations: const [FontVariation('wght', 500)],
        letterSpacing: 0.4,
        color: ls.textSecondary,
      ),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: ls.border)),
      ),
      child: roster == null
          ? Row(
              children: [
                label,
                const SizedBox(width: LsSpacing.md),
                Expanded(
                  child: Text(
                    'Sleeper has not assigned your slot yet; the runner picks '
                    'it up once draft_order lands.',
                    style: LsText.aside.copyWith(
                      fontSize: 12,
                      color: ls.textSecondary,
                    ),
                  ),
                ),
              ],
            )
          : LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: Row(
                    children: [
                      label,
                      const SizedBox(width: LsSpacing.md),
                      for (final seat in rosterSeats(roster))
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: RosterSlotChip(
                            label: seat.label,
                            player: seat.player,
                          ),
                        ),
                      const SizedBox(width: LsSpacing.sm),
                      Text(
                        benchLabel(roster),
                        style: LsText.caption.copyWith(color: ls.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
