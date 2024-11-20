import 'package:clean_redux/clean_redux.dart';
import 'package:domain/src/user/actions/user_actions.dart';
import 'package:domain/src/user/entities/user.dart';

class CurrentUserState extends State<CurrentUserState> {
  final User? user;

  CurrentUserState({this.user}) : super(CurrentUserState._updateUser.reducer);

  factory CurrentUserState._updateUser(
    CurrentUserState state,
    UpdateCurrentUserAction action,
  ) =>
      state.copyWith(user: Nullable(action.user));

  @override
  CurrentUserState copyWith({
    Nullable<User>? user,
  }) =>
      CurrentUserState(user: user == null ? this.user : user.value);
}
