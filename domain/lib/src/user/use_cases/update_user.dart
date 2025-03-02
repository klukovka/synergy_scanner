import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class UpdateUser extends UseCase<PatchUserAction> {
  final Future<FailureOrResult<User>> Function(PatchUser user) patchUser;
  UpdateUser(this.patchUser) : super(isAsync: false);

  @override
  Stream<Action> execute(
    PatchUserAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final result = await patchUser(action.patchUser);

    if (result.wasSuccessful) {
      yield UpdateCurrentUserAction(result.result!);
      return;
    }

    yield FailedAction<UpdateUser>(result.failure!);
  }
}
