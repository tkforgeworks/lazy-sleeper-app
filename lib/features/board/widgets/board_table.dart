import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/models/board.dart';
import '../../../app/theme/ls_theme.dart';
import '../../../app/widgets/atoms.dart';
import '../board_providers.dart';
import '../board_view.dart';

/// Desktop 13-column grid: header, rows with tier breaks (ensemble sort
/// only), footer strip. Column widths from the handoff; the player column
/// takes the rest.
class BoardTable extends ConsumerWidget {
  const BoardTable({super.key, required this.meta, required this.onOpen});

  final BoardMeta meta;
  final ValueChanged<BoardRow> onOpen;

  static const _rowHeight = 29.0;
  static const _hPad = 18.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rows = ref.watch(visibleRowsProvider);
    final sort = ref.watch(boardSortProvider);
    final selected = ref.watch(selectedRowProvider);
    // Tiers are positional (RB T1, WR T1, ...), so breaks only make sense
    // once a position is filtered; on ALL they would fire on nearly every row.
    final position = ref.watch(positionFilterProvider);
    final lines = sort == BoardSort.ensemble && position != null
        ? withTierBreaks(rows)
        : [for (final r in rows) PlayerLine(r)];

    return Column(
      children: [
        _Header(sort: sort),
        Expanded(
          child: ListView.builder(
            itemCount: lines.length,
            itemExtent: null,
            itemBuilder: (context, i) => switch (lines[i]) {
              TierBreakLine(:final tier, :final note) => _TierBreak(
                tier: tier,
                note: note,
              ),
              PlayerLine(:final row) => _PlayerRow(
                row: row,
                selected: row.sleeperId == selected?.sleeperId,
                onTap: () => onOpen(row),
              ),
            },
          ),
        ),
        _Footer(meta: meta),
      ],
    );
  }
}

/// Column widths: # 40 / player flex / pos 46 / bye 42 / SLPR 60 / ESPN 60 /
/// FORGE 62 / ENS 68 / VORP 58 / TIER 46 / ADP 56 / ΔADP 56 / FLAGS 148.
class _Cols {
  static const rank = 40.0;
  static const pos = 46.0;
  static const bye = 42.0;
  static const slpr = 60.0;
  static const espn = 60.0;
  static const forge = 62.0;
  static const ens = 68.0;
  static const vorp = 58.0;
  static const tier = 46.0;
  static const adp = 56.0;
  static const dAdp = 56.0;
  static const flags = 148.0;
}

Widget _cell(
  double width,
  Widget child, {
  Alignment align = Alignment.centerRight,
}) => SizedBox(
  width: width,
  child: Align(alignment: align, child: child),
);

class _Header extends StatelessWidget {
  const _Header({required this.sort});

  final BoardSort sort;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    Text h(String label, {BoardSort? tints}) => Text(
      label,
      style: LsText.microLabel.copyWith(
        color: tints != null && tints == sort
            ? ls.purplePrimary
            : ls.textSecondary,
      ),
    );
    return Container(
      height: BoardTable._rowHeight,
      padding: const EdgeInsets.symmetric(horizontal: BoardTable._hPad),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: ls.border)),
      ),
      child: Row(
        children: [
          _cell(_Cols.rank, h('#'), align: Alignment.centerLeft),
          Expanded(child: h('PLAYER')),
          _cell(_Cols.pos, h('POS'), align: Alignment.center),
          _cell(_Cols.bye, h('BYE')),
          _cell(_Cols.slpr, h('SLPR', tints: BoardSort.sleeper)),
          _cell(_Cols.espn, h('ESPN', tints: BoardSort.espn)),
          _cell(_Cols.forge, h('FORGE', tints: BoardSort.forge)),
          _cell(_Cols.ens, h('ENS', tints: BoardSort.ensemble)),
          _cell(_Cols.vorp, h('VORP')),
          _cell(_Cols.tier, h('TIER'), align: Alignment.center),
          _cell(_Cols.adp, h('ADP', tints: BoardSort.adp)),
          _cell(_Cols.dAdp, h('ΔADP')),
          _cell(
            _Cols.flags,
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: h('FLAGS'),
            ),
            align: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }
}

class _PlayerRow extends StatefulWidget {
  const _PlayerRow({
    required this.row,
    required this.selected,
    required this.onTap,
  });

  final BoardRow row;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_PlayerRow> createState() => _PlayerRowState();
}

