import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/auth/sign_up/sign_up_page.dart';
import 'package:presentation/src/utlts/extensions/credentials_validation_extension.dart';

class SignUpPasswordFormField extends StatelessWidget {
  const SignUpPasswordFormField({
    super.key,
    required FormBuilderState? fbState,
  }) : _fbState = fbState;

  final FormBuilderState? _fbState;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: SignUpPageField.password.name,
      onChanged: (value) => _fbState?.save(),
      obscureText: true,
      validator: (value) => switch (value) {
        String? x when x == null || x.isEmpty =>
          context.strings.passwordRequired,
        String x when !x.isPasswordValid =>
          context.strings.passwordRequirements,
        String x
            when !RegExp(
                    r'''^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[ !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~])[A-Za-z\d !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~]{8,}$''')
                .hasMatch(x) =>
          context.strings.passwordTooSimple,
        _ => null,
      },
      decoration: InputDecoration(
        labelText: context.strings.password,
        prefixIcon: Icon(MdiIcons.key),
      ),
    );
  }
}
