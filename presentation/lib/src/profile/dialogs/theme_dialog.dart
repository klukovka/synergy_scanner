import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/general/dialogs/dialog_background.dart';
import 'package:presentation/src/general/tiles/settings_tile.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

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
                Text(
                  context.strings.theme,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                ...AppTheme.values.map(
                  (theme) => SettingsTile(
                    isActive: viewModel.theme == theme,
                    onTap: () => viewModel.setTheme(theme),
                    title: switch (theme) {
                      AppTheme.light => context.strings.light,
                      AppTheme.dark => context.strings.dark,
                      AppTheme.system => context.strings.system,
                    },
                  ),
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
  final AppTheme theme;

  _ViewModel(super.store) : theme = store.state.settingsState.theme;

  void setTheme(AppTheme theme) {
    store.dispatch(SetAppThemeAction(theme));
  }

  @override
  List<Object?> get props => [theme];
}
