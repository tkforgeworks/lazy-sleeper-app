import 'package:flutter/material.dart';

import '../theme/ls_theme.dart';

/// Stand-in for a section that has not shipped yet: title plus one editorial
/// aside in the app's voice (dry, self-aware, one line).
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.aside,
  });

  final String title;
  final String aside;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: LsText.drawerName.copyWith(color: ls.textPrimary)),
          const SizedBox(height: LsSpacing.sm),
          Text(aside, style: LsText.aside.copyWith(color: ls.textSecondary)),
        ],
      ),
    );
  }
}
