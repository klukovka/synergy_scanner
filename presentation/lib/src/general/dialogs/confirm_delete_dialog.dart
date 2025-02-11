import 'package:flutter/material.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/general/buttons/pop_up_button/pop_up_button.dart';
import 'package:presentation/src/general/dialogs/regular_dialog.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final Widget subtitle;
  const ConfirmDeleteDialog({
    super.key,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return RegularDialog(
      icon: Icon(MdiIcons.alert),
      title: Text(context.strings.deleteAction),
      subtitle: subtitle,
      confirmAction: PopUpButton.error(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
        child: Text(
          context.strings.delete,
          textAlign: TextAlign.center,
        ),
      ),
      cancelAction: PopUpButton.onSecondaryContainer(
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
        child: Text(
          context.strings.cancel,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
