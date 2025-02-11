import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class GetPartnerDetails extends UseCase<SetSelectedIdAction<Partner>> {
  final Future<FailureOrResult<Partner>> Function(int id) getGetails;
  GetPartnerDetails(this.getGetails) : super(isAsync: false);

  @override
  Stream<Action> execute(
    SetSelectedIdAction<Partner> action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final response = await getGetails(action.id);

    if (response.wasSuccessful) {
      yield UpdateTablesItemAction<Partner>(response.result!);

      return;
    }

    yield FailedAction<GetPartnerDetails>(response.failure!);
  }
}
