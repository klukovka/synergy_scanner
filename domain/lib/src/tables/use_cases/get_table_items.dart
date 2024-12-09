import 'dart:async';

import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class GetTableItems<T extends TableItem<T>, V extends TablePointer>
    extends UseCase<DownloadTableItemsAction<T, V>> {
  final Future<FailureOrResult<Chunk<T>>> Function(Filter filter) getItems;

  final Filter Function<T extends TableItem<T>, V extends TablePointer>()
      getFilter;

  final bool Function() hasPermission;

  GetTableItems(
    this.getItems,
    this.getFilter, {
    bool Function()? hasPermission,
  })  : hasPermission = hasPermission ?? (() => true),
        super(
          isAsync: true,
          transformer: DelayedTransformer(const Duration(seconds: 1)),
        );

  @override
  Stream<Action> execute(
    DownloadTableItemsAction<T, V> action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    if (!hasPermission()) return;

    final filter = getFilter<T, V>();

    final response = await getItems(filter);

    if (cancel.canceled) return;

    if (response.wasSuccessful) {
      yield UpdateTableItemsAction<T, V>(
        response.result!,
        append: action.append,
      );
    } else {
      yield FailedAction<GetTableItems<T, V>>(response.failure!);
    }
  }

  @override
  void waitCancel(Stream<Action> actions, CancelToken token) =>
      actions.listen((action) {
        if (action is DownloadTableItemsAction<T, V>) {
          token.cancel();
        }
      });
}
