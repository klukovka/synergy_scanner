import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class DeleteCriteria extends UseCase<DeleteCriteriaAction> {
  final Future<FailureOrResult<void>> Function(int id) deleteCriteria;
  final Criteria Function() getCriteria;

  DeleteCriteria(
    this.deleteCriteria,
    this.getCriteria,
  ) : super(isAsync: false);

  @override
  Stream<Action> execute(
    DeleteCriteriaAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final criteria = getCriteria();
    final response = await deleteCriteria(criteria.id);
    yield ChangeVisibitilyTableItemsAction<Criteria, GeneralTablePointer>(
      [criteria],
      isHidden: true,
    );

    if (response.wasSuccessful) {
      yield UnselectIdAction<Criteria>();
      yield DownloadTableItemsAction<Criteria, GeneralTablePointer>(
        append: false,
      );
      yield DownloadTableItemsAction<Partner, GeneralTablePointer>(
        append: false,
        clear: true,
      );
      yield UploadCriteriaCorrelationAction();

      return;
    }

    yield ChangeVisibitilyTableItemsAction<Criteria, GeneralTablePointer>(
      [criteria],
      isHidden: false,
    );
    yield FailedAction<DeleteCriteria>(response.failure!);
  }
}
