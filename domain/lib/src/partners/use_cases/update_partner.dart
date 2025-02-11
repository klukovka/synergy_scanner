import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class UpdatePartner extends UseCase<UpdatePartnerAction> {
  final Future<FailureOrResult<Partner>> Function(
      int id, PatchPartner patchPartner) updatePartner;
  final int Function() getPartnerId;

  UpdatePartner(
    this.updatePartner,
    this.getPartnerId,
  ) : super(isAsync: false);

  @override
  Stream<Action> execute(
    UpdatePartnerAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final response = await updatePartner(getPartnerId(), action.partner);

    if (response.wasSuccessful) {
      yield UpdateTableItemAction<Partner, GeneralTablePointer>(
        response.result!,
      );
      return;
    }

    yield FailedAction<UpdatePartner>(response.failure!);
  }
}
