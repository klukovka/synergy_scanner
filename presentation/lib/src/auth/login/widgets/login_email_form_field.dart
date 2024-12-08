import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/auth/login/login_page.dart';

class LoginEmailFormField extends StatelessWidget {
  const LoginEmailFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: StartPageField.email.name,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return context.strings.emailAddressRequired;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: context.strings.email,
        prefixIcon: Icon(MdiIcons.email),
      ),
    );
  }
}
