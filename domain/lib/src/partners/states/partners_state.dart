import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class PartnersState extends State<PartnersState> {
  final Failure? failure;

  PartnersState({
    this.failure,
  }) : super(PartnersState._onCreateFailed.reducer +
            PartnersState._onGetDetailsFailed.reducer +
            PartnersState._onDeleteFailed.reducer +
            PartnersState._onUpdateFailed.reducer);

  factory PartnersState._onCreateFailed(
    PartnersState state,
    FailedAction<CreatePartner> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  factory PartnersState._onGetDetailsFailed(
    PartnersState state,
    FailedAction<GetPartnerDetails> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  factory PartnersState._onDeleteFailed(
    PartnersState state,
    FailedAction<GetPartnerDetails> action,
  ) =>
      state.copyWith(failure: Nullable(action.failure));

  factory PartnersState._onUpdateFailed(
    PartnersState state,
    FailedAction<UpdatePartner> action,
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
