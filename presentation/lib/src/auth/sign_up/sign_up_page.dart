import 'package:clean_redux/clean_redux.dart' hide State;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/auth/sign_up/widgets/sign_up_email_form_field.dart';
import 'package:presentation/src/auth/sign_up/widgets/sign_up_name_form_field.dart';
import 'package:presentation/src/auth/sign_up/widgets/sign_up_password_form_field.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification_builder.dart';
import 'package:presentation/src/general/fields/avatar_picker_form_field.dart';

enum SignUpPageField {
  photo,
  name,
  email,
  password,
  confirmPassword,
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  FormBuilderState? get _fbState => _fbKey.currentState;
  Map<String, dynamic> get _fbValues => _fbState?.value ?? {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.signUp),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: _ViewModel.new,
        onWillChange: (previousViewModel, newViewModel) {
          if (previousViewModel?.currentUser != newViewModel.currentUser &&
              newViewModel.currentUser != null) {
            _isLoading = false;
            newViewModel.navigateToHomePage();
          }

          if (previousViewModel?.failure != newViewModel.failure) {
            newViewModel.handleUnexpectedError();
            _isLoading = false;
          }
        },
        builder: (context, viewModel) => AutovalidateModeNotificationBuilder(
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
                          AvatarPickerFormField(
                            name: SignUpPageField.photo.name,
                            radius: 52,
                          ),
                          const SizedBox(height: 32),
                          const SignUpNameFormField(),
                          const SizedBox(height: 12),
                          const SignUpEmailFormField(),
                          const SizedBox(height: 12),
                          SignUpPasswordFormField(fbState: _fbState),
                          const SizedBox(height: 12),
                          FormBuilderTextField(
                            name: SignUpPageField.confirmPassword.name,
                            obscureText: true,
                            validator: (value) {
                              if (value !=
                                  _fbValues[SignUpPageField.password.name]) {
                                return context.strings.passwordsNotMatch;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: context.strings.confirmPassword,
                              prefixIcon: Icon(MdiIcons.key),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Spacer(),
                          Container(
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
                                if (_fbState?.saveAndValidate() ?? false) {
                                  setState(() => _isLoading = true);
                                  viewModel.signUp(
                                    NewUser(
                                      email:
                                          _fbValues[SignUpPageField.email.name],
                                      password: _fbValues[
                                          SignUpPageField.password.name],
                                      name:
                                          _fbValues[SignUpPageField.name.name],
                                      photo:
                                          _fbValues[SignUpPageField.photo.name],
                                    ),
                                  );
                                }
                              },
                              child: _isLoading
                                  ? const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text(context.strings.complete),
                            ),
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
      ),
    );
  }
}

class _ViewModel extends BaseViewModel {
  final User? currentUser;
  final Failure? failure;

  _ViewModel(super.store)
      : currentUser = store.state.currentUserState.user,
        failure = store.state.currentUserState.failure;

  void signUp(NewUser user) {
    store.dispatch(SignUpAction(user));
  }

  void navigateToHomePage() {
    store.dispatch(
      ReplaceRouteAction({Destination.home}, previousRoutes: []),
    );
  }

  @override
  List<Object?> get props => [currentUser, failure];
}
