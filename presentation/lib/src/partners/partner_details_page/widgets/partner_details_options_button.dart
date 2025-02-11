import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/general/buttons/menu_item.dart';
import 'package:presentation/src/general/buttons/more_selector_button.dart';
import 'package:presentation/src/general/dialogs/confirm_delete_dialog.dart';
import 'package:presentation/src/general/dialogs/material_dialog.dart';
import 'package:presentation/src/general/pickers/popup_picker.dart';

class PartnerDetailsOptionsButton extends StatelessWidget {
  const PartnerDetailsOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dispatch = StoreProvider.of<AppState>(context).dispatch;

    return MoreSelectorButton(
      children: (context) => [
        MenuItem(
          label: context.strings.edit,
          icon: Icon(MdiIcons.pencil),
          onPressed: () {
            PopupPicker.of(context).close();
            dispatch(OpenPageAction(Destination.editPartner));
          },
        ),
        MenuItem(
          label: context.strings.delete,
          icon: Icon(MdiIcons.delete),
          onPressed: () async {
            final navigator = Navigator.of(context, rootNavigator: true);
            PopupPicker.of(context).close();
            final approved = await navigator.push<bool>(
                  MaterialDialogRoute(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ConfirmDeleteDialog(
                      subtitle:
                          Text(context.strings.youSureYouWantToDeletePartner),
                    ),
                    barrierColor: Theme.of(context)
                        .colorScheme
                        .onSecondaryContainer
                        .withOpacity(0.2),
                  ),
                ) ??
                false;
            if (!approved) return;
            dispatch(DeletePartnerAction());
          },
        ),
      ],
    );
  }
}
