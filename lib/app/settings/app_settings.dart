// Persisted, user-tunable settings. One immutable value object, one
// notifier that reads it from SharedPreferences and writes each change
// back, and narrow derived providers so a screen watching the poll
// interval does not rebuild when a theme toggle flips.
//
// The API address and the theme keep their own notifiers
// (`apiBaseUrlProvider`, `themeModeProvider`); the Settings screen's
// "Reset to defaults" resets all three.

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../log/app_log.dart';
import '../prefs.dart';

final _log = Logger('settings');

/// The four Command Center alerts, each switchable on its own.
enum AlertKind {
  cliff('Tier cliff', 'The last player of a tier is on the board.'),
  run('Position run', 'Several of one position went in the last few picks.'),
  value('Value faller', 'A player is still there well past their ADP.'),
  injury('Injury watch', 'A top-ranked player carries an injury status.');

  const AlertKind(this.label, this.hint);

  final String label;
  final String hint;
}

const allAlerts = {
  AlertKind.cliff,
  AlertKind.run,
  AlertKind.value,
  AlertKind.injury,
};

@immutable
class AppSettings {
  const AppSettings({
    this.pollIntervalS = defaultPollIntervalS,
    this.panicThresholdS = defaultPanicThresholdS,
    this.rowLimit = defaultRowLimit,
    this.alerts = allAlerts,
    this.verboseLog = false,
  });

  /// Every default, including the build-time log level (which cannot be a
  /// const constructor default).
  factory AppSettings.defaults() => AppSettings(verboseLog: defaultVerboseLog);

  /// Seconds between `/state` polls while the runner is up. The GUIDE's
  /// ~2 s is the default; 1 s is allowed because `/state` is a read of the
  /// runner's last recompute, not a Sleeper call — it only shortens how
  /// long a new pick takes to reach the screen.
  final int pollIntervalS;
  static const defaultPollIntervalS = 2;
  static const pollIntervalChoices = [1, 2, 3, 4, 5];

  /// Panic overlay at my turn with this many seconds or fewer left.
  final int panicThresholdS;
  static const defaultPanicThresholdS = 30;
  static const panicThresholdChoices = [10, 15, 20, 30, 45, 60];

  /// Rows requested per poll: how deep the best-available table goes.
  final int rowLimit;
  static const defaultRowLimit = 40;
  static const rowLimitChoices = [20, 40, 60];

  /// Which alerts the Command Center shows; all by default.
  final Set<AlertKind> alerts;

  /// FINE logging (request/response bodies). The build-time
  /// `LS_LOG_LEVEL` is the default; the saved value wins once set.
  final bool verboseLog;
  static final defaultVerboseLog =
      parseLogLevel(lsLogLevelDefault) <= Level.FINE;

  static const pollIntervalKey = 'poll_interval_s';
  static const panicThresholdKey = 'panic_threshold_s';
  static const rowLimitKey = 'row_limit';

  /// Alerts switched *off*, so "nothing saved" means all on.
  static const alertsOffKey = 'alerts_off';
  static const verboseLogKey = 'log_verbose';
  static const keys = [
    pollIntervalKey,
    panicThresholdKey,
    rowLimitKey,
    alertsOffKey,
    verboseLogKey,
  ];

  /// Reads the saved values, falling back per field; values outside the
  /// offered choices fall back too, so a stale pref cannot wedge the app.
  factory AppSettings.read(SharedPreferences prefs) {
    int pick(String key, List<int> choices, int fallback) {
      final v = prefs.getInt(key);
      return v != null && choices.contains(v) ? v : fallback;
    }

    final off = prefs.getStringList(alertsOffKey) ?? const [];
    return AppSettings(
      pollIntervalS: pick(
        pollIntervalKey,
        pollIntervalChoices,
        defaultPollIntervalS,
      ),
      panicThresholdS: pick(
        panicThresholdKey,
        panicThresholdChoices,
        defaultPanicThresholdS,
      ),
      rowLimit: pick(rowLimitKey, rowLimitChoices, defaultRowLimit),
      alerts: {
        for (final k in AlertKind.values)
          if (!off.contains(k.name)) k,
      },
      verboseLog: prefs.getBool(verboseLogKey) ?? defaultVerboseLog,
    );
  }

