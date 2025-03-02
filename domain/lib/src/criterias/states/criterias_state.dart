import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class CriteriasState extends State<CriteriasState> {
  final Failure? failure;
  final Map<Criteria, List<CriteriaCorrelation>>? correlations;

  CriteriasState({
    this.failure,
    this.correlations,
  }) : super(CriteriasState._onCreateFailed.reducer +
            CriteriasState._onGetDetailsFailed.reducer +
            CriteriasState._onDeleteFailed.reducer +
            CriteriasState._onUpdateFailed.reducer +
            CriteriasState._onUploadCriteriaCorrelations.reducer +
            CriteriasState._onUpdateCriteriaCorrelations.reducer +
            CriteriasState._onUpdateCriteriaCorrelationsFailed.reducer);

  factory CriteriasState._onCreateFailed(
    CriteriasState state,
    FailedAction<CreateCriteria> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  factory CriteriasState._onGetDetailsFailed(
    CriteriasState state,
    FailedAction<GetCriteriaDetails> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  factory CriteriasState._onDeleteFailed(
    CriteriasState state,
    FailedAction<DeleteCriteria> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  factory CriteriasState._onUpdateFailed(
    CriteriasState state,
    FailedAction<UpdateCriteria> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  factory CriteriasState._onUploadCriteriaCorrelations(
    CriteriasState state,
    UploadCriteriaCorrelationAction action,
  ) =>
      state.copyWith(correlations: Nullable());

  factory CriteriasState._onUpdateCriteriaCorrelations(
    CriteriasState state,
    UpdateCriteriaCorrelationAction action,
  ) =>
      state.copyWith(correlations: Nullable(action.correlations));

  factory CriteriasState._onUpdateCriteriaCorrelationsFailed(
    CriteriasState state,
    FailedAction<GetCriteriaCorrelations> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  @override
  CriteriasState copyWith({
    Nullable<Failure>? failure,
    Nullable<Map<Criteria, List<CriteriaCorrelation>>>? correlations,
  }) =>
      CriteriasState(
        failure: failure == null ? this.failure : failure.value,
        correlations:
            correlations == null ? this.correlations : correlations.value,
      );
}
