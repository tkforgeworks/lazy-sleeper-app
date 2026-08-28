import 'package:flutter/material.dart';

import '../../../api/models/draft_state.dart';
import '../../../app/theme/ls_theme.dart';
import '../../../app/widgets/atoms.dart';
import '../draft_view.dart';

/// Desktop best-available table, `pick_score` order as served: # / TIER /
/// PLAYER / POS / BYE / ENS / VORP / SURVIVAL → next pick / RUN.
class BestAvailableTable extends StatelessWidget {
  const BestAvailableTable({super.key, required this.state});

  final DraftState state;

  static const rowHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final rows = state.rows;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(nextPick: nextPickLabel(state.clock)),
        Expanded(
          child: rows.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(LsSpacing.md),
                  child: Text(
                    'No rows yet. The board arrives with the first recompute.',
                    style: LsText.aside.copyWith(color: ls.textSecondary),
                  ),
                )
              : ListView.builder(
                  itemCount: rows.length,
                  itemExtent: rowHeight,
                  itemBuilder: (context, i) => _Row(row: rows[i], index: i + 1),
                ),
        ),
      ],
    );
  }
}

class _Cols {
  static const index = 34.0;
  static const tier = 46.0;
  static const pos = 44.0;
  static const bye = 42.0;
  static const ens = 60.0;
  static const vorp = 60.0;
  static const survival = 150.0;
  static const run = 40.0;
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
  const _Header({required this.nextPick});

  final String nextPick;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    Text h(String label) =>
        Text(label, style: LsText.microLabel.copyWith(color: ls.textSecondary));
    return Container(
      height: BestAvailableTable.rowHeight,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: ls.border)),
      ),
      child: Row(
        children: [
          _cell(_Cols.index, h('#'), align: Alignment.centerLeft),
          _cell(_Cols.tier, h('TIER'), align: Alignment.centerLeft),
          Expanded(child: h('PLAYER')),
          _cell(_Cols.pos, h('POS'), align: Alignment.centerLeft),
          _cell(_Cols.bye, h('BYE')),
          _cell(_Cols.ens, h('ENS')),
          _cell(_Cols.vorp, h('VORP')),
          _cell(
            _Cols.survival,
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: h('SURVIVAL $nextPick'),
            ),
            align: Alignment.centerLeft,
          ),
          _cell(_Cols.run, h('RUN'), align: Alignment.center),
        ],
      ),
    );
  }
}

class _Row extends StatefulWidget {
  const _Row({required this.row, required this.index});

  final DraftRow row;
  final int index;

  @override
  State<_Row> createState() => _RowState();
}

class _RowState extends State<_Row> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final r = widget.row;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: lsDuration,
        curve: lsCurve,
        decoration: BoxDecoration(
          color: _hover ? ls.rowHover : Colors.transparent,
          border: Border(bottom: BorderSide(color: ls.divider)),
        ),
        child: Row(
          children: [
            _cell(
              _Cols.index,
              Text(
                '${widget.index}',
                style: LsText.caption.copyWith(
                  fontSize: 11,
                  color: ls.textSecondary,
                ),
              ),
              align: Alignment.centerLeft,
            ),
            _cell(_Cols.tier, TierBadge(r.tier), align: Alignment.centerLeft),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Flexible(
                    child: Text(
                      r.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: LsText.rowTitle.copyWith(color: ls.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 7),
                  Text(
                    rowSub(r, withBye: false),
                    style: LsText.caption.copyWith(
                      fontSize: 9.5,
                      color: ls.textSecondary,
                    ),
                  ),
                  if (injuryFlag(r.injuryStatus) case final flag?) ...[
                    const SizedBox(width: 6),
                    StatusFlag(
                      flag,
                      severity: flag == 'Q'
                          ? FlagSeverity.warning
                          : FlagSeverity.error,
                    ),
                  ],
                ],
              ),
            ),
            _cell(_Cols.pos, PosChip(r.position), align: Alignment.centerLeft),
            _cell(
              _Cols.bye,
              Text(
                fmtBye(r.bye),
                style: LsText.dataCell.copyWith(color: ls.textPrimary),
              ),
            ),
            _cell(
              _Cols.ens,
              Text(
                fmtPts(r.points),
                style: LsText.dataCell.copyWith(color: ls.textPrimary),
              ),
            ),
            _cell(
              _Cols.vorp,
              Text(
                fmtPts(r.vorp),
                style: LsText.dataCellBold.copyWith(color: ls.purplePrimary),
              ),
            ),
            _cell(
              _Cols.survival,
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: SurvivalBar(survival: r.survival),
              ),
              align: Alignment.centerLeft,
            ),
            _cell(
              _Cols.run,
              r.run
                  ? const StatusFlag('RUN', severity: FlagSeverity.info)
                  : const SizedBox.shrink(),
              align: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Mobile best-available rows as a sliver: tier + pos / name + sub / VORP /
/// surv %.
class BestAvailableList extends StatelessWidget {
  const BestAvailableList({super.key, required this.state});

  final DraftState state;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final rows = state.rows;
    return SliverList.builder(
      itemCount: rows.length,
      itemBuilder: (context, i) {
        final r = rows[i];
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: LsSpacing.md,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: ls.divider)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 56,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TierBadge(r.tier),
                    const SizedBox(height: 3),
                    PosChip(r.position),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: LsText.rowTitle.copyWith(color: ls.textPrimary),
                    ),
                    Text(
                      rowSub(r),
                      style: LsText.caption.copyWith(
                        fontSize: 9.5,
                        color: ls.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 48,
                child: Text(
                  fmtPts(r.vorp),
                  textAlign: TextAlign.right,
                  style: LsText.dataCellBold.copyWith(color: ls.purplePrimary),
                ),
              ),
              const SizedBox(width: LsSpacing.sm),
              SizedBox(width: 92, child: SurvivalBar(survival: r.survival)),
            ],
          ),
        );
      },
    );
  }
}
