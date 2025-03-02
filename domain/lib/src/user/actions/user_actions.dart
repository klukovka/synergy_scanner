import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class SignUpAction extends Action {
  final NewUser user;

  SignUpAction(this.user);
}

class UpdateCurrentUserAction extends Action {
  final User? user;

  UpdateCurrentUserAction(this.user);
}

class LogoutAction extends Action {}

class LoginAction extends Action {
  final LoginUser user;

  LoginAction(this.user);
}

class PatchUserAction extends Action {
  final PatchUser patchUser;

  PatchUserAction(this.patchUser);
}
