import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../api/providers.dart';
import '../theme/ls_theme.dart';
import '../theme/theme_mode.dart';
import '../widgets/atoms.dart';
import 'app_settings.dart';
import 'logs_dialog.dart';

/// Gear button that opens [SettingsScreen]. Lives in the top nav on desktop
/// and the board toolbar on mobile.
class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: 'Settings',
    onPressed: () => openSettings(context),
    icon: Icon(
      Icons.settings_outlined,
      size: 18,
      color: context.ls.textSecondary,
    ),
    visualDensity: VisualDensity.compact,
  );
}

/// Pushes the Settings screen over the current section; Back returns.
void openSettings(BuildContext context) => context.push(SettingsScreen.path);

/// Everything tunable, applied live and saved across launches: the API
/// address, draft-night cadence and thresholds, alerts, theme, log level.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  static const path = '/settings';

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController _url;
  String? _urlError;

  @override
  void initState() {
    super.initState();
    _url = TextEditingController(text: ref.read(apiBaseUrlProvider));
  }

  @override
  void dispose() {
    _url.dispose();
    super.dispose();
  }

  Future<void> _saveUrl() async {
    final url = normalizeApiUrl(_url.text);
    if (url == null) {
      setState(
        () => _urlError = 'Needs an absolute http(s) address with a host.',
      );
      return;
    }
    await ref.read(apiBaseUrlProvider.notifier).set(url);
    if (mounted) setState(() => _urlError = null);
  }

  Future<void> _defaultUrl() async {
    await ref.read(apiBaseUrlProvider.notifier).reset();
    if (mounted) setState(() => _urlError = null);
  }

  Future<void> _resetAll() async {
    await ref.read(appSettingsProvider.notifier).resetAll();
    await ref.read(themeModeProvider.notifier).reset();
    await _defaultUrl();
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/board');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final s = ref.watch(appSettingsProvider);
    final theme = ref.watch(themeModeProvider);
    // The field follows the saved address (Save, Use default, Reset), but
    // never clobbers text being typed.
    ref.listen(apiBaseUrlProvider, (_, url) {
      if (_url.text != url) _url.text = url;
    });

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.isDesktop ? 24 : LsSpacing.md),
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    tooltip: 'Back',
                    onPressed: _back,
                    icon: Icon(Icons.arrow_back, color: ls.textSecondary),
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: LsSpacing.xs),
                  Text(
                    'Settings',
                    style: LsText.drawerName.copyWith(color: ls.purplePrimary),
                  ),
                ],
              ),
              const SizedBox(height: LsSpacing.md),
              _Section(
                title: 'CONNECTION',
                children: [
                  _SettingRow(
                    label: 'API address',
                    hint:
                        'Where lazy serve is listening. Default: $lsApiUrlDefault',
                    stacked: true,
                    fit: false,
                    child: _UrlField(
                      controller: _url,
                      error: _urlError,
                      onSave: _saveUrl,
                      onDefault: _defaultUrl,
                    ),
                  ),
                ],
              ),
              _Section(
                title: 'DRAFT',
                children: [
                  _SettingRow(
                    label: 'Poll interval',
                    hint:
                        'How often /state is read while the runner is up. '
                        'Faster shows a new pick sooner; the clock ticks '
                        'locally either way.',
                    child: SegmentedTabs<int>(
                      values: AppSettings.pollIntervalChoices,
                      selected: s.pollIntervalS,
                      label: (v) => '$v s',
                      onSelect: (v) => ref
                          .read(appSettingsProvider.notifier)
                          .setPollInterval(v),
                    ),
                  ),
                  _SettingRow(
                    label: 'Panic threshold',
                    hint:
                        'At your turn, the overlay fires with this much '
                        'time left. It only highlights — the pick is made '
                        'in Sleeper.',
                    child: SegmentedTabs<int>(
                      values: AppSettings.panicThresholdChoices,
                      selected: s.panicThresholdS,
                      label: (v) => '$v s',
                      onSelect: (v) => ref
                          .read(appSettingsProvider.notifier)
                          .setPanicThreshold(v),
                    ),
                  ),
                  _SettingRow(
                    label: 'Best-available rows',
                    hint: 'How deep the table goes; alerts read the top 12.',
                    child: SegmentedTabs<int>(
                      values: AppSettings.rowLimitChoices,
                      selected: s.rowLimit,
                      label: (v) => '$v',
                      onSelect: (v) =>
                          ref.read(appSettingsProvider.notifier).setRowLimit(v),
                    ),
                  ),
                ],
              ),
              _Section(
                title: 'ALERTS',
                children: [
                  for (final kind in AlertKind.values)
                    _SettingRow(
                      label: kind.label,
                      hint: kind.hint,
                      child: Switch(
                        key: Key('setting.alert.${kind.name}'),
                        value: s.alerts.contains(kind),
                        onChanged: (on) => ref
                            .read(appSettingsProvider.notifier)
                            .setAlert(kind, on),
                      ),
                    ),
                ],
              ),
              _Section(
                title: 'APPEARANCE',
                children: [
                  _SettingRow(
                    label: 'Theme',
                    hint: 'Dark is the design target; System follows the OS.',
                    child: SegmentedTabs<ThemeMode>(
                      values: const [
                        ThemeMode.dark,
                        ThemeMode.light,
                        ThemeMode.system,
                      ],
                      selected: theme,
                      label: themeLabel,
                      onSelect: (m) =>
                          ref.read(themeModeProvider.notifier).set(m),
                    ),
                  ),
                ],
              ),
              _Section(
                title: 'LOGGING',
                children: [
                  _SettingRow(
                    label: 'Verbose log',
                    hint:
                        'FINE level: request and response bodies. Off is '
                        'INFO, one line per request.',
                    child: Switch(
                      key: const Key('setting.verbose'),
                      value: s.verboseLog,
                      onChanged: (on) => ref
                          .read(appSettingsProvider.notifier)
                          .setVerboseLog(on),
                    ),
                  ),
                  _SettingRow(
                    label: 'Session log',
                    hint: 'Live tail with copy and save.',
                    child: SecondaryButton(
                      label: 'Open logs',
                      onPressed: () => showLogsDialog(context),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SecondaryButton(
                    label: 'Reset to defaults',
                    onPressed: _resetAll,
                  ),
                  const SizedBox(width: LsSpacing.md),
                  Expanded(
                    child: Text(
                      'Every setting above, the API address and the theme.',
                      style: LsText.caption.copyWith(color: ls.textSecondary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String themeLabel(ThemeMode m) => switch (m) {
  ThemeMode.dark => 'Dark',
  ThemeMode.light => 'Light',
  ThemeMode.system => 'System',
};

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Padding(
      padding: const EdgeInsets.only(bottom: LsSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: LsText.microLabel.copyWith(color: ls.textSecondary),
          ),
          const SizedBox(height: LsSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: LsSpacing.lg),
            decoration: BoxDecoration(
              color: ls.backgroundLight,
              border: Border.all(color: ls.border),
              borderRadius: BorderRadius.circular(LsRadius.card),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < children.length; i++) ...[
                  if (i > 0) Divider(height: 1, color: ls.divider),
                  children[i],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Label and hint on the left, the control on the right; stacked on a
/// phone or when [stacked] (wide controls). A stacked control shrinks to
/// the width it has unless [fit] is off (text fields need a real width).
class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.label,
    required this.hint,
    required this.child,
    this.stacked = false,
    this.fit = true,
  });

  final String label;
  final String hint;
  final Widget child;
  final bool stacked;
  final bool fit;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: LsText.rowTitle.copyWith(color: ls.textPrimary)),
        const SizedBox(height: 2),
        Text(hint, style: LsText.caption.copyWith(color: ls.textSecondary)),
      ],
    );
    final stack = stacked || !context.isDesktop;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: LsSpacing.md),
      child: stack
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text,
                const SizedBox(height: LsSpacing.sm),
                if (fit)
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: child,
                  )
                else
                  child,
              ],
            )
          : Row(
              children: [
                Expanded(child: text),
                const SizedBox(width: LsSpacing.lg),
                child,
              ],
            ),
    );
  }
}

