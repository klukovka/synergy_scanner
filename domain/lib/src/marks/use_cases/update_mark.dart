import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class UpdateMark extends UseCase<UpdateMarkAction> {
  final Future<FailureOrResult<Mark>> Function(int id, PatchMark patchMark)
      updateMark;

  UpdateMark(this.updateMark) : super(isAsync: false);

  @override
  Stream<Action> execute(
    UpdateMarkAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    yield SetMarkLoading(true);
    final criteria = action.criteria;
    final partner = action.partner;

    final response = await updateMark(
      action.id,
      PatchMark(
        mark: action.mark,
        criteriaId: criteria.id,
        partnerId: partner.id,
      ),
    );

    if (response.wasSuccessful) {
      yield SetSelectedIdAction<Partner>(partner.id);
      yield UpdateTableItemAction<Criteria, PartnerTablePointer>(
        criteria.copyWith(mark: response.result!),
      );
      yield UpdateTableItemAction<Partner, CriteriaTablePointer>(
        partner.copyWith(mark: response.result!),
      );
      yield SetMarkLoading(false);
      return;
    }

    yield FailedAction<UpdateMark>(response.failure!);
    yield SetMarkLoading(false);
  }
}
