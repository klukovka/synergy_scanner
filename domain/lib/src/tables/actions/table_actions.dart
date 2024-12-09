import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class UpdateTableItemsAction<T extends TableItem<T>, V extends TablePointer>
    extends Action {
  final Chunk<T> chunk;
  final bool append;

  UpdateTableItemsAction(
    this.chunk, {
    required this.append,
  });

  @override
  List<Object?> get properties => [chunk.values.length, append];
}

class UpdateTableItemAction<T extends TableItem<T>, V extends TablePointer>
    extends Action {
  final T item;
  final bool replace;

  UpdateTableItemAction(this.item, {this.replace = false});
}

class DownloadTableItemsAction<T extends TableItem<T>, V extends TablePointer>
    extends Action {
  final Filter? filter;
  final bool append;
  final bool clear;

  DownloadTableItemsAction({
    this.filter,
    required this.append,
    this.clear = false,
  });

  DownloadTableItemsAction.loadMore(int nextPage)
      : append = true,
        clear = false,
        filter = Filter(page: nextPage);

  DownloadTableItemsAction.search(
    String value,
  )   : filter = Filter(search: value),
        append = false,
        clear = false;

  DownloadTableItemsAction.sort(
    SortBy sortBy,
    Direction direction,
  )   : filter = Filter(sortBy: sortBy, direction: direction),
        clear = false,
        append = false;
}

class SetSelectedIdAction<T extends TableItem<T>> extends Action {
  final int id;

  SetSelectedIdAction(this.id);

  @override
  List<Object?> get properties => [id];
}

class UnselectIdAction<T extends TableItem<T>> extends Action {}

class ChangeVisibitilyTableItemsAction<T extends TableItem<T>,
    V extends TablePointer> extends Action {
  final List<T> items;
  final bool isHidden;

  ChangeVisibitilyTableItemsAction(
    this.items, {
    required this.isHidden,
  });

  @override
  List<Object?> get properties => [items, isHidden];
}
