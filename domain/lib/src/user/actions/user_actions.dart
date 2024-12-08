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
