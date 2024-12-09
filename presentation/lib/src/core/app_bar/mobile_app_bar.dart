import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/app_bar/app_bar_view_model.dart';
import 'package:presentation/src/core/extensions/destination_extension.dart';
import 'package:presentation/src/general/buttons/mobile_action_button/mobile_action_button.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? actionButton;
  final Future<bool> Function()? canCurrentPageBeClosed;

  const MobileAppBar({
    super.key,
    this.actionButton,
    this.canCurrentPageBeClosed,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppBarViewModel>(
      distinct: true,
      converter: (store) => AppBarViewModel(
        store,
        getLabel: (destination) =>
            destination.getStoredLabel(store, context.strings),
      ),
      builder: (context, viewModel) {
        return Material(
          color: Theme.of(context).colorScheme.surface,
          child: SafeArea(
            child: Container(
              height: 68,
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: (Theme.of(context).colorScheme.secondary
                            as MaterialColor)[200]!
                        .withOpacity(0.5),
                  ),
                ),
              ),
              child: MobileActionButton.surfaceContainerHighest(
                onPressed: () async {
                  final canBeClosed = await canCurrentPageBeClosed?.call();
                  if (canBeClosed ?? true) {
                    viewModel.close();
                  }
                },
                title: Row(
                  children: [
                    const Icon(Icons.arrow_back_ios_new_rounded, size: 10),
                    const SizedBox(width: 4),
                    Text(viewModel.penultimateLabel),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(68);
}
