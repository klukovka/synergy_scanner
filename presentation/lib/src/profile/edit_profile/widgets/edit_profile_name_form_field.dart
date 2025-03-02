import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/profile/edit_profile/edit_profile_page.dart';

class EditProfileNameFormField extends StatelessWidget {
  const EditProfileNameFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: EditProfilePageField.name.name,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return context.strings.fieldRequired;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: context.strings.name,
        prefixIcon: Icon(MdiIcons.account),
      ),
    );
  }
}
