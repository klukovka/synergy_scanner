import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class AppState extends State<AppState> {
  final CurrentUserState currentUserState;
  final NavigationState navigationState;

  AppState({
    required this.currentUserState,
    required this.navigationState,
  }) : super(AppState._updateSubstates.reducer);

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
      );

  AppState.initial({
    required CurrentUserState currentUserState,
    required NavigationState navigationState,
  }) : this(
          currentUserState: currentUserState,
          navigationState: navigationState,
        );

  @override
  AppState copyWith({
    CurrentUserState? currentUserState,
    NavigationState? navigationState,
  }) =>
      AppState(
        currentUserState: currentUserState ?? this.currentUserState,
        navigationState: navigationState ?? this.navigationState,
      );
}
