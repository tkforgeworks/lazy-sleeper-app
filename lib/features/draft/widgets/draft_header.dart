import 'package:flutter/material.dart';

import '../../../api/models/draft_state.dart';
import '../../../app/theme/ls_theme.dart';
import '../../../app/widgets/atoms.dart';
import '../draft_view.dart';

/// Command Center header: pick label, on-the-clock team with the timer
/// slot under it, and the picks-until-you box (solid purple at my turn).
/// [center] is the TimerBlock once it exists; [trailing] holds the health
/// dot and the runner button.
class DraftHeader extends StatelessWidget {
  const DraftHeader({
    super.key,
    required this.state,
    this.center,
    this.trailing,
    this.compact = false,
  });

  final DraftState state;
  final Widget? center;
  final Widget? trailing;

  /// Mobile: two rows — pick + trailing, then on-the-clock + until-you.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final clock = state.clock;
    final pick = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pick ${pickLabel(clock, state.spec)}',
          style: LsText.screenTitle.copyWith(
            fontSize: 17,
            color: ls.textPrimary,
          ),
        ),
        Text(
          pickSubLabel(clock, state.spec),
          style: LsText.caption.copyWith(fontSize: 10, color: ls.textSecondary),
        ),
      ],
    );
    final onClock = Text(
      'ON THE CLOCK · ${onTheClockLabel(clock).toUpperCase()}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: compact ? TextAlign.left : TextAlign.center,
      style: LsText.caption.copyWith(
        fontSize: 11,
        color: clock.myTurn ? ls.purplePrimary : ls.textSecondary,
      ),
    );
    final decoration = BoxDecoration(
      border: Border(bottom: BorderSide(color: ls.border)),
    );
    if (compact) {
      return Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
        decoration: decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: pick),
                ?trailing,
              ],
            ),
            const SizedBox(height: LsSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [onClock, ?center],
                  ),
                ),
                const SizedBox(width: LsSpacing.sm),
                UntilYouBox(clock: clock, compact: true),
              ],
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: decoration,
      child: Row(
        children: [
          pick,
          const SizedBox(width: LsSpacing.lg),
          Expanded(child: Column(children: [onClock, ?center])),
          const SizedBox(width: LsSpacing.lg),
          UntilYouBox(clock: clock),
          if (trailing != null) ...[
            const SizedBox(width: LsSpacing.md),
            trailing!,
          ],
        ],
      ),
    );
  }
}

/// Big number + caption; solid purple with onPurple text at my turn.
class UntilYouBox extends StatelessWidget {
  const UntilYouBox({super.key, required this.clock, this.compact = false});

  final DraftClock clock;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final (:value, :caption) = untilYou(clock);
    final mine = clock.myTurn;
    return AnimatedContainer(
      duration: lsDuration,
      curve: lsCurve,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 14,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: mine ? ls.purplePrimary : ls.backgroundLight,
        border: Border.all(color: mine ? ls.purplePrimary : ls.border),
        borderRadius: BorderRadius.circular(LsRadius.card),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: LsText.statValue.copyWith(
              fontSize: compact ? 17 : 22,
              color: mine ? ls.onPurple : ls.purplePrimary,
            ),
          ),
          Text(
            caption,
            style: LsText.microLabel.copyWith(
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
              fontVariations: const [FontVariation('wght', 500)],
              letterSpacing: 0.6,
              color: mine ? ls.onPurple : ls.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Poll health for the header: green while polls succeed, red when the
/// last one failed (the state shown is the last good one), amber when the
/// backend says its recompute is stale.
class PollHealthDot extends StatelessWidget {
  const PollHealthDot({
    super.key,
    required this.state,
    required this.pollFailed,
  });

  final DraftState state;
  final bool pollFailed;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    if (pollFailed) {
      return LiveDot(color: ls.errorPrimary, label: 'poll failed');
    }
    if (state.recompute.stale || state.recompute.error != null) {
      return LiveDot(color: ls.warningPrimary, label: 'stale advice');
    }
    if (state.poller.degraded) {
      return LiveDot(color: ls.warningPrimary, label: 'sleeper degraded');
    }
    return LiveDot(
      color: ls.successPrimary,
      label: state.poller.status ?? 'live',
    );
  }
}
