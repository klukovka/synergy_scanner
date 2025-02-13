import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class SetAppLanguageAction extends Action {
  final String languageCode;

  SetAppLanguageAction(this.languageCode);
}

class SetAppThemeAction extends Action {
  final AppTheme theme;

  SetAppThemeAction(this.theme);
}
