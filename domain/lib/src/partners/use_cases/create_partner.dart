import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class CreatePartner extends UseCase<CreatePartnerAction> {
  final Future<FailureOrResult<int>> Function(NewPartner newPartner)
      createPartner;

  CreatePartner(this.createPartner) : super(isAsync: false);

  @override
  Stream<Action> execute(
    CreatePartnerAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final response = await createPartner(action.partner);

    if (response.wasSuccessful) {
      yield SetSelectedIdAction<Partner>(response.result!);
      yield DownloadTableItemsAction<Partner, GeneralTablePointer>(
        append: false,
      );
      return;
    }

    yield FailedAction<CreatePartner>(response.failure!);
  }
}
