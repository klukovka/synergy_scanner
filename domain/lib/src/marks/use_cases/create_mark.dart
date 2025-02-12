import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class CreateMark extends UseCase<CreateMarkAction> {
  final Future<FailureOrResult<int>> Function(NewMark newMark) createMark;

  CreateMark(this.createMark) : super(isAsync: false);

  @override
  Stream<Action> execute(
    CreateMarkAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    yield SetMarkLoading(true);
    final criteria = action.criteria;
    final partner = action.partner;

    final response = await createMark(
      NewMark(
        mark: action.mark,
        criteriaId: criteria.id,
        partnerId: partner.id,
      ),
    );

    if (response.wasSuccessful) {
      yield SetSelectedIdAction<Partner>(partner.id);
      yield UpdateTableItemAction<Criteria, PartnerTablePointer>(
        criteria.copyWith(
          mark: Mark(
            id: response.result!,
            mark: action.mark,
            criteriaId: criteria.id,
            partnerId: partner.id,
          ),
        ),
      );
      yield UpdateTableItemAction<Partner, CriteriaTablePointer>(
        partner.copyWith(
          mark: Mark(
            id: response.result!,
            mark: action.mark,
            criteriaId: criteria.id,
            partnerId: partner.id,
          ),
        ),
      );
      yield SetMarkLoading(false);
      return;
    }

    yield FailedAction<CreateMark>(response.failure!);
    yield SetMarkLoading(false);
  }
}
