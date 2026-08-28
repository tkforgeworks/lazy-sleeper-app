import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazy_sleeper_app/api/lazy_sleeper_api.dart';
import 'package:lazy_sleeper_app/api/models/draft.dart';
import 'package:lazy_sleeper_app/app/shell/top_nav.dart';
import 'package:lazy_sleeper_app/app/widgets/atoms.dart';
import 'package:lazy_sleeper_app/features/draft/draft_runner_providers.dart';

import '../../support.dart';

Future<void> openDraft(WidgetTester tester) async {
  await tester.tap(find.widgetWithText(NavPill, 'Draft'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('start posts the typed id, shows the result, remembers the id', (
    tester,
  ) async {
    final calls = <(String, int)>[];
    final api = FakeLazySleeperApi(
      onStart: (id, season) async {
        calls.add((id, season));
        return DraftStartOut(
          draftId: id,
          season: season,
          running: true,
          alreadyRunning: false,
          mySlot: 4,
          picksMade: 12,
          boardRows: 672,
        );
      },
    );
    final store = await pumpApp(tester, desktopSize, api: api);
    await openDraft(tester);

    await tester.enterText(find.byType(TextField), ' 1392685476523024384 ');
    await tester.tap(find.widgetWithText(PrimaryButton, 'Start runner'));
    await tester.pumpAndSettle();

    expect(calls, [('1392685476523024384', 2026)]);
    expect(
      find.textContaining('Runner up for 1392685476523024384'),
      findsOneWidget,
    );
    expect(find.textContaining('slot 4'), findsOneWidget);
    expect(find.textContaining('12 picks made'), findsOneWidget);
    expect(store.getString(DraftId.prefsKey), '1392685476523024384');
  });

  testWidgets('a remembered id is pre-filled', (tester) async {
    await pumpApp(tester, desktopSize, prefs: {DraftId.prefsKey: '777'});
    await openDraft(tester);

    expect(
      tester.widget<TextField>(find.byType(TextField)).controller?.text,
      '777',
    );
  });

  testWidgets('an empty id does nothing', (tester) async {
    var started = 0;
    final api = FakeLazySleeperApi(
      onStart: (id, season) async {
        started++;
        throw StateError('should not be called');
      },
    );
    await pumpApp(tester, desktopSize, api: api);
    await openDraft(tester);

    await tester.tap(find.widgetWithText(PrimaryButton, 'Start runner'));
    await tester.pumpAndSettle();

    expect(started, 0);
  });

  testWidgets('already-running and slot-pending are called out', (
    tester,
  ) async {
    final api = FakeLazySleeperApi(
      onStart: (id, season) async => DraftStartOut(
        draftId: id,
        season: season,
        running: true,
        alreadyRunning: true,
        mySlot: null,
        picksMade: 0,
        boardRows: 672,
      ),
    );
    await pumpApp(tester, desktopSize, api: api);
    await openDraft(tester);

    await tester.enterText(find.byType(TextField), '123');
    await tester.tap(find.widgetWithText(PrimaryButton, 'Start runner'));
    await tester.pumpAndSettle();

    expect(find.textContaining('already up'), findsOneWidget);
    expect(find.textContaining('slot not assigned yet'), findsOneWidget);
    expect(find.textContaining('MY_DRAFT_SLOT'), findsOneWidget);
  });

  testWidgets('stop on a runner that is not up shows the API detail', (
    tester,
  ) async {
    final api = FakeLazySleeperApi(
      onStop: (id) async => throw ApiException(
        'POST /draft/$id/stop returned 404: draft $id is not running',
        statusCode: 404,
      ),
    );
    await pumpApp(tester, desktopSize, api: api);
    await openDraft(tester);

    await tester.enterText(find.byType(TextField), '123');
    await tester.tap(find.widgetWithText(SecondaryButton, 'Stop'));
    await tester.pumpAndSettle();

    expect(find.text('FAILED'), findsOneWidget);
    expect(find.textContaining('is not running'), findsOneWidget);
  });

  testWidgets('known drafts are listed and tapping one fills the id', (
    tester,
  ) async {
    final api = FakeLazySleeperApi(
      onDrafts: () async => const [
        DraftSummary(draftId: '999', running: true, season: 2026),
      ],
    );
    await pumpApp(tester, desktopSize, api: api);
    await openDraft(tester);

    expect(find.textContaining('running · 2026'), findsOneWidget);
    await tester.tap(find.text('999'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<TextField>(find.byType(TextField)).controller?.text,
      '999',
    );
  });
}
