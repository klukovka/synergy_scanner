import 'package:flutter/material.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/general/buttons/menu_item.dart';
import 'package:presentation/src/general/buttons/more_selector_button.dart';

class PartnerDetailsOptionsButton extends StatelessWidget {
  const PartnerDetailsOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MoreSelectorButton(
      children: (context) => [
        MenuItem(
          label: context.strings.edit,
          icon: Icon(MdiIcons.pencil),
          onPressed: () {},
        ),
        MenuItem(
          label: context.strings.delete,
          icon: Icon(MdiIcons.delete),
          onPressed: () {},
        ),
      ],
    );
  }
}
