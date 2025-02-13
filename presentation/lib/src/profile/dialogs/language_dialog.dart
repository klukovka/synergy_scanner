import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/general/dialogs/dialog_background.dart';
import 'package:presentation/src/general/tiles/settings_tile.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.new,
      builder: (context, viewModel) {
        return DialogBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SettingsTile(
                  isActive: viewModel.languageCode == 'uk',
                  onTap: () => viewModel.setLocale('uk'),
                  title: context.strings.ukrainian,
                ),
                SettingsTile(
                  isActive: viewModel.languageCode == 'en',
                  onTap: () => viewModel.setLocale('en'),
                  title: context.strings.english,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel extends BaseViewModel {
  final String languageCode;

  _ViewModel(super.store)
      : languageCode = store.state.settingsState.languageCode;

  void setLocale(String languageCode) {
    store.dispatch(SetAppLanguageAction(languageCode));
  }

  @override
  List<Object?> get props => [languageCode];
}
