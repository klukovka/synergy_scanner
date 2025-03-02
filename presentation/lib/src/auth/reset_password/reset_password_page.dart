import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification_builder.dart';
import 'package:presentation/src/utilts/extensions/credentials_validation_extension.dart';

enum ResetPasswordPageField {
  email,
}

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _fbKey = GlobalKey<FormBuilderState>();

  FormBuilderState? get _fbState => _fbKey.currentState;
  Map<String, dynamic> get _fbValues => _fbState?.value ?? {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.resetPassword),
      ),
      body: AutovalidateModeNotificationBuilder(
        builder: (context, autovalidateMode, child) => FormBuilder(
          key: _fbKey,
          autovalidateMode: autovalidateMode,
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  sliver: SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        const Spacer(),
                        Text(
                          context
                              .strings.enterYourEmailToReceiveTemporaryPassword,
                        ),
                        const SizedBox(height: 12),
                        _buildEmailField(),
                        const SizedBox(height: 12),
                        const Spacer(),
                        Builder(
                          builder: (context) =>
                              _buildSaveButton(context, isLoading: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return FormBuilderTextField(
      name: ResetPasswordPageField.email.name,
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

  Widget _buildSaveButton(
    BuildContext context, {
    required bool isLoading,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          AutovalidateModeNotification(
            AutovalidateMode.onUserInteraction,
          ).dispatch(context);
          if (_fbState?.saveAndValidate() ?? false) {}
        },
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(4),
                child: CircularProgressIndicator(),
              )
            : Text(context.strings.complete),
      ),
    );
  }
}
