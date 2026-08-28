import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/models/draft_state.dart';
import '../../app/theme/ls_theme.dart';
import '../../app/widgets/atoms.dart';
import 'draft_clock.dart';
import 'draft_live_providers.dart';
import 'draft_view.dart';
import 'widgets/alert_cards.dart';
import 'widgets/best_available.dart';
import 'widgets/draft_header.dart';
import 'widgets/draft_runner_card.dart';
import 'widgets/panic_overlay.dart';
import 'widgets/pick_ticker.dart';
import 'widgets/recommendation_card.dart';
import 'widgets/roster_strip.dart';
import 'widgets/timer_block.dart';

/// Draft Command Center: everything glanceable on draft night, zero
/// navigation. Read-only — picks are made in the Sleeper app.
///
/// Until `/state` has answered for the remembered id, the screen is the
/// runner setup (id + start). Once there is a state it stays on screen;
/// poll failures only change the health dot. The runner controls move to
/// a dialog behind the header's `runner` button.
class DraftScreen extends ConsumerWidget {
  const DraftScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final live = ref.watch(draftLiveProvider);
    final state = live.state;
    if (state == null) return _Setup(live: live);
    final compact = !context.isDesktop;
    final body = compact
        ? _Mobile(state: state, live: live)
        : _Desktop(state: state, live: live);
    return Stack(
      fit: StackFit.expand,
      children: [
        body,
        _PanicGate(state: state, compact: compact),
      ],
    );
  }
}

/// Shows [PanicOverlay] at my turn with 30 s or less, unless it was
/// dismissed for this pick. Watches the clock only while the draft has a
/// deadline to count down.
class _PanicGate extends ConsumerWidget {
  const _PanicGate({required this.state, required this.compact});

  final DraftState state;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clock = state.clock;
    if (!clock.myTurn || clock.pickDeadline == null) {
      return const SizedBox.shrink();
    }
    final seconds = secondsRemaining(clock, ref.watch(clockNowProvider));
    final dismissed = ref.watch(panicDismissedProvider) == clock.currentPick;
    if (dismissed || !isPanic(clock, seconds)) return const SizedBox.shrink();
    return PanicOverlay(
      state: state,
      seconds: seconds!,
      compact: compact,
      onDismiss: () =>
          ref.read(panicDismissedProvider.notifier).dismiss(clock.currentPick),
    );
  }
}

class _Setup extends StatelessWidget {
  const _Setup({required this.live});

  final DraftLive live;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final hint = switch (live.phase) {
      DraftLivePhase.idle => 'Give it a draft id and start the runner.',
      DraftLivePhase.connecting => 'Polling /state…',
      DraftLivePhase.notRunning => 'Runner not up for this id. Start it below.',
      DraftLivePhase.error =>
        'Could not reach /state: ${live.error ?? 'unknown error'}',
      DraftLivePhase.live || DraftLivePhase.stopped => '',
    };
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
                'Zero navigation once the runner is up. Picks are still made '
                'in Sleeper; this screen only tells you which one.',
                style: LsText.aside.copyWith(color: ls.textSecondary),
              ),
              const SizedBox(height: LsSpacing.sm),
              LiveDot(
                color: switch (live.phase) {
                  DraftLivePhase.error => ls.errorPrimary,
                  DraftLivePhase.connecting => ls.warningPrimary,
                  _ => ls.textSecondary,
                },
                label: hint,
              ),
              const SizedBox(height: LsSpacing.xl),
              const DraftRunnerPanel(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderTrailing extends StatelessWidget {
  const _HeaderTrailing({required this.state, required this.phase});

  final DraftState state;
  final DraftLivePhase phase;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      PollHealthDot(state: state, phase: phase),
      const SizedBox(width: LsSpacing.sm),
      TextButton(
        onPressed: () => showRunnerDialog(context),
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'runner',
          style: LsText.caption.copyWith(color: context.ls.purplePrimary),
        ),
      ),
    ],
  );
}

/// One line under the header when the advice should be read with care.
class _Notice extends StatelessWidget {
  const _Notice({required this.state, required this.live});

  final DraftState state;
  final DraftLive live;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    final error = live.error;
    final text = live.phase == DraftLivePhase.error && error != null
        ? 'Last poll failed ($error). Retrying with back-off; showing the '
              'last good state.'
        : live.phase == DraftLivePhase.stopped && !state.clock.complete
        ? 'The runner for this draft is stopped; polling is paused. Start it '
              'again from the runner button.'
        : state.recompute.error != null || state.recompute.stale
        ? 'Advice is from before the latest pick: '
              '${state.recompute.error ?? 'recompute stale'}.'
        : state.poller.runnerError != null
        ? 'Runner stopped: ${state.poller.runnerError}.'
        : null;
    if (text == null) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      color: ls.warningLight,
      child: Text(text, style: LsText.caption.copyWith(color: ls.warningText)),
    );
  }
}

class _Desktop extends StatelessWidget {
  const _Desktop({required this.state, required this.live});

  final DraftState state;
  final DraftLive live;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Column(
      children: [
        DraftHeader(
          state: state,
          center: TimerBlock(clock: state.clock),
          trailing: _HeaderTrailing(state: state, phase: live.phase),
        ),
        _Notice(state: state, live: live),
        RosterStrip(roster: state.myRoster),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: ls.border)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RecommendationCard(state: state),
                      const SizedBox(height: LsSpacing.md),
                      Expanded(child: BestAvailableTable(state: state)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 316,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AlertsBlock(alerts: alertsFor(state)),
                      const SizedBox(height: LsSpacing.md),
                      PickTicker(
                        picks: state.recentPicks,
                        mySlot: state.clock.mySlot,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Mobile extends StatelessWidget {
  const _Mobile({required this.state, required this.live});

  final DraftState state;
  final DraftLive live;

  @override
  Widget build(BuildContext context) {
    final ls = context.ls;
    return Column(
      children: [
        DraftHeader(
          state: state,
          compact: true,
          center: TimerBlock(clock: state.clock, compact: true),
          trailing: _HeaderTrailing(state: state, phase: live.phase),
        ),
        _Notice(state: state, live: live),
        RosterStrip(roster: state.myRoster),
        Expanded(
          child: CustomScrollView(
            slivers: [
              if (alertsFor(state) case final alerts when alerts.isNotEmpty)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                      children: [
                        for (final a in alerts)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: AlertChip(alert: a),
                          ),
                      ],
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: RecommendationCard(state: state, compact: true),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                  child: Text(
                    'BEST AVAILABLE',
                    style: LsText.microLabel.copyWith(color: ls.textSecondary),
                  ),
                ),
              ),
              BestAvailableList(state: state),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(LsSpacing.md),
                  child: PickTicker(
                    picks: state.recentPicks,
                    mySlot: state.clock.mySlot,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
