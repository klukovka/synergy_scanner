import 'package:clean_redux/clean_redux.dart' hide State;
import 'package:domain/domain.dart';
import 'package:presentation/src/core/base_view_model.dart';

class TableViewModel<T extends TableItem<T>, V extends TablePointer>
    extends BaseViewModel {
  final T? selectedItem;
  final Filter filter;
  final Failure? failure;
  final bool isLoading;
  final SortBy sortBy;
  final Direction direction;
  final List<T> items;
  final int fullCount;

  TableViewModel(super.store)
      : selectedItem = store.state.tablesState.getTables<T>().selectedItem,
        filter = store.state.tablesState.getTable<T, V>().filter,
        failure = store.state.tablesState.getTable<T, V>().failure,
        isLoading = store.state.tablesState.getTable<T, V>().isLoading,
        sortBy = store.state.tablesState.getTable<T, V>().filter.sortBy ??
            SortBy.name,
        direction = store.state.tablesState.getTable<T, V>().filter.direction ??
            Direction.asc,
        items = store.state.tablesState.getTable<T, V>().visibleItems,
        fullCount = store.state.tablesState.getTable<T, V>().fullCount;

  void initLoad() {
    store.dispatch(
      DownloadTableItemsAction<T, V>(append: false, clear: true),
    );
  }

  void downloadItems() {
    store.dispatch(
      DownloadTableItemsAction<T, V>.loadMore(
        items.isNotEmpty ? filter.page + 1 : 0,
      ),
    );
  }

  void sort(SortBy sortBy, Direction direction) =>
      store.dispatch(DownloadTableItemsAction<T, V>.sort(sortBy, direction));

  void search(String value) =>
      store.dispatch(DownloadTableItemsAction<T, V>.search(value));

  void setFilter(Filter filter) {
    store.dispatch(
      DownloadTableItemsAction<T, V>(
        append: false,
        filter: filter,
      ),
    );
  }

  @override
  List<Object?> get props => [
        filter,
        failure,
        isLoading,
        sortBy,
        direction,
        items,
        fullCount,
      ];
}