class _PlayerRowState extends State<_PlayerRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final r = widget.row;
    final num = LsText.dataCell.copyWith(color: ls.textPrimary);
    final injury = injuryLabel(r);

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
          height: BoardTable._rowHeight,
          padding: const EdgeInsets.symmetric(horizontal: BoardTable._hPad),
          decoration: BoxDecoration(
            color: _hover || widget.selected ? ls.rowHover : Colors.transparent,
            border: Border(bottom: BorderSide(color: ls.divider)),
          ),
          child: Row(
            children: [
              _cell(
                _Cols.rank,
                Text(
                  '${r.rank}',
                  style: LsText.dataCell.copyWith(color: ls.textSecondary),
                ),
                align: Alignment.centerLeft,
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      r.name,
                      overflow: TextOverflow.ellipsis,
                      style: LsText.rowTitle.copyWith(color: ls.textPrimary),
                    ),
                    const SizedBox(width: LsSpacing.sm),
                    Text(
                      rowSub(r),
                      style: LsText.caption.copyWith(
                        fontSize: 10,
                        color: ls.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              _cell(_Cols.pos, PosChip(r.position), align: Alignment.center),
              _cell(_Cols.bye, Text(fmtBye(r.bye), style: num)),
              _cell(
                _Cols.slpr,
                Text(fmtPts(r.components['sleeper']), style: num),
              ),
              _cell(_Cols.espn, Text(fmtPts(r.components['espn']), style: num)),
              _cell(
                _Cols.forge,
                Text(dash, style: num.copyWith(color: ls.forgeOrange)),
              ),
              _cell(
                _Cols.ens,
                Text(
                  fmtPts(r.points),
                  style: LsText.dataCellBold.copyWith(color: ls.textPrimary),
                ),
              ),
              _cell(
                _Cols.vorp,
                Text(
                  fmtPts(r.vorp),
                  style: LsText.dataCellBold.copyWith(color: ls.purplePrimary),
                ),
              ),
              _cell(_Cols.tier, TierBadge(r.tier), align: Alignment.center),
              _cell(_Cols.adp, Text(fmtAdp(r.adp), style: num)),
              _cell(
                _Cols.dAdp,
                DeltaText(value: r.adpDelta, label: fmtDelta(r.adpDelta)),
              ),
              _cell(
                _Cols.flags,
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  // A wide SPLIT plus an injury flag can exceed the column;
                  // shrink both a touch rather than overflow.
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (r.disagree) ...[
                          StatusFlag(
                            'SPLIT ${splitLabel(r)}',
                            severity: FlagSeverity.warning,
                          ),
                          const SizedBox(width: LsSpacing.xs),
                        ],
                        if (injury != null)
                          StatusFlag(injury, severity: FlagSeverity.error),
                      ],
                    ),
                  ),
                ),
                align: Alignment.centerLeft,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// JBM 600/10 +10% tier colour + 1px rule + gap note right. Pad 8,18,3.
class _TierBreak extends StatelessWidget {
  const _TierBreak({required this.tier, required this.note});

  final int tier;
  final String note;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final color = LsTiers.of(tier);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        BoardTable._hPad,
        8,
        BoardTable._hPad,
        3,
      ),
      child: Row(
        children: [
          Text(
            'TIER $tier',
            style: LsText.microLabel.copyWith(letterSpacing: 1, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(height: 1, color: color.withValues(alpha: 0.5)),
          ),
          const SizedBox(width: 10),
          Text(
            note,
            style: LsText.caption.copyWith(
              fontSize: 10,
              color: ls.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Ensemble formula + ΔADP legend, JBM 10.5 secondary.
class _Footer extends StatelessWidget {
  const _Footer({required this.meta});

  final BoardMeta meta;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final built = meta.generatedAt.toUtc();
    final stamp =
        '${built.year}-${built.month.toString().padLeft(2, '0')}-${built.day.toString().padLeft(2, '0')} '
        '${built.hour.toString().padLeft(2, '0')}:${built.minute.toString().padLeft(2, '0')}Z';
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BoardTable._hPad,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: ls.border)),
      ),
      child: Row(
        children: [
          Text(
            'ENS = ${meta.provider} board (${meta.baseline} baseline) · built $stamp',
            style: LsText.caption.copyWith(color: ls.textSecondary),
          ),
          const Spacer(),
          Text(
            'ΔADP  + falls to you (value)  − you\'d be reaching',
            style: LsText.caption.copyWith(color: ls.textSecondary),
          ),
        ],
      ),
    );
  }
}
