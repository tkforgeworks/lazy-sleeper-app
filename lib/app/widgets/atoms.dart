// Design-system atoms (COMPONENTS.md). Dark values in the comments; both
// palettes come from `context.ls`.

import 'package:flutter/material.dart';

import '../theme/ls_theme.dart';

/// bg purpleTint, r4, pad 1×6, JBM 500/10 purplePrimary. One style for all.
class PosChip extends StatelessWidget {
  const PosChip(this.position, {super.key});

  final String position;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: ls.purpleTint,
        borderRadius: BorderRadius.circular(LsRadius.chip),
      ),
      child: Text(
        position,
        style: LsText.microLabel.copyWith(
          fontWeight: FontWeight.w500,
          fontVariations: const [FontVariation('wght', 500)],
          letterSpacing: 0,
          color: ls.purplePrimary,
        ),
      ),
    );
  }
}

/// Transparent, 1px tier-colour border, r4, pad 1×5, JBM 600/10 tier colour.
/// Tiers past the five-colour scale all wear T5; untiered rows show a dash.
class TierBadge extends StatelessWidget {
  const TierBadge(this.tier, {super.key});

  final int? tier;

  @override
  Widget build(BuildContext context) {
    final tier = this.tier;
    if (tier == null) {
      return Text(
        '—',
        style: LsText.caption.copyWith(color: context.ls.textSecondary),
      );
    }
    final color = LsTiers.of(tier);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(LsRadius.chip),
      ),
      child: Text(
        'T$tier',
        style: LsText.microLabel.copyWith(letterSpacing: 0, color: color),
      ),
    );
  }
}

enum FlagSeverity { warning, error, info }

/// Semantic light bg, r4, pad 1×6, JBM 600/9.5 semantic text colour.
/// Never forge colours.
class StatusFlag extends StatelessWidget {
  const StatusFlag(this.label, {super.key, required this.severity});

  final String label;
  final FlagSeverity severity;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final (bg, fg) = switch (severity) {
      FlagSeverity.warning => (ls.warningLight, ls.warningText),
      FlagSeverity.error => (ls.errorLight, ls.errorText),
      FlagSeverity.info => (ls.infoLight, ls.infoText),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(LsRadius.chip),
      ),
      child: Text(
        label,
        style: LsText.microLabel.copyWith(
          fontSize: 9.5,
          letterSpacing: 0,
          color: fg,
        ),
      ),
    );
  }
}

/// Signed delta: success when favourable, error when not, secondary when
/// |Δ| ≤ 1. [goodIsPositive] flips the sense (ADP delta: + good).
class DeltaText extends StatelessWidget {
  const DeltaText({
    super.key,
    required this.value,
    required this.label,
    this.goodIsPositive = true,
    this.style = LsText.dataCell,
  });

  final double? value;
  final String label;
  final bool goodIsPositive;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final v = value;
    final Color color;
    if (v == null || v.abs() <= 1) {
      color = ls.textSecondary;
    } else {
      final good = goodIsPositive ? v > 0 : v < 0;
      color = good ? ls.successPrimary : ls.errorPrimary;
    }
    return Text(label, style: style.copyWith(color: color));
  }
}

/// Capsule, pad 4×10, JBM 600/11. Active: purpleTint bg + purplePrimary
/// border + text. Inactive: border token + textSecondary.
class LsFilterChip extends StatelessWidget {
  const LsFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: lsDuration,
          curve: lsCurve,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: selected ? ls.purpleTint : Colors.transparent,
            border: Border.all(color: selected ? ls.purplePrimary : ls.border),
            borderRadius: BorderRadius.circular(LsRadius.full),
          ),
          child: Text(
            label,
            style: LsText.microLabel.copyWith(
              fontSize: 11,
              letterSpacing: 0,
              color: selected ? ls.purplePrimary : ls.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Shared 1px border r6; cells Pop 500/12 pad 5×12; active cell purpleTint
/// bg + purplePrimary text.
class SegmentedTabs<T> extends StatelessWidget {
  const SegmentedTabs({
    super.key,
    required this.values,
    required this.selected,
    required this.label,
    required this.onSelect,
  });

  final List<T> values;
  final T selected;
  final String Function(T) label;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ls.border),
        borderRadius: BorderRadius.circular(LsRadius.segment),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final v in values)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onSelect(v),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AnimatedContainer(
                  duration: lsDuration,
                  curve: lsCurve,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: v == selected ? ls.purpleTint : Colors.transparent,
                    borderRadius: BorderRadius.circular(LsRadius.segment - 1),
                  ),
                  child: Text(
                    label(v),
                    style: LsText.rowTitle.copyWith(
                      fontSize: 12,
                      color: v == selected
                          ? ls.purplePrimary
                          : ls.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Primary button: purplePrimary fill, onPurple ink, Pop 600/14, pad 11×22,
/// r8; hover/press purpleDark. No elevation.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: ls.purplePrimary,
        foregroundColor: ls.onPurple,
        disabledBackgroundColor: ls.purpleTint,
        disabledForegroundColor: ls.textSecondary,
        overlayColor: ls.purpleDark,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LsRadius.card),
        ),
        textStyle: LsText.button,
      ),
      child: Text(label),
    );
  }
}