class _UrlField extends StatelessWidget {
  const _UrlField({
    required this.controller,
    required this.error,
    required this.onSave,
    required this.onDefault,
  });

  final TextEditingController controller;
  final String? error;
  final VoidCallback onSave;
  final VoidCallback onDefault;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(LsRadius.card),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          key: const Key('setting.api_url'),
          controller: controller,
          keyboardType: TextInputType.url,
          style: LsText.dataCell.copyWith(color: ls.textPrimary),
          decoration: InputDecoration(
            hintText: lsApiUrlDefault,
            hintStyle: LsText.dataCell.copyWith(color: ls.textSecondary),
            errorText: error,
            errorStyle: LsText.caption.copyWith(color: ls.errorPrimary),
            border: border(ls.border),
            enabledBorder: border(ls.border),
            focusedBorder: border(ls.purplePrimary),
            isDense: true,
          ),
          onSubmitted: (_) => onSave(),
        ),
        const SizedBox(height: LsSpacing.sm),
        Row(
          children: [
            SecondaryButton(label: 'Save', onPressed: onSave),
            const SizedBox(width: LsSpacing.sm),
            TextButton(
              onPressed: onDefault,
              child: Text(
                'Use default',
                style: LsText.button.copyWith(
                  fontSize: 13,
                  color: ls.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
