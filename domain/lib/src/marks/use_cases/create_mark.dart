import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class CreateMark extends UseCase<CreateMarkAction> {
  final Future<FailureOrResult<int>> Function(NewMark newMark) createMark;
  final Criteria Function(int id) getCriteria;
  final Partner Function() getPartner;

  CreateMark(
    this.createMark,
    this.getCriteria,
    this.getPartner,
  ) : super(isAsync: false);

  @override
  Stream<Action> execute(
    CreateMarkAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    yield SetMarkLoading(true);
    final criteria = getCriteria(action.criteriaId);
    final partner = getPartner();

    final response = await createMark(
      NewMark(
        mark: action.mark,
        criteriaId: action.criteriaId,
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
            criteriaId: action.criteriaId,
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
