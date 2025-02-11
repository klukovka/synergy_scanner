import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/auth/sign_up/sign_up_page.dart';
import 'package:presentation/src/utilts/extensions/credentials_validation_extension.dart';

class SignUpEmailFormField extends StatelessWidget {
  const SignUpEmailFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: SignUpPageField.email.name,
      validator: (value) => switch (value) {
        String? x when x == null || x.isEmpty =>
          context.strings.emailAddressRequired,
        String? x when !x!.isValidEmail => context.strings.emailMustBeValid,
        _ => null,
      },
      decoration: InputDecoration(
        labelText: context.strings.email,
        prefixIcon: Icon(MdiIcons.email),
      ),
    );
  }
}
