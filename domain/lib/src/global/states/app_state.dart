import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class AppState extends State<AppState> {
  final CurrentUserState currentUserState;
  final NavigationState navigationState;
  final ErrorState errorState;

  AppState({
    required this.currentUserState,
    required this.navigationState,
    required this.errorState,
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
      );

  AppState.initial({
    required CurrentUserState currentUserState,
    required NavigationState navigationState,
  }) : this(
          currentUserState: currentUserState,
          navigationState: navigationState,
          errorState: ErrorState.initial(),
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
  }) =>
      AppState(
        currentUserState: currentUserState ?? this.currentUserState,
        navigationState: navigationState ?? this.navigationState,
        errorState: errorState ?? this.errorState,
      );
}
