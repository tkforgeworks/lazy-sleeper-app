import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../router.dart';
import '../theme/ls_theme.dart';

/// Desktop top bar: 45 px, logomark 22 px, app name Poppins 700/15 purple,
/// then the text-pill section nav. League meta and the snapshot LiveDot go in
/// [trailing] once the board provides them.
class TopNav extends StatelessWidget {
  const TopNav({
    super.key,
    required this.current,
    required this.onSelect,
    this.trailing,
  });

  static const height = 45.0;

  /// Null when no section is open (Settings): no pill is selected.
  final LsSection? current;
  final ValueChanged<LsSection> onSelect;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: LsSpacing.lg),
      decoration: BoxDecoration(
        color: ls.background,
        border: Border(bottom: BorderSide(color: ls.border)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/brand/tkforgeworks-mark.svg',
            height: 22,
            semanticsLabel: 'TK ForgeWorks',
          ),
          const SizedBox(width: LsSpacing.sm),
          Text(
            'Lazy Sleeper',
            style: LsText.screenTitle.copyWith(color: ls.purplePrimary),
          ),
          const SizedBox(width: LsSpacing.xxl),
          for (final s in LsSection.values)
            Padding(
              padding: const EdgeInsets.only(right: LsSpacing.xs),
              child: NavPill(
                label: s.label,
                selected: s == current,
                onTap: () => onSelect(s),
              ),
            ),
          const Spacer(),
          ?trailing,
        ],
      ),
    );
  }
}

/// Text pill: tinted capsule when selected, hover shifts colour only (200 ms).
class NavPill extends StatefulWidget {
  const NavPill({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<NavPill> createState() => _NavPillState();
}

class _NavPillState extends State<NavPill> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final fg = widget.selected
        ? ls.purplePrimary
        : _hover
        ? ls.purpleDark
        : ls.textSecondary;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: lsDuration,
          curve: lsCurve,
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
          decoration: BoxDecoration(
            color: widget.selected ? ls.purpleTint : Colors.transparent,
            borderRadius: BorderRadius.circular(LsRadius.segment),
          ),
          child: AnimatedDefaultTextStyle(
            duration: lsDuration,
            curve: lsCurve,
            style: LsText.navPill.copyWith(color: fg),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
