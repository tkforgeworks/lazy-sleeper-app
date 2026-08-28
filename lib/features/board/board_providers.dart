import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/models/board.dart';
import '../../api/providers.dart';
import 'board_view.dart';

/// The latest board from the API. `ref.invalidate` re-fetches.
///
/// Riverpod 3 would otherwise retry a failed fetch with backoff for about a
/// minute while showing a loading state; the screen surfaces the error at
/// once and offers a manual retry instead.
final boardProvider = FutureProvider<BoardResponse>(
  (ref) => ref.watch(lazySleeperApiProvider).board(),
  retry: (retryCount, error) => null,
);

class BoardSortNotifier extends Notifier<BoardSort> {
  @override
  BoardSort build() => BoardSort.ensemble;

  void set(BoardSort sort) => state = sort;
}

final boardSortProvider = NotifierProvider<BoardSortNotifier, BoardSort>(
  BoardSortNotifier.new,
);

/// Null = all positions.
class PositionFilterNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void set(String? position) => state = position;
}

final positionFilterProvider =
    NotifierProvider<PositionFilterNotifier, String?>(
      PositionFilterNotifier.new,
    );

/// The player open in the detail drawer (desktop). Mobile uses a modal sheet.
class SelectedRowNotifier extends Notifier<BoardRow?> {
  @override
  BoardRow? build() => null;

  void select(BoardRow? row) => state = row;
}

final selectedRowProvider = NotifierProvider<SelectedRowNotifier, BoardRow?>(
  SelectedRowNotifier.new,
);

/// Rows after the position filter and sort, for whichever layout is showing.
final visibleRowsProvider = Provider<List<BoardRow>>((ref) {
  final rows = ref.watch(boardProvider).value?.rows ?? const [];
  final filtered = filterRows(rows, ref.watch(positionFilterProvider));
  return sortRows(filtered, ref.watch(boardSortProvider));
});
