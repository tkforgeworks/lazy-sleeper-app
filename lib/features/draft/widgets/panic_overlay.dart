import 'package:flutter/material.dart';

import '../../../api/models/draft_state.dart';
import '../../../app/theme/ls_theme.dart';
import '../draft_view.dart';

/// Full-screen highlight at my turn with 30 s or less: countdown eyebrow,
/// the recommended name in the forge gradient, one line of context, the
/// alternates. It never submits a pick — that happens in Sleeper. Tap
/// anywhere to wave it away for this pick.
class PanicOverlay extends StatelessWidget {
  const PanicOverlay({
    super.key,
    required this.state,
    required this.seconds,
    required this.onDismiss,
    this.compact = false,
  });

  final DraftState state;
  final int seconds;
  final VoidCallback onDismiss;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final rec = recommended(state);
    final alts = alternates(state);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onDismiss,
      child: Container(
        color: ls.panicScrim,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${seconds}S · YOU ARE ON THE CLOCK',
              style: LsText.microLabel.copyWith(
                fontSize: 13,
                letterSpacing: 3,
                color: ls.errorPrimary,
              ),
            ),
            const SizedBox(height: LsSpacing.md),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [ls.forgeYellow, ls.forgeOrange, ls.forgeRed],
                stops: const [0, 0.52, 1],
              ).createShader(bounds),
              child: Text(
                rec?.name ?? 'No recommendation',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: LsText.panicName.copyWith(
                  fontSize: compact ? 38 : 64,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: LsSpacing.md),
            Text(
              rec == null ? 'The board has not caught up yet.' : whyLine(rec),
              textAlign: TextAlign.center,
              style: LsText.aside.copyWith(
                fontSize: 15,
                fontStyle: FontStyle.normal,
                color: ls.textSecondary,
              ),
            ),
            const SizedBox(height: LsSpacing.lg),
            Text(
              'Make the pick in Sleeper. This screen only points.',
              textAlign: TextAlign.center,
              style: LsText.button.copyWith(color: ls.textPrimary),
            ),
            if (alts.isNotEmpty) ...[
              const SizedBox(height: LsSpacing.md),
              Text(
                "if he's gone: ${alts.map((a) => a.name).join(' · ')}",
                textAlign: TextAlign.center,
                style: LsText.caption.copyWith(
                  fontSize: 11,
                  color: ls.textSecondary,
                ),
              ),
            ],
            const SizedBox(height: LsSpacing.xl),
            Text(
              'tap to dismiss for this pick',
              style: LsText.caption.copyWith(color: ls.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
