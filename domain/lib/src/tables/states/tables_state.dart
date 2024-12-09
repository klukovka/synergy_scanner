import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class TablesState<T extends TableItem<T>> extends State<TablesState<T>> {
  final List<TableState<T, TablePointer>> tables;
  final int? selectedItemId;

  T? get selectedItem => tables
      .expand((element) => element.items)
      .firstWhereOrNull((x) => x.id == selectedItemId);

  TablesState({
    required this.tables,
    this.selectedItemId,
  }) : super(
          TablesState<T>._updateTable.reducer +
              TablesState<T>._setSelectedItemId.reducer +
              TablesState<T>._unselectItem.reducer,
        );

  TableState<T, V> getTable<V extends TablePointer>() {
    for (var table in tables) {
      if (table is TableState<T, V>) return table;
    }
    throw ArgumentError.value(
      V,
      'pointer',
      'Table for entity $T and pointer $V not found',
    );
  }

  factory TablesState._updateTable(
    TablesState<T> state,
    Action action,
  ) =>
      state.copyWith(
        tables: state.tables.map((x) => x.reducer(x, action)).toList(),
      );

  factory TablesState._setSelectedItemId(
    TablesState<T> state,
    SetSelectedIdAction<T> action,
  ) =>
      state.copyWith(selectedItemId: Nullable(action.id));

  factory TablesState._unselectItem(
    TablesState<T> state,
    UnselectIdAction<T> action,
  ) =>
      state.copyWith(selectedItemId: Nullable(null));

  @override
  TablesState<T> copyWith({
    List<TableState<T, TablePointer>>? tables,
    Nullable<int>? selectedItemId,
  }) =>
      TablesState<T>(
        tables: tables ?? this.tables,
        selectedItemId:
            selectedItemId == null ? this.selectedItemId : selectedItemId.value,
      );
}