/// 7 dp status dot + JBM 400/11 secondary caption. Healthy = success,
/// stale = warning, dead = error.
class LiveDot extends StatelessWidget {
  const LiveDot({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(
        label,
        style: LsText.caption.copyWith(
          fontSize: 11,
          color: context.ls.textSecondary,
        ),
      ),
    ],
  );
}

/// Secondary button: purpleTint fill + 1px purplePrimary border, pad 6×14, r8.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: ls.purpleTint,
        foregroundColor: ls.purplePrimary,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ls.purplePrimary),
          borderRadius: BorderRadius.circular(LsRadius.card),
        ),
        textStyle: LsText.button.copyWith(fontSize: 13),
      ),
      child: Text(label),
    );
  }
}

/// Row: label 78 / track flex / value 44. Track 10 r3; fill = source colour,
/// width = value ÷ max. A null value draws an empty track and a dash.
class SourceProjectionBar extends StatelessWidget {
  const SourceProjectionBar({
    super.key,
    required this.label,
    required this.color,
    required this.value,
    required this.max,
  });

  final String label;
  final Color color;
  final double? value;
  final double max;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final v = value;
    return Row(
      children: [
        SizedBox(
          width: 78,
          child: Text(
            label,
            style: LsText.caption.copyWith(color: ls.textSecondary),
          ),
        ),
        Expanded(
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: ls.track,
              borderRadius: BorderRadius.circular(3),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: v == null || max <= 0 ? 0 : (v / max).clamp(0, 1),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 44,
          child: Text(
            v == null ? '—' : v.round().toString(),
            textAlign: TextAlign.right,
            style: LsText.dataCell.copyWith(color: ls.textPrimary),
          ),
        ),
      ],
    );
  }
}

/// Track 5 r-full; fill and the % label share a tone: success ≥ 70,
/// warning 45–69, error < 45. Label JBM 500/10.5, right, 32 wide.
class SurvivalBar extends StatelessWidget {
  const SurvivalBar({super.key, required this.survival});

  /// 0–1; null draws an empty track and a dash.
  final double? survival;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final s = survival;
    final color = s == null
        ? ls.textSecondary
        : s >= 0.70
        ? ls.successPrimary
        : s >= 0.45
        ? ls.warningPrimary
        : ls.errorPrimary;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              color: ls.track,
              borderRadius: BorderRadius.circular(99),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (s ?? 0).clamp(0, 1).toDouble(),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 7),
        SizedBox(
          width: 32,
          child: Text(
            s == null ? '—' : '${(s * 100).round()}%',
            textAlign: TextAlign.right,
            style: LsText.caption.copyWith(
              fontWeight: FontWeight.w500,
              fontVariations: const [FontVariation('wght', 500)],
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

/// minW 64, pad 4×8, r6. Empty: 1px dashed border, dash in secondary.
/// Filled: 1px purplePrimary + purpleTint bg, name Pop 500/10.5.
/// Slot label JBM 600/8.5 +6% above.
class RosterSlotChip extends StatelessWidget {
  const RosterSlotChip({super.key, required this.label, this.player});

  final String label;
  final String? player;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final filled = player != null;
    final body = Container(
      constraints: const BoxConstraints(minWidth: 64),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: filled
          ? BoxDecoration(
              color: ls.purpleTint,
              border: Border.all(color: ls.purplePrimary),
              borderRadius: BorderRadius.circular(LsRadius.segment),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: LsText.microLabel.copyWith(
              fontSize: 8.5,
              letterSpacing: 0.5,
              color: ls.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            player ?? '—',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: LsText.rowTitle.copyWith(
              fontSize: 10.5,
              color: filled ? ls.textPrimary : ls.textSecondary,
            ),
          ),
        ],
      ),
    );
    if (filled) return body;
    return CustomPaint(
      painter: _DashedBorder(color: ls.border, radius: LsRadius.segment),
      child: body,
    );
  }
}

/// 1px dashed rounded rectangle, 4 on / 3 off.
class _DashedBorder extends CustomPainter {
  const _DashedBorder({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(radius),
        ).deflate(0.5),
      );
    for (final metric in path.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 4), paint);
        d += 7;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorder old) =>
      old.color != color || old.radius != radius;
}
