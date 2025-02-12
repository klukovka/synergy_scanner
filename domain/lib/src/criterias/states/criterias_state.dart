import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class CriteriasState extends State<CriteriasState> {
  final Failure? failure;

  CriteriasState({
    this.failure,
  }) : super(CriteriasState._onCreateFailed.reducer +
            CriteriasState._onGetDetailsFailed.reducer +
            CriteriasState._onDeleteFailed.reducer +
            CriteriasState._onUpdateFailed.reducer);

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

  @override
  CriteriasState copyWith({
    Nullable<Failure>? failure,
  }) =>
      CriteriasState(
        failure: failure == null ? this.failure : failure.value,
      );
}
