import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/models/draft.dart';
import '../../app/theme/ls_theme.dart';
import '../../app/widgets/atoms.dart';
import 'draft_live_providers.dart';
import 'draft_runner_providers.dart';

/// Draft Command Center, first slice: control the backend's draft runner
/// from the app instead of curl. The live view over `/draft/{id}/state`
/// lands in increment 2.
class DraftScreen extends ConsumerStatefulWidget {
  const DraftScreen({super.key});

  @override
  ConsumerState<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends ConsumerState<DraftScreen> {
  late final TextEditingController _id;

  @override
  void initState() {
    super.initState();
    _id = TextEditingController(text: ref.read(draftIdProvider));
  }

  @override
  void dispose() {
    _id.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    final id = _id.text.trim();
    if (id.isEmpty) return;
    await ref.read(draftIdProvider.notifier).set(id);
    await ref.read(draftRunnerProvider.notifier).start(id);
    // The poller would catch up on its next tick; no need to wait for it.
    await ref.read(draftLiveProvider.notifier).refresh();
  }

  Future<void> _stop() async {
    final id = _id.text.trim();
    if (id.isEmpty) return;
    await ref.read(draftIdProvider.notifier).set(id);
    await ref.read(draftRunnerProvider.notifier).stop(id);
  }

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final runner = ref.watch(draftRunnerProvider);
    final known = ref.watch(knownDraftsProvider);
    final busy = runner.isLoading;

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.isDesktop ? 24 : LsSpacing.md),
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Draft Command Center',
                style: LsText.drawerName.copyWith(color: ls.textPrimary),
              ),
              const SizedBox(height: LsSpacing.xs),
              Text(
                'The live view arrives with increment 2. Until then: the runner, '
                'without the curl.',
                style: LsText.aside.copyWith(color: ls.textSecondary),
              ),
              const SizedBox(height: LsSpacing.xl),
              _Card(
                title: 'DRAFT RUNNER',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sleeper draft id, from the room URL '
                      '(sleeper.com/draft/nfl/<id>). Start before the room '
                      'opens: the pre-draft load takes a few seconds.',
                      style: LsText.aside.copyWith(color: ls.textSecondary),
                    ),
                    const SizedBox(height: LsSpacing.md),
                    TextField(
                      controller: _id,
                      enabled: !busy,
                      keyboardType: TextInputType.number,
                      style: LsText.dataCell.copyWith(color: ls.textPrimary),
                      decoration: _input(ls, 'draft id'),
                      onSubmitted: (_) => _start(),
                    ),
                    const SizedBox(height: LsSpacing.md),
                    Row(
                      children: [
                        PrimaryButton(
                          label: 'Start runner',
                          onPressed: busy ? null : _start,
                        ),
                        const SizedBox(width: LsSpacing.sm),
                        SecondaryButton(
                          label: 'Stop',
                          onPressed: busy ? null : _stop,
                        ),
                        const SizedBox(width: LsSpacing.md),
                        if (busy)
                          Text(
                            'Talking to the API…',
                            style: LsText.caption.copyWith(
                              color: ls.textSecondary,
                            ),
                          ),
                      ],
                    ),
                    if (runner.value case final outcome?) ...[
                      const SizedBox(height: LsSpacing.md),
                      _Outcome(outcome),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: LsSpacing.lg),
              const _Card(title: 'LIVE STATE', child: _LiveStrip()),
              const SizedBox(height: LsSpacing.lg),
              _Card(
                title: 'KNOWN TO THE API',
                child: known.when(
                  loading: () => Text(
                    'Asking…',
                    style: LsText.caption.copyWith(color: ls.textSecondary),
                  ),
                  error: (e, _) => Text(
                    'Could not list drafts: $e',
                    style: LsText.caption.copyWith(color: ls.errorText),
                  ),
                  data: (drafts) => drafts.isEmpty
                      ? Text(
                          'None yet. The API forgets on restart; start one above.',
                          style: LsText.aside.copyWith(color: ls.textSecondary),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final d in drafts)
                              _KnownDraft(
                                draft: d,
                                onTap: () =>
                                    setState(() => _id.text = d.draftId),
                              ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _input(LsColors ls, String hint) => InputDecoration(
    hintText: hint,
    hintStyle: LsText.dataCell.copyWith(color: ls.textSecondary),
    isDense: true,
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
  );
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ls.backgroundLight,
        border: Border.all(color: ls.border),
        borderRadius: BorderRadius.circular(LsRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: LsText.microLabel.copyWith(color: ls.textSecondary),
          ),
          const SizedBox(height: LsSpacing.sm),
          child,
        ],
      ),
    );
  }
}

