import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class SettingsState extends State<SettingsState> {
  final String languageCode;
  final AppTheme theme;

  SettingsState({
    required this.languageCode,
    required this.theme,
  }) : super(SettingsState._updateAppLanguage.reducer +
            SettingsState._updateAppTheme.reducer);

  factory SettingsState._updateAppLanguage(
    SettingsState state,
    SetAppLanguageAction action,
  ) =>
      state.copyWith(languageCode: action.languageCode);

  factory SettingsState._updateAppTheme(
    SettingsState state,
    SetAppThemeAction action,
  ) =>
      state.copyWith(theme: action.theme);

  @override
  SettingsState copyWith({
    String? languageCode,
    AppTheme? theme,
  }) =>
      SettingsState(
        languageCode: languageCode ?? this.languageCode,
        theme: theme ?? this.theme,
      );
}
