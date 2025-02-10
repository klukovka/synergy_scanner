import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class ReloadData extends UseCase<ReloadDataAction> {
  ReloadData() : super(isAsync: true);

  @override
  Stream<Action> execute(
    ReloadDataAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    yield DownloadTableItemsAction<Partner, GeneralTablePointer>(append: false);
    yield DownloadTableItemsAction<Criteria, GeneralTablePointer>(
        append: false);
  }
}
