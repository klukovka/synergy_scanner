import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class SettingsState extends State<SettingsState> {
  final String version;
  final String languageCode;
  final AppTheme theme;
  final Failure? failure;

  SettingsState({
    required this.languageCode,
    required this.theme,
    required this.version,
    this.failure,
  }) : super(SettingsState._updateAppLanguage.reducer +
            SettingsState._updateAppTheme.reducer +
            SettingsState._updateAppVersion.reducer);

  SettingsState.initial()
      : this(
          languageCode: 'en',
          version: '',
          theme: AppTheme.system,
        );

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

  factory SettingsState._updateAppVersion(
    SettingsState state,
    SetAppVersionAction action,
  ) =>
      state.copyWith(version: action.version);

  @override
  SettingsState copyWith({
    String? version,
    String? languageCode,
    AppTheme? theme,
    Nullable<Failure>? failure,
  }) =>
      SettingsState(
        languageCode: languageCode ?? this.languageCode,
        theme: theme ?? this.theme,
        version: version ?? this.version,
        failure: failure == null ? this.failure : failure.value,
      );
}
