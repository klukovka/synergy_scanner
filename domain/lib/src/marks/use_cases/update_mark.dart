import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class UpdateMark extends UseCase<UpdateMarkAction> {
  final Future<FailureOrResult<Mark>> Function(int id, PatchMark patchMark)
      updateMark;
  final Criteria Function(int id) getCriteria;
  final Partner Function() getPartner;

  UpdateMark(
    this.updateMark,
    this.getCriteria,
    this.getPartner,
  ) : super(isAsync: false);

  @override
  Stream<Action> execute(
    UpdateMarkAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    yield SetMarkLoading(true);
    final criteria = getCriteria(action.mark.criteriaId);
    final partner = getPartner();

    final response = await updateMark(action.id, action.mark);

    if (response.wasSuccessful) {
      yield SetSelectedIdAction<Partner>(partner.id);
      yield UpdateTableItemAction<Criteria, PartnerTablePointer>(
        criteria.copyWith(mark: response.result!),
      );
      yield SetMarkLoading(false);
      return;
    }

    yield FailedAction<UpdateMark>(response.failure!);
    yield SetMarkLoading(false);
  }
}
