import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class UpdateCriteria extends UseCase<UpdateCriteriaAction> {
  final Future<FailureOrResult<Criteria>> Function(
      int id, PatchCriteria patchCriteria) updateCriteria;
  final int Function() getCriteriaId;

  UpdateCriteria(
    this.updateCriteria,
    this.getCriteriaId,
  ) : super(isAsync: false);

  @override
  Stream<Action> execute(
    UpdateCriteriaAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final response = await updateCriteria(getCriteriaId(), action.criteria);

    if (response.wasSuccessful) {
      yield UpdateTableItemAction<Criteria, GeneralTablePointer>(
        response.result!,
      );
      yield DownloadTableItemsAction<Partner, GeneralTablePointer>(
        append: false,
        clear: true,
      );
      yield UploadCriteriaCorrelationAction();

      return;
    }

    yield FailedAction<UpdateCriteria>(response.failure!);
  }
}
