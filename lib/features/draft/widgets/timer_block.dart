import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/models/draft_state.dart';
import '../../../app/theme/ls_theme.dart';
import '../draft_clock.dart';

/// JBM 700/32 (22 compact) countdown with a 220×3 progress bar under it;
/// textPrimary above 20 s, warning at 20, error at 10. Ticks from
/// [clockNowProvider]; a null countdown shows a dash and no bar.
class TimerBlock extends ConsumerWidget {
  const TimerBlock({super.key, required this.clock, this.compact = false});

  final DraftClock clock;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ls = context.ls;
    final now = ref.watch(clockNowProvider);
    final seconds = secondsRemaining(clock, now);
    final color = seconds == null
        ? ls.textSecondary
        : switch (timerTone(seconds)) {
            TimerTone.calm => ls.textPrimary,
            TimerTone.warning => ls.warningPrimary,
            TimerTone.error => ls.errorPrimary,
          };
    final fraction = timerFraction(clock, seconds);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: compact
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          seconds == null ? '—' : '${seconds}s',
          style: LsText.timer.copyWith(
            fontSize: compact ? 22 : 32,
            color: color,
          ),
        ),
        if (fraction != null) ...[
          const SizedBox(height: 4),
          SizedBox(
            width: compact ? 140 : 220,
            height: 3,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ls.track,
                borderRadius: BorderRadius.circular(99),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: fraction,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
