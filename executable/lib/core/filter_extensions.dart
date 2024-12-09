import 'package:domain/domain.dart';
import 'package:redux/redux.dart';

extension FindFilterExtension on Store<AppState> Function() {
  Filter Function<E extends TableItem<E>, P extends TablePointer>() getFilter({
    Modifier? modifier,
    bool getFullCount = false,
  }) =>
      <E extends TableItem<E>, P extends TablePointer>() {
        final store = this();
        final table = store.state.tablesState.getTable<E, P>();
        var filter = table.filter;
        if (modifier != null) {
          filter = modifier(filter, store);
        }
        return getFullCount ? filter.copyWith(size: table.fullCount) : filter;
      };
}

abstract interface class Modifier {
  Filter call(Filter filter, Store<AppState> store);

  static Modifier reduce(List<Modifier> modifiers) => ProxyModifier(
        (filter, store) {
          var newFilter = filter;
          for (final modifier in modifiers) {
            newFilter = modifier(newFilter, store);
          }
          return newFilter;
        },
      );
}

class ProxyModifier implements Modifier {
  final Filter Function(Filter filter, Store<AppState> store) modifier;

  ProxyModifier(this.modifier);

  @override
  Filter call(Filter filter, Store<AppState> store) => modifier(filter, store);
}

class LockById<T extends TableItem<T>> extends Modifier {
  final FilterBy filterBy;

  LockById(this.filterBy);

  @override
  Filter call(Filter filter, Store<AppState> store) => filter.addFilterBy(
        filterBy,
        [store.state.tablesState.getTables<T>().selectedItemId.toString()],
      );
}
