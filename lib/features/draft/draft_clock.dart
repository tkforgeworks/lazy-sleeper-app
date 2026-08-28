import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/models/draft_state.dart';

/// Wall clock source; tests override it to drive the countdown.
final nowProvider = Provider<DateTime Function()>((_) => DateTime.now);

/// Ticks once a second while anything watches it: the one exemption from
/// the `recompute.seq` redraw rule (GUIDE Workflow 1). The deadline itself
/// only moves with `current_pick`, so the countdown is deadline − now.
class ClockTicker extends Notifier<DateTime> {
  Timer? _timer;

  @override
  DateTime build() {
    final now = ref.watch(nowProvider);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (ref.mounted) state = now();
    });
    ref.onDispose(() => _timer?.cancel());
    return now();
  }
}

final clockNowProvider = NotifierProvider<ClockTicker, DateTime>(
  ClockTicker.new,
);

/// Whole seconds left on the current pick, floored at 0; null when the
/// draft has no timer or the start of the pick is unknown.
int? secondsRemaining(DraftClock clock, DateTime now) {
  final deadline = clock.pickDeadline;
  if (deadline == null || clock.complete) return null;
  final left = deadline.difference(now.toUtc()).inMilliseconds;
  return left <= 0 ? 0 : (left / 1000).ceil();
}

enum TimerTone { calm, warning, error }

/// textPrimary above 20 s, warning at 20 and under, error at 10 and under.
TimerTone timerTone(int seconds) => seconds <= 10
    ? TimerTone.error
    : seconds <= 20
    ? TimerTone.warning
    : TimerTone.calm;

/// Remaining fraction of the pick timer for the progress bar; null when
/// there is nothing to measure against.
double? timerFraction(DraftClock clock, int? seconds) {
  final total = clock.pickTimerS;
  if (seconds == null || total == null || total <= 0) return null;
  return (seconds / total).clamp(0, 1).toDouble();
}

/// Panic threshold from the handoff: my turn and 30 s or less (the
/// Settings screen can move it). A null countdown never panics — no timer,
/// no pressure.
const panicThresholdS = 30;

bool isPanic(
  DraftClock clock,
  int? seconds, {
  int threshold = panicThresholdS,
}) => clock.myTurn && seconds != null && seconds <= threshold;

/// Which pick the user has waved the panic overlay away for; it comes
/// back with the next pick.
class PanicDismissed extends Notifier<int?> {
  @override
  int? build() => null;

  void dismiss(int currentPick) => state = currentPick;
}

final panicDismissedProvider = NotifierProvider<PanicDismissed, int?>(
  PanicDismissed.new,
);
