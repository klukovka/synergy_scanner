import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class TableState<T extends TableItem<T>, V extends TablePointer>
    extends State<TableState<T, V>> {
  final bool isLoading;
  final Filter filter;
  final Failure? failure;
  final Chunk<HidingWrapper<T>> _chunk;
  final List<T> items;
  final List<T> visibleItems;

  int get fullCount => _chunk.fullCount;

  TableState({
    required this.isLoading,
    required Chunk<HidingWrapper<T>> chunk,
    required this.filter,
    this.failure,
  })  : _chunk = chunk,
        items = chunk.values.map((e) => e.item).toList(),
        visibleItems = chunk.values
            .where((element) => !element.isHidden)
            .map((e) => e.item)
            .toList(),
        super(
          TableState<T, V>._updateItems.reducer +
              TableState<T, V>._updateItemsGeneric.reducer +
              TableState<T, V>._mergeItem.reducer +
              TableState<T, V>._mergeItemGeneric.reducer +
              TableState<T, V>._updateFilter.reducer +
              TableState<T, V>._downloadFailed.reducer +
              TableState<T, V>._changeItemsVisibility.reducer,
        );

  TableState.initial(Filter filter)
      : this(
          isLoading: false,
          filter: filter,
          failure: null,
          chunk: Chunk<HidingWrapper<T>>(fullCount: 0, values: {}),
        );

  factory TableState._updateItems(
    TableState<T, V> state,
    UpdateTableItemsAction<T, V> action,
  ) {
    final hiddenValues = state._chunk.values.where((x) => x.isHidden);
    final visibleItems =
        state._chunk.values.where((element) => !element.isHidden);
    final newItems = action.chunk.values;

    return state.copyWith(
      fullCount: action.chunk.fullCount,
      items: [
        if (action.append) ...visibleItems,
        ...newItems.map(
          (e) => HidingWrapper(
            hiddenValues.any((x) => x.item.id == e.id)
                ? e.merge(state.items.firstWhere((x) => x.id == e.id))
                : e,
          ),
        ),
        ...hiddenValues.where(
          (e) => !action.chunk.values.any((x) => x.id == e.item.id),
        ),
      ].distinctBy((x) => x.item.id),
      isLoading: false,
    );
  }

  factory TableState._mergeItem(
    TableState<T, V> state,
    UpdateTableItemAction<T, V> action,
  ) {
    return state.copyWith(
      items: state._chunk.values.any((x) => x.item.id == action.item.id)
          ? state._chunk.values.map((item) {
              if (item.item.id == action.item.id) {
                return action.replace
                    ? HidingWrapper(action.item)
                    : HidingWrapper(item.item.merge(action.item));
              }
              return item;
            }).toList()
          : [
              ...state._chunk.values,
              HidingWrapper(action.item, isHidden: true)
            ],
    );
  }

  factory TableState._updateFilter(
    TableState<T, V> state,
    DownloadTableItemsAction<T, V> action,
  ) {
    if (action.filter == null) {
      return state.copyWith(
        isLoading: true,
        filter: action.append ? state.filter : state.filter.reset(),
        items: action.clear ? [] : null,
      );
    }

    final Filter newFilter;
    if (!action.append) {
      newFilter = state.filter.reset().merge(action.filter!);
    } else {
      newFilter = state.filter.merge(action.filter!);
    }

    return state.copyWith(
      filter: newFilter,
      isLoading: true,
      items: action.clear ? [] : null,
    );
  }

  factory TableState._changeItemsVisibility(
    TableState<T, V> state,
    ChangeVisibitilyTableItemsAction<T, V> action,
  ) =>
      state.copyWith(
        items: state._chunk.values.map((value) {
          if (action.items.any((element) => element.id == value.item.id)) {
            return HidingWrapper(value.item, isHidden: action.isHidden);
          }
          return value;
        }).toList(),
      );

  factory TableState._downloadFailed(
    TableState<T, V> state,
    FailedAction<GetTableItems<T, V>> action,
  ) =>
      state.copyWith(
        failure: action.failure,
        isLoading: false,
      );

  factory TableState._updateItemsGeneric(
    TableState<T, V> state,
    UpdateTablesItemsAction<T> action,
  ) =>
      TableState._updateItems(
        state,
        UpdateTableItemsAction<T, V>(action.chunk, append: action.append),
      );

  factory TableState._mergeItemGeneric(
    TableState<T, V> state,
    UpdateTablesItemAction<T> action,
  ) =>
      TableState._mergeItem(
        state,
        UpdateTableItemAction(action.item, replace: action.replace),
      );

  @override
  TableState<T, V> copyWith({
    bool? isLoading,
    List<HidingWrapper<T>>? items,
    int? fullCount,
    Filter? filter,
    Failure? failure,
  }) =>
      TableState(
        isLoading: isLoading ?? this.isLoading,
        chunk: Chunk(
          fullCount: fullCount ?? _chunk.fullCount,
          values: items?.toSet() ?? _chunk.values,
        ),
        filter: filter ?? this.filter,
        failure: failure ?? this.failure,
      );
}