class _Outcome extends StatelessWidget {
  const _Outcome(this.outcome);

  final RunnerOutcome outcome;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    switch (outcome) {
      case RunnerStarted(:final result):
        final r = result;
        final slot = r.mySlot == null
            ? 'slot not assigned yet'
            : 'slot ${r.mySlot}';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LiveDot(
              color: r.running ? ls.successPrimary : ls.errorPrimary,
              label: r.alreadyRunning
                  ? 'Runner was already up for ${r.draftId}'
                  : 'Runner up for ${r.draftId}',
            ),
            const SizedBox(height: LsSpacing.xs),
            Text(
              'Season ${r.season} · $slot · ${r.picksMade} picks made · '
              '${r.boardRows} board rows',
              style: LsText.caption.copyWith(color: ls.textSecondary),
            ),
            if (r.mySlot == null) ...[
              const SizedBox(height: LsSpacing.xs),
              Text(
                'Sleeper assigns draft_order late on mocks; the runner picks it '
                'up mid-draft, or set MY_DRAFT_SLOT in the backend .env.',
                style: LsText.aside.copyWith(color: ls.textSecondary),
              ),
            ],
          ],
        );
      case RunnerStopped(:final result):
        return LiveDot(
          color: ls.textSecondary,
          label: 'Runner stopped for ${result.draftId}',
        );
      case RunnerFailed(:final message):
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StatusFlag('FAILED', severity: FlagSeverity.error),
            const SizedBox(width: LsSpacing.sm),
            Expanded(
              child: Text(
                message,
                style: LsText.caption.copyWith(color: ls.errorText),
              ),
            ),
          ],
        );
    }
  }
}

/// First slice of the live view: proves the `/state` poll is up and what
/// it last said. The full Command Center replaces this card.
class _LiveStrip extends ConsumerWidget {
  const _LiveStrip();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ls = context.ls;
    final live = ref.watch(draftLiveProvider);
    final caption = LsText.caption.copyWith(color: ls.textSecondary);
    switch (live.phase) {
      case DraftLivePhase.idle:
        return Text('No draft id yet.', style: caption);
      case DraftLivePhase.connecting:
        return LiveDot(color: ls.warningPrimary, label: 'Polling /state…');
      case DraftLivePhase.notRunning:
        return LiveDot(
          color: ls.textSecondary,
          label: 'Runner not up for this id. Start it above.',
        );
      case DraftLivePhase.live || DraftLivePhase.error:
        final s = live.state;
        final clock = s?.clock;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LiveDot(
              color: live.phase == DraftLivePhase.live
                  ? ls.successPrimary
                  : ls.errorPrimary,
              label: live.phase == DraftLivePhase.live
                  ? 'Live · ${s?.poller.status ?? '—'}'
                  : 'Poll failed; showing the last good state',
            ),
            if (clock != null) ...[
              const SizedBox(height: LsSpacing.xs),
              Text(
                'Pick ${clock.currentPick}'
                '${clock.round == null ? '' : ' · round ${clock.round}'}'
                ' · on the clock: '
                '${clock.onTheClockTeamName ?? 'slot ${clock.onTheClock ?? '—'}'}'
                ' · ${clock.myTurn ? 'YOUR TURN' : '${clock.picksUntilMyTurn ?? '—'} until you'}'
                ' · ${s!.rows.length} rows · seq ${s.recompute.seq}',
                style: caption,
              ),
            ],
            if (live.error case final error?) ...[
              const SizedBox(height: LsSpacing.xs),
              Text(error, style: LsText.caption.copyWith(color: ls.errorText)),
            ],
          ],
        );
    }
  }
}

class _KnownDraft extends StatelessWidget {
  const _KnownDraft({required this.draft, required this.onTap});

  final DraftSummary draft;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            LiveDot(
              color: draft.running ? ls.successPrimary : ls.textSecondary,
              label: draft.draftId,
            ),
            const Spacer(),
            Text(
              draft.running
                  ? 'running · ${draft.season ?? '—'}'
                  : 'stopped · ${draft.season ?? '—'}',
              style: LsText.caption.copyWith(color: ls.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
