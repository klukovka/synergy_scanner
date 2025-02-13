import 'package:clean_redux/clean_redux.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';

class SettingsController extends Controller {
  SettingsController(
    PreferencesRepository preferencesRepository,
  ) : super([
          Endpoint(SetAppTheme(preferencesRepository.setTheme)).call,
          Endpoint(SetAppLanguage(preferencesRepository.setLanguageCode)).call,
        ]);
}
