import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class Logout extends UseCase<LogoutAction> {
  final Future<FailureOrResult<void>> Function() logout;

  Logout(this.logout) : super(isAsync: false);

  @override
  Stream<Action> execute(
    LogoutAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final result = await logout();

    if (result.wasSuccessful) {
      yield ResetAppAction();
      return;
    }

    yield FailedAction<Logout>(result.failure!);
  }
}
