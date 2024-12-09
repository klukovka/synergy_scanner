import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class UpdateTablesItemsAction<T extends TableItem<T>> extends Action {
  final Chunk<T> chunk;
  final bool append;

  UpdateTablesItemsAction(
    this.chunk, {
    required this.append,
  });

  @override
  List<Object?> get properties => [chunk, append];
}

class UpdateTablesItemAction<T extends TableItem<T>> extends Action {
  final T item;
  final bool replace;

  UpdateTablesItemAction(this.item, {this.replace = false});
}
