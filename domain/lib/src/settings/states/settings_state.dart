import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class SettingsState extends State<SettingsState> {
  final String version;
  final AppLanguage language;
  final AppTheme theme;
  final Failure? failure;

  SettingsState({
    required this.language,
    required this.theme,
    required this.version,
    this.failure,
  }) : super(SettingsState._updateAppLanguage.reducer +
            SettingsState._updateAppTheme.reducer +
            SettingsState._updateAppVersion.reducer);

  SettingsState.initial()
      : this(
          language: AppLanguage.en,
          version: '',
          theme: AppTheme.device,
        );

  factory SettingsState._updateAppLanguage(
    SettingsState state,
    SetAppLanguageAction action,
  ) =>
      state.copyWith(language: action.language);

  factory SettingsState._updateAppTheme(
    SettingsState state,
    SetAppThemeAction action,
  ) =>
      state.copyWith(theme: action.theme);

  factory SettingsState._updateAppVersion(
    SettingsState state,
    SetAppVersion action,
  ) =>
      state.copyWith(version: action.version);

  @override
  SettingsState copyWith({
    String? version,
    AppLanguage? language,
    AppTheme? theme,
    Nullable<Failure>? failure,
  }) =>
      SettingsState(
        language: language ?? this.language,
        theme: theme ?? this.theme,
        version: version ?? this.version,
        failure: failure == null ? this.failure : failure.value,
      );
}
