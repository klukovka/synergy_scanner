import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class CriteriasState extends State<CriteriasState> {
  final Failure? failure;

  CriteriasState({
    this.failure,
  }) : super(CriteriasState._onCreateFailed.reducer);

  factory CriteriasState._onCreateFailed(
    CriteriasState state,
    FailedAction<CreateCriteria> action,
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
