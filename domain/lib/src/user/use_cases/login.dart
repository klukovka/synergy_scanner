import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class Login extends UseCase<LoginAction> {
  final Future<FailureOrResult<User>> Function(LoginUser user) login;
  Login(this.login) : super(isAsync: false);

  @override
  Stream<Action> execute(
    LoginAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final result = await login(action.user);

    if (result.wasSuccessful) {
      yield UpdateCurrentUserAction(result.result!);
      return;
    }

    yield FailedAction<Login>(result.failure!);
  }
}
