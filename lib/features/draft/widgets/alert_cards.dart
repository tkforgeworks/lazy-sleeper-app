import 'package:flutter/material.dart';

import '../../../app/theme/ls_theme.dart';
import '../draft_view.dart';

/// Semantic light bg + 1px semantic border + semantic text, r8, pad 9×12.
/// Title Pop 600/11, body SS4 11.5/1.45.
class AlertCard extends StatelessWidget {
  const AlertCard({super.key, required this.alert});

  final DraftAlert alert;

  @override
  Widget build(BuildContext context) {
    final (bg, border, fg) = alertColors(context.ls, alert.severity);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(LsRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            alert.title,
            style: LsText.rowTitle.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            alert.body,
            style: LsText.aside.copyWith(
              fontSize: 11.5,
              fontStyle: FontStyle.normal,
              height: 1.45,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

/// Mobile: title-only capsule.
class AlertChip extends StatelessWidget {
  const AlertChip({super.key, required this.alert});

  final DraftAlert alert;

  @override
  Widget build(BuildContext context) {
    final (bg, border, fg) = alertColors(context.ls, alert.severity);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        alert.title,
        style: LsText.rowTitle.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}

(Color, Color, Color) alertColors(
  LsColors ls,
  AlertSeverity severity,
) => switch (severity) {
  AlertSeverity.warning => (ls.warningLight, ls.warningPrimary, ls.warningText),
  AlertSeverity.info => (ls.infoLight, ls.infoPrimary, ls.infoText),
  AlertSeverity.success => (ls.successLight, ls.successPrimary, ls.successText),
  AlertSeverity.error => (ls.errorLight, ls.errorPrimary, ls.errorText),
};

/// The rail's ALERTS block: cards, or a one-liner when nothing is firing.
class AlertsBlock extends StatelessWidget {
  const AlertsBlock({super.key, required this.alerts});

  final List<DraftAlert> alerts;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ALERTS',
          style: LsText.microLabel.copyWith(color: ls.textSecondary),
        ),
        const SizedBox(height: LsSpacing.sm),
        if (alerts.isEmpty)
          Text(
            'Nothing is on fire. Enjoy it.',
            style: LsText.aside.copyWith(fontSize: 12, color: ls.textSecondary),
          ),
        for (final a in alerts)
          Padding(
            padding: const EdgeInsets.only(bottom: LsSpacing.sm),
            child: AlertCard(alert: a),
          ),
      ],
    );
  }
}
