import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/providers.dart';
import '../theme/ls_theme.dart';
import '../widgets/atoms.dart';

/// Gear button that opens [showApiAddressDialog]. Lives in the top nav on
/// desktop and the board toolbar on mobile.
class ApiAddressButton extends StatelessWidget {
  const ApiAddressButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: 'API address',
    onPressed: () => showApiAddressDialog(context),
    icon: Icon(
      Icons.settings_outlined,
      size: 18,
      color: context.ls.textSecondary,
    ),
    visualDensity: VisualDensity.compact,
  );
}

/// Change the backend address without a rebuild (the tailnet address on
/// draft night). Saved across launches; Reset returns to the build default.
Future<void> showApiAddressDialog(BuildContext context) => showDialog<void>(
  context: context,
  builder: (_) => const ApiAddressDialog(),
);

class ApiAddressDialog extends ConsumerStatefulWidget {
  const ApiAddressDialog({super.key});

  @override
  ConsumerState<ApiAddressDialog> createState() => _ApiAddressDialogState();
}

class _ApiAddressDialogState extends ConsumerState<ApiAddressDialog> {
  late final TextEditingController _controller;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(apiBaseUrlProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final url = normalizeApiUrl(_controller.text);
    if (url == null) {
      setState(() => _error = 'Needs an absolute http(s) address with a host.');
      return;
    }
    await ref.read(apiBaseUrlProvider.notifier).set(url);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _reset() async {
    await ref.read(apiBaseUrlProvider.notifier).reset();
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return AlertDialog(
      backgroundColor: ls.backgroundLight,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: ls.border),
        borderRadius: BorderRadius.circular(LsRadius.frame),
      ),
      title: Text(
        'API address',
        style: LsText.drawerName.copyWith(color: ls.purplePrimary),
      ),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Where lazy serve is listening. On draft night that is the '
              'tailnet address.',
              style: LsText.aside.copyWith(color: ls.textSecondary),
            ),
            const SizedBox(height: LsSpacing.md),
            TextField(
              controller: _controller,
              autofocus: true,
              keyboardType: TextInputType.url,
              style: LsText.dataCell.copyWith(color: ls.textPrimary),
              decoration: InputDecoration(
                hintText: lsApiUrlDefault,
                hintStyle: LsText.dataCell.copyWith(color: ls.textSecondary),
                errorText: _error,
                errorStyle: LsText.caption.copyWith(color: ls.errorPrimary),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: ls.border),
                  borderRadius: BorderRadius.circular(LsRadius.card),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ls.border),
                  borderRadius: BorderRadius.circular(LsRadius.card),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ls.purplePrimary),
                  borderRadius: BorderRadius.circular(LsRadius.card),
                ),
                isDense: true,
              ),
              onSubmitted: (_) => _save(),
            ),
            const SizedBox(height: LsSpacing.sm),
            Text(
              'Default: $lsApiUrlDefault',
              style: LsText.caption.copyWith(color: ls.textSecondary),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _reset,
          child: Text(
            'Reset to default',
            style: LsText.button.copyWith(
              fontSize: 13,
              color: ls.textSecondary,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: LsText.button.copyWith(
              fontSize: 13,
              color: ls.textSecondary,
            ),
          ),
        ),
        SecondaryButton(label: 'Save', onPressed: _save),
      ],
    );
  }
}
