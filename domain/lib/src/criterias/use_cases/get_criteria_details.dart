import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class GetCriteriaDetails extends UseCase<SetSelectedIdAction<Criteria>> {
  final Future<FailureOrResult<Criteria>> Function(int id) getGetails;
  GetCriteriaDetails(this.getGetails) : super(isAsync: false);

  @override
  Stream<Action> execute(
    SetSelectedIdAction<Criteria> action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final response = await getGetails(action.id);

    if (response.wasSuccessful) {
      yield UpdateTablesItemAction<Criteria>(response.result!);
      yield UploadCriteriaCorrelationAction();

      return;
    }

    yield FailedAction<GetCriteriaDetails>(response.failure!);
  }
}
