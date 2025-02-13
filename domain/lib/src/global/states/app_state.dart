import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class AppState extends State<AppState> {
  final CurrentUserState currentUserState;
  final NavigationState navigationState;
  final ErrorState errorState;
  final AllTablesState tablesState;
  final PartnersState partnersState;
  final CriteriasState criteriasState;
  final MarksState marksState;
  final SettingsState settingsState;

  AppState({
    required this.currentUserState,
    required this.navigationState,
    required this.errorState,
    required this.tablesState,
    required this.partnersState,
    required this.criteriasState,
    required this.marksState,
    required this.settingsState,
  }) : super(AppState._updateSubstates.reducer + AppState.reset.reducer);

  factory AppState._updateSubstates(AppState state, Action action) =>
      state.copyWith(
        currentUserState: state.currentUserState.reducer(
          state.currentUserState,
          action,
        ),
        navigationState: state.navigationState.reducer(
          state.navigationState,
          action,
        ),
        errorState: state.errorState.reducer(state.errorState, action),
        tablesState: state.tablesState.reducer(
          state.tablesState,
          action,
        ),
        partnersState: state.partnersState.reducer(state.partnersState, action),
        criteriasState: state.criteriasState.reducer(
          state.criteriasState,
          action,
        ),
        marksState: state.marksState.reducer(state.marksState, action),
        settingsState: state.settingsState.reducer(state.settingsState, action),
      );

  AppState.initial({
    required CurrentUserState currentUserState,
    required NavigationState navigationState,
  }) : this(
          currentUserState: currentUserState,
          navigationState: navigationState,
          errorState: ErrorState.initial(),
          tablesState: AllTablesState.initial(),
          partnersState: PartnersState(),
          criteriasState: CriteriasState(),
          marksState: MarksState(),
          settingsState: SettingsState.initial(),
        );

  factory AppState.reset(AppState state, ResetAppAction action) {
    return AppState.initial(
      currentUserState: CurrentUserState(),
      navigationState: NavigationState(
        previousRoutes: [],
        currentRoute: {Destination.login},
      ),
    );
  }

  @override
  AppState copyWith({
    CurrentUserState? currentUserState,
    NavigationState? navigationState,
    ErrorState? errorState,
    AllTablesState? tablesState,
    PartnersState? partnersState,
    CriteriasState? criteriasState,
    MarksState? marksState,
    SettingsState? settingsState,
  }) =>
      AppState(
        currentUserState: currentUserState ?? this.currentUserState,
        navigationState: navigationState ?? this.navigationState,
        errorState: errorState ?? this.errorState,
        tablesState: tablesState ?? this.tablesState,
        partnersState: partnersState ?? this.partnersState,
        criteriasState: criteriasState ?? this.criteriasState,
        marksState: marksState ?? this.marksState,
        settingsState: settingsState ?? this.settingsState,
      );
}
