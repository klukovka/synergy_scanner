import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class SetAppLanguageAction extends Action {
  final AppLanguage language;

  SetAppLanguageAction(this.language);
}

class SetAppThemeAction extends Action {
  final AppTheme theme;

  SetAppThemeAction(this.theme);
}

class FetchAppVersion extends Action {}

class SetAppVersion extends Action {
  final String version;

  SetAppVersion(this.version);
}
