import 'package:flutter/material.dart';

import '../../app/shell/placeholder_screen.dart';

/// The ranked, filterable player table: the app's home.
///
/// Placeholder until the API client and grid land (LS-39 increment 1,
/// commits 3 and 4).
class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) => const PlaceholderScreen(
    title: 'Big Board',
    aside: 'The board is on its way. Until then, admire the typography.',
  );
}
