import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class CreateCriteria extends UseCase<CreateCriteriaAction> {
  final Future<FailureOrResult<int>> Function(NewCriteria newCriteria)
      createCriteria;

  CreateCriteria(this.createCriteria) : super(isAsync: false);

  @override
  Stream<Action> execute(
    CreateCriteriaAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final response = await createCriteria(action.criteria);

    if (response.wasSuccessful) {
      yield SetSelectedIdAction<Criteria>(response.result!);
      yield DownloadTableItemsAction<Criteria, GeneralTablePointer>(
        append: false,
      );
      return;
    }

    yield FailedAction<CreateCriteria>(response.failure!);
  }
}