  AppSettings copyWith({
    int? pollIntervalS,
    int? panicThresholdS,
    int? rowLimit,
    Set<AlertKind>? alerts,
    bool? verboseLog,
  }) => AppSettings(
    pollIntervalS: pollIntervalS ?? this.pollIntervalS,
    panicThresholdS: panicThresholdS ?? this.panicThresholdS,
    rowLimit: rowLimit ?? this.rowLimit,
    alerts: alerts ?? this.alerts,
    verboseLog: verboseLog ?? this.verboseLog,
  );

  @override
  bool operator ==(Object other) =>
      other is AppSettings &&
      other.pollIntervalS == pollIntervalS &&
      other.panicThresholdS == panicThresholdS &&
      other.rowLimit == rowLimit &&
      setEquals(other.alerts, alerts) &&
      other.verboseLog == verboseLog;

  @override
  int get hashCode => Object.hash(
    pollIntervalS,
    panicThresholdS,
    rowLimit,
    Object.hashAllUnordered(alerts),
    verboseLog,
  );
}

class AppSettingsNotifier extends Notifier<AppSettings> {
  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  AppSettings build() => AppSettings.read(ref.watch(sharedPreferencesProvider));

  Future<void> setPollInterval(int seconds) async {
    await _prefs.setInt(AppSettings.pollIntervalKey, seconds);
    _log.info('poll interval set to $seconds s');
    state = state.copyWith(pollIntervalS: seconds);
  }

  Future<void> setPanicThreshold(int seconds) async {
    await _prefs.setInt(AppSettings.panicThresholdKey, seconds);
    _log.info('panic threshold set to $seconds s');
    state = state.copyWith(panicThresholdS: seconds);
  }

  Future<void> setRowLimit(int rows) async {
    await _prefs.setInt(AppSettings.rowLimitKey, rows);
    _log.info('best-available rows set to $rows');
    state = state.copyWith(rowLimit: rows);
  }

  Future<void> setAlert(AlertKind kind, bool on) async {
    final alerts = {...state.alerts};
    on ? alerts.add(kind) : alerts.remove(kind);
    await _prefs.setStringList(AppSettings.alertsOffKey, [
      for (final k in AlertKind.values)
        if (!alerts.contains(k)) k.name,
    ]);
    _log.info('alert ${kind.name} ${on ? 'on' : 'off'}');
    state = state.copyWith(alerts: alerts);
  }

  /// Persists the level and applies it to the live log right away.
  Future<void> setVerboseLog(bool on) async {
    await _prefs.setBool(AppSettings.verboseLogKey, on);
    ref.read(appLogProvider).verbose = on;
    state = state.copyWith(verboseLog: on);
  }

  /// Forgets every saved value here. The API address and theme are reset
  /// by their own notifiers (the Settings screen does all three).
  Future<void> resetAll() async {
    for (final key in AppSettings.keys) {
      await _prefs.remove(key);
    }
    _log.info('settings reset to defaults');
    state = AppSettings.defaults();
    ref.read(appLogProvider).verbose = state.verboseLog;
  }
}

final appSettingsProvider = NotifierProvider<AppSettingsNotifier, AppSettings>(
  AppSettingsNotifier.new,
);

/// How often `/state` is polled while the runner is up.
final draftPollIntervalProvider = Provider<Duration>(
  (ref) => Duration(
    seconds: ref.watch(appSettingsProvider.select((s) => s.pollIntervalS)),
  ),
);

/// Rows requested per `/state` poll.
final draftStateRowLimitProvider = Provider<int>(
  (ref) => ref.watch(appSettingsProvider.select((s) => s.rowLimit)),
);

/// Seconds left at which the panic overlay fires.
final panicThresholdProvider = Provider<int>(
  (ref) => ref.watch(appSettingsProvider.select((s) => s.panicThresholdS)),
);

/// Which alerts the Command Center shows.
final enabledAlertsProvider = Provider<Set<AlertKind>>(
  (ref) => ref.watch(appSettingsProvider.select((s) => s.alerts)),
);
