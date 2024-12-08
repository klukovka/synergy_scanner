import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class CurrentUserState extends State<CurrentUserState> {
  final User? user;
  final Failure? failure;

  CurrentUserState({
    this.user,
    this.failure,
  }) : super(CurrentUserState._updateUser.reducer +
            CurrentUserState._onSignUpFailed.reducer +
            CurrentUserState._onLoginFailed.reducer +
            CurrentUserState._onLogoutFailed.reducer);

  factory CurrentUserState._updateUser(
    CurrentUserState state,
    UpdateCurrentUserAction action,
  ) =>
      state.copyWith(user: Nullable(action.user));

  factory CurrentUserState._onSignUpFailed(
    CurrentUserState state,
    FailedAction<SignUp> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  factory CurrentUserState._onLoginFailed(
    CurrentUserState state,
    FailedAction<Login> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  factory CurrentUserState._onLogoutFailed(
    CurrentUserState state,
    FailedAction<Logout> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  @override
  CurrentUserState copyWith({
    Nullable<User>? user,
    Nullable<Failure>? failure,
  }) =>
      CurrentUserState(
        user: user == null ? this.user : user.value,
        failure: failure == null ? this.failure : failure.value,
      );
}
