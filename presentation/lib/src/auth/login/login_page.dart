import 'package:clean_redux/clean_redux.dart' hide State;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/auth/login/widgets/auth_buttons.dart';
import 'package:presentation/src/auth/login/widgets/login_email_form_field.dart';
import 'package:presentation/src/auth/login/widgets/login_password_form_field.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification_builder.dart';
import 'package:presentation/src/general/buttons/bottom_loading_button.dart';

enum StartPageField {
  email,
  password,
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  FormBuilderState? get _fbState => _fbKey.currentState;
  Map<String, dynamic> get _fbValues => _fbState?.value ?? {};

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.new,
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.currentUser != newViewModel.currentUser &&
            newViewModel.currentUser != null) {
          _isLoading = false;
          newViewModel.navigateToHomePage();
        }

        if (previousViewModel?.failure != newViewModel.failure && _isLoading) {
          _isLoading = false;
          newViewModel.handleUnexpectedError(
            title: context.strings.loginFailure,
            message: newViewModel.failure?.message,
          );
        }
      },
      builder: (context, viewModel) => Scaffold(
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
                            context.strings.appName,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontFamily:
                                      GoogleFonts.yesteryear().fontFamily,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          const LoginEmailFormField(),
                          const SizedBox(height: 12),
                          LoginPasswordFormField(fbState: _fbState),
                          const SizedBox(height: 12),
                          BottomLoadingButton(
                            isLoading: _isLoading,
                            onPressed: () {
                              AutovalidateModeNotification(
                                AutovalidateMode.onUserInteraction,
                              ).dispatch(context);
                              if (_fbState?.saveAndValidate() ?? false) {
                                setState(() => _isLoading = true);

                                viewModel.login(
                                  LoginUser(
                                    email: _fbValues[StartPageField.email.name],
                                    password:
                                        _fbValues[StartPageField.password.name],
                                  ),
                                );
                              }
                            },
                            child: Text(context.strings.login),
                          ),
                          const SizedBox(height: 12),
                          const Spacer(),
                          const AuthButtons(),
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

  void login(LoginUser user) {
    store.dispatch(LoginAction(user));
  }

  void navigateToHomePage() {
    store.dispatch(
      ReplaceRouteAction({Destination.partners}, previousRoutes: []),
    );
  }

  @override
  List<Object?> get props => [currentUser, failure];
}
