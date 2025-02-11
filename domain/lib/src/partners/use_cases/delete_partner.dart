import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class DeletePartner extends UseCase<DeletePartnerAction> {
  final Future<FailureOrResult<void>> Function(int id) deletePartner;
  final Partner Function() getParterId;

  DeletePartner(
    this.deletePartner,
    this.getParterId,
  ) : super(isAsync: false);

  @override
  Stream<Action> execute(
    DeletePartnerAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    final partner = getParterId();
    final response = await deletePartner(partner.id);
    yield ChangeVisibitilyTableItemsAction<Partner, GeneralTablePointer>(
      [partner],
      isHidden: true,
    );

    if (response.wasSuccessful) {
      yield UnselectIdAction<Partner>();
      yield DownloadTableItemsAction<Partner, GeneralTablePointer>(
        append: false,
      );
      return;
    }

    yield ChangeVisibitilyTableItemsAction<Partner, GeneralTablePointer>(
      [partner],
      isHidden: false,
    );
    yield FailedAction<DeletePartner>(response.failure!);
  }
}
