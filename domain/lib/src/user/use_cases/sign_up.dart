import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class SignUp extends UseCase<SignUpAction> {
  final Future<FailureOrResult<User>> Function(NewUser user) signUp;

  SignUp(this.signUp) : super(isAsync: false);

  @override
  Stream<Action> execute(
    SignUpAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final result = await signUp(action.user);

    if (result.wasSuccessful) {
      yield UpdateCurrentUserAction(result.result!);
      return;
    }

    yield FailedAction<SignUp>(result.failure!);
  }
}
