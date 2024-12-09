import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class PartnersState extends State<PartnersState> {
  final Failure? failure;

  PartnersState({
    this.failure,
  }) : super(PartnersState._onCreateFailed.reducer);

  factory PartnersState._onCreateFailed(
    PartnersState state,
    FailedAction<CreatePartner> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  @override
  PartnersState copyWith({
    Nullable<Failure>? failure,
  }) =>
      PartnersState(
        failure: failure == null ? this.failure : failure.value,
      );
}
