import 'dart:io';

import 'package:domain/domain.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PreferencesRepository {
  static const _preferencesBoxKey = '_preferencesBoxKey';

  static const _localeKey = '_localeKey';
  static const _themeModeKey = '_themeModeKey';

  final Box<dynamic> _preferencesBox;

  PreferencesRepository(this._preferencesBox);

  static Future<PreferencesRepository> getInstance() async {
    await Hive.initFlutter();

    final box = await Hive.openBox<dynamic>(_preferencesBoxKey);

    return PreferencesRepository(box);
  }

  ///
  /// Locales
  ///

  String getLanguageCode() =>
      _preferencesBox.get(_localeKey) ?? Platform.localeName;

  Future<void> setLanguageCode(String languageCode) async =>
      await _preferencesBox.put(_localeKey, languageCode);

  ///
  /// Theme Mode
  ///

  AppTheme getTheme() =>
      AppTheme.values.firstWhereOrNull(
          (theme) => theme.code == _preferencesBox.get(_themeModeKey)) ??
      AppTheme.system;

  Future<void> setTheme(AppTheme theme) async =>
      await _preferencesBox.put(_themeModeKey, theme.code);
}
