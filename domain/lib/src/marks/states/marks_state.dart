import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class MarksState extends State<MarksState> {
  final Failure? failure;
  final bool isLoading;

  MarksState({
    this.failure,
    this.isLoading = false,
  }) : super(MarksState._onCreateFailed.reducer +
            MarksState._onUpdateFailed.reducer +
            MarksState._setLoading.reducer);

  factory MarksState._onCreateFailed(
    MarksState state,
    FailedAction<CreateMark> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  factory MarksState._onUpdateFailed(
    MarksState state,
    FailedAction<UpdateMark> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  factory MarksState._setLoading(
    MarksState state,
    SetMarkLoading action,
  ) =>
      state.copyWith(isLoading: action.isLoading);

  @override
  MarksState copyWith({
    Nullable<Failure>? failure,
    bool? isLoading,
  }) =>
      MarksState(
        failure: failure == null ? this.failure : failure.value,
        isLoading: isLoading ?? this.isLoading,
      );
}
