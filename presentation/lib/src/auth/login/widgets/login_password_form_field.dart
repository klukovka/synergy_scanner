import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/auth/login/login_page.dart';

class LoginPasswordFormField extends StatelessWidget {
  const LoginPasswordFormField({
    super.key,
    required FormBuilderState? fbState,
  }) : _fbState = fbState;

  final FormBuilderState? _fbState;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: StartPageField.password.name,
      onChanged: (value) => _fbState?.save(),
      obscureText: true,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return context.strings.passwordRequired;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: context.strings.password,
        prefixIcon: Icon(MdiIcons.key),
      ),
    );
  }
}
