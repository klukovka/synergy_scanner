import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class SetAppLanguage extends UseCase<SetAppLanguageAction> {
  final Future<void> Function(String languageCode) setLanguageCode;

  SetAppLanguage(this.setLanguageCode) : super(isAsync: false);

  @override
  Stream<Action> execute(
    SetAppLanguageAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    await setLanguageCode(action.languageCode);
  }
}
