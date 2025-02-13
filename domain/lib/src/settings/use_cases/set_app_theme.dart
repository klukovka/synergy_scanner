import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class SetAppTheme extends UseCase<SetAppThemeAction> {
  final Future<void> Function(AppTheme theme) setTheme;

  SetAppTheme(this.setTheme) : super(isAsync: false);

  @override
  Stream<Action> execute(
    SetAppThemeAction action,
    Stream<Action> actions,
    CancelToken cancel,
  ) async* {
    await setTheme(action.theme);
  }
}
