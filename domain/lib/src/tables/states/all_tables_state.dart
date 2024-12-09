import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class AllTablesState extends State<AllTablesState> {
  final List<TablesState<TableItem>> tablesStates;

  TablesState<T> getTables<T extends TableItem<T>>() =>
      tablesStates.firstWhere((element) => element is TablesState<T>)
          as TablesState<T>;

  TableState<T, P> getTable<T extends TableItem<T>, P extends TablePointer>() =>
      getTables<T>().getTable<P>();

  AllTablesState({
    required this.tablesStates,
  }) : super(AllTablesState._update.reducer);

  factory AllTablesState.initial() {
    return AllTablesState(
      tablesStates: [
        TablesState<Partner>(tables: [
          TableState<Partner, GeneralTablePointer>.initial(Filter())
        ]),
      ],
    );
  }

  factory AllTablesState._update(
    AllTablesState state,
    Action action,
  ) =>
      state.copyWith(
        tablesStates: state.tablesStates
            .map((tablesState) => tablesState.reducer(tablesState, action))
            .toList(),
      );

  @override
  AllTablesState copyWith({
    List<TablesState<TableItem>>? tablesStates,
  }) =>
      AllTablesState(
        tablesStates: tablesStates ?? this.tablesStates,
      );
}
