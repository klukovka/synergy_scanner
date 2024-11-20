import 'package:clean_redux/clean_redux.dart';
import 'package:domain/src/user/entities/user.dart';

class UpdateCurrentUserAction extends Action {
  final User? user;

  UpdateCurrentUserAction(this.user);
}
