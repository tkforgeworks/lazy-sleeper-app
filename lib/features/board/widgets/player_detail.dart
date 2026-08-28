import 'package:flutter/material.dart';

import '../../../api/models/board.dart';
import '../../../app/theme/ls_theme.dart';
import '../../../app/widgets/atoms.dart';
import '../board_view.dart';

/// Player Detail content, shared by the desktop drawer and the mobile sheet.
///
/// Today: header + source projection bars from `components`. The actuals,
/// usage, range, ADP trend, depth chart and news sections need
/// `GET /players/{id}` (LS-58) and render as placeholders until then.
class PlayerDetail extends StatelessWidget {
  const PlayerDetail({super.key, required this.row, required this.onClose});

  final BoardRow row;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final r = row;
    final injury = injuryLabel(r);
    final sleeper = r.components['sleeper'];
    final espn = r.components['espn'];
    final max = [
      sleeper ?? 0,
      espn ?? 0,
      r.points,
    ].reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.name,
                    style: LsText.drawerName.copyWith(color: ls.purplePrimary),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        '${rowSub(r, withBye: true)} · rank ${r.rank}',
                        style: LsText.caption.copyWith(
                          fontSize: 11,
                          color: ls.textSecondary,
                        ),
                      ),
                      if (injury != null) ...[
                        const SizedBox(width: LsSpacing.sm),
                        StatusFlag(injury, severity: FlagSeverity.error),
                      ],
                      if (r.disagree) ...[
                        const SizedBox(width: LsSpacing.xs),
                        StatusFlag(
                          'SPLIT ${splitLabel(r)}',
                          severity: FlagSeverity.warning,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onClose,
              tooltip: 'Close',
              icon: Icon(Icons.close, size: 18, color: ls.textSecondary),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        const SizedBox(height: LsSpacing.lg),
        _SectionLabel('SEASON PROJECTION'),
        const SizedBox(height: LsSpacing.sm),
        SourceProjectionBar(
          label: 'Sleeper',
          color: LsSources.sleeper,
          value: sleeper,
          max: max,
        ),
        const SizedBox(height: 6),
        SourceProjectionBar(
          label: 'ESPN',
          color: LsSources.espn,
          value: espn,
          max: max,
        ),
        const SizedBox(height: 6),
        SourceProjectionBar(
          label: 'ForgeModel',
          color: LsSources.forge,
          value: null,
          max: max,
        ),
        const SizedBox(height: 6),
        SourceProjectionBar(
          label: 'Ensemble',
          color: LsSources.ensemble,
          value: r.points,
          max: max,
        ),
        const SizedBox(height: 6),
        Text(
          'VORP ${fmtPts(r.vorp)} over a ${fmtPts(r.baseline)}-pt ${r.position} baseline'
          '${r.tier == null ? '' : ' · tier ${r.tier}'}'
          '${r.cliff ? ' · cliff after this pick' : ''}',
          style: LsText.caption.copyWith(color: ls.textSecondary),
        ),
        const SizedBox(height: LsSpacing.lg),
        const _Pending(
          title: 'ACTUALS 2023–25',
          aside: 'Three seasons of box scores. Arriving with LS-58.',
        ),
        const _Pending(
          title: 'USAGE · RANGE',
          aside: 'Target share, snaps, floor to ceiling. Also LS-58. Sensing a theme.',
        ),
        const _Pending(
          title: 'ADP TREND · DEPTH CHART',
          aside: 'Where the market is moving and who is in the way. LS-58.',
        ),
        const _Pending(
          title: 'NEWS',
          aside: 'Nothing yet, which for a fantasy player is the good outcome.',
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: LsText.microLabel.copyWith(color: context.ls.textSecondary),
  );
}

class _Pending extends StatelessWidget {
  const _Pending({required this.title, required this.aside});

  final String title;
  final String aside;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Padding(
      padding: const EdgeInsets.only(bottom: LsSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(title),
          const SizedBox(height: 2),
          Text(aside, style: LsText.aside.copyWith(color: ls.textSecondary)),
        ],
      ),
    );
  }
}

/// Desktop: 404 wide, right-anchored, backgroundLight, 1px left border,
/// shadow (-16, 0, 32, rgba(0,0,0,.4)), pad 18×22.
class PlayerDrawer extends StatelessWidget {
  const PlayerDrawer({super.key, required this.row, required this.onClose});

  final BoardRow row;
  final VoidCallback onClose;

  static const width = 404.0;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: ls.backgroundLight,
        border: Border(left: BorderSide(color: ls.border)),
        boxShadow: const [
          BoxShadow(
            offset: Offset(-16, 0),
            blurRadius: 32,
            color: Color(0x66000000),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: PlayerDetail(row: row, onClose: onClose),
      ),
    );
  }
}

/// Mobile: 62%-height sheet, r22 top corners, 38×4 drag handle, scrim
/// rgba(11,17,32,.55), pad 14×20.
Future<void> showPlayerSheet(BuildContext context, BoardRow row) {
  final ls = context.ls;
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: ls.backgroundLight,
    barrierColor: const Color(0x8C0B1120),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(LsRadius.sheet)),
    ),
    builder: (sheetContext) => FractionallySizedBox(
      heightFactor: 0.62,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 38,
            height: 4,
            decoration: BoxDecoration(
              color: ls.border,
              borderRadius: BorderRadius.circular(LsRadius.full),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: PlayerDetail(
                row: row,
                onClose: () => Navigator.of(sheetContext).pop(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
