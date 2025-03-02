import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class GetCriteriaCorrelations extends UseCase<UploadCriteriaCorrelationAction> {
  final Future<FailureOrResult<Map<Criteria, CriteriaCorrelation>>> Function()
      getCriteriasCorrelation;

  GetCriteriaCorrelations(this.getCriteriasCorrelation) : super(isAsync: false);

  @override
  Stream<Action> execute(
    UploadCriteriaCorrelationAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final result = await getCriteriasCorrelation();

    if (result.hasFailed) {
      yield FailedAction<GetCriteriaCorrelations>(result.failure!);
      return;
    }

    yield UpdateCriteriaCorrelationAction(result.result);
  }
}
