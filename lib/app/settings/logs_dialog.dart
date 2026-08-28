import 'dart:convert';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../log/app_log.dart';
import '../theme/ls_theme.dart';
import '../widgets/atoms.dart';

/// Opens [LogsDialog]. Sits next to the API-address gear.
class LogsButton extends StatelessWidget {
  const LogsButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: 'Logs',
    onPressed: () => showLogsDialog(context),
    icon: Icon(
      Icons.receipt_long_outlined,
      size: 18,
      color: context.ls.textSecondary,
    ),
    visualDensity: VisualDensity.compact,
  );
}

Future<void> showLogsDialog(BuildContext context) =>
    showDialog<void>(context: context, builder: (_) => const LogsDialog());

/// Live tail of the app log with copy, save-to-file, and a verbose toggle
/// (request/response bodies). For live tests alongside the backend log.
class LogsDialog extends ConsumerStatefulWidget {
  const LogsDialog({super.key});

  /// Lines shown in the tail; the export always carries the whole buffer.
  static const tailLines = 300;

  @override
  ConsumerState<LogsDialog> createState() => _LogsDialogState();
}

class _LogsDialogState extends ConsumerState<LogsDialog> {
  static final _log = Logger('app');

  String? _notice;

  Future<void> _copy() async {
    final log = ref.read(appLogProvider);
    await Clipboard.setData(ClipboardData(text: log.export()));
    if (mounted) setState(() => _notice = 'Copied ${log.length} lines.');
  }

  Future<void> _save() async {
    final log = ref.read(appLogProvider);
    final stamp = AppLog.formatTimestamp(DateTime.now())
        .replaceAll(RegExp(r'[^0-9]'), '');
    final name = 'lazy-sleeper-app-$stamp.log';
    try {
      final location = await getSaveLocation(
        suggestedName: name,
        acceptedTypeGroups: const [
          XTypeGroup(label: 'Log', extensions: ['log', 'txt']),
        ],
      );
      if (location == null) return;
      await XFile.fromData(
        utf8.encode(log.export()),
        mimeType: 'text/plain',
        name: name,
      ).saveTo(location.path);
      _log.info('log saved to ${location.path}');
      if (mounted) setState(() => _notice = 'Saved to ${location.path}');
    } on Object catch (e, s) {
      _log.warning('log save failed', e, s);
      if (mounted) setState(() => _notice = 'Save failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final log = ref.watch(appLogProvider);
    final buttonStyle = LsText.button.copyWith(
      fontSize: 13,
      color: ls.textSecondary,
    );
    return AlertDialog(
      backgroundColor: ls.backgroundLight,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: ls.border),
        borderRadius: BorderRadius.circular(LsRadius.frame),
      ),
      title: Text(
        'Logs',
        style: LsText.drawerName.copyWith(color: ls.purplePrimary),
      ),
      content: SizedBox(
        width: 720,
        child: ListenableBuilder(
          listenable: log,
          builder: (context, _) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                log.sink?.location == null
                    ? 'In memory only on this platform; copy or save to keep it.'
                    : 'Writing to ${log.sink!.location}',
                style: LsText.aside.copyWith(color: ls.textSecondary),
              ),
              const SizedBox(height: LsSpacing.sm),
              Row(
                children: [
                  Text(
                    '${log.length} lines · level ${log.level.name}',
                    style: LsText.caption.copyWith(color: ls.textSecondary),
                  ),
                  const Spacer(),
                  Text(
                    'Verbose (bodies)',
                    style: LsText.caption.copyWith(color: ls.textSecondary),
                  ),
                  const SizedBox(width: LsSpacing.xs),
                  Switch(
                    value: log.verbose,
                    onChanged: (on) => log.verbose = on,
                  ),
                ],
              ),
              const SizedBox(height: LsSpacing.sm),
              Container(
                height: 320,
                padding: const EdgeInsets.all(LsSpacing.sm),
                decoration: BoxDecoration(
                  color: ls.background,
                  border: Border.all(color: ls.border),
                  borderRadius: BorderRadius.circular(LsRadius.card),
                ),
                child: _LogTail(lines: log.lines),
              ),
              if (_notice != null) ...[
                const SizedBox(height: LsSpacing.sm),
                Text(
                  _notice!,
                  style: LsText.caption.copyWith(color: ls.textSecondary),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: log.clear,
          child: Text('Clear', style: buttonStyle),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close', style: buttonStyle),
        ),
        TextButton(
          onPressed: _copy,
          child: Text('Copy', style: buttonStyle),
        ),
        if (!kIsWeb) SecondaryButton(label: 'Save…', onPressed: _save),
      ],
    );
  }
}

/// Newest line at the bottom, scrolled there by default (reverse list).
class _LogTail extends StatelessWidget {
  const _LogTail({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final shown = lines.length > LogsDialog.tailLines
        ? lines.sublist(lines.length - LogsDialog.tailLines)
        : lines;
    if (shown.isEmpty) {
      return Text(
        'Nothing logged yet.',
        style: LsText.caption.copyWith(color: ls.textSecondary),
      );
    }
    final style = LsText.dataCell.copyWith(
      fontSize: 11,
      height: 1.4,
      color: ls.textPrimary,
    );
    return ListView.builder(
      reverse: true,
      itemCount: shown.length,
      itemBuilder: (context, i) =>
          Text(shown[shown.length - 1 - i], style: style),
    );
  }
}
