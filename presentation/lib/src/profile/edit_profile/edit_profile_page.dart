import 'package:clean_redux/clean_redux.dart' hide State;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification_builder.dart';
import 'package:presentation/src/general/buttons/bottom_loading_button.dart';
import 'package:presentation/src/general/fields/avatar_picker_form_field.dart';
import 'package:presentation/src/profile/edit_profile/widgets/edit_profile_email_form_field.dart';
import 'package:presentation/src/profile/edit_profile/widgets/edit_profile_name_form_field.dart';

enum EditProfilePageField {
  photo,
  name,
  email,
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
        onInitialBuild: (viewModel) {
          _fbState?.patchValue({
            EditProfilePageField.email.name: viewModel.currentUser?.email,
            EditProfilePageField.name.name: viewModel.currentUser?.fullname,
          });
        },
        onWillChange: (previousViewModel, newViewModel) {
          if (previousViewModel?.currentUser != newViewModel.currentUser &&
              newViewModel.currentUser != null) {
            _isLoading = false;
          }

          if (previousViewModel?.failure != newViewModel.failure &&
              _isLoading) {
            _isLoading = false;
            newViewModel.handleUnexpectedError(
              title: context.strings.signUpFailure,
              message: newViewModel.failure?.message,
            );
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
                            name: EditProfilePageField.photo.name,
                            radius: 52,
                            imageUrl: viewModel.currentUser?.avatarUrl,
                          ),
                          const SizedBox(height: 32),
                          const EditProfileNameFormField(),
                          const SizedBox(height: 12),
                          const EditProfileEmailFormField(),
                          const SizedBox(height: 12),
                          const Spacer(),
                          BottomLoadingButton(
                            isLoading: _isLoading,
                            onPressed: () {
                              AutovalidateModeNotification(
                                AutovalidateMode.onUserInteraction,
                              ).dispatch(context);
                              if (_fbState?.saveAndValidate() ?? false) {
                                setState(() => _isLoading = true);
                                viewModel.signUp(
                                  PatchUser(
                                    email: _fbValues[
                                        EditProfilePageField.email.name],
                                    fullName: _fbValues[
                                        EditProfilePageField.name.name],
                                    photo: _fbValues[
                                        EditProfilePageField.photo.name],
                                  ),
                                );
                              }
                            },
                            child: Text(context.strings.save),
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

  void signUp(PatchUser user) {
    store.dispatch(PatchUserAction(user));
  }

  @override
  List<Object?> get props => [currentUser, failure];
}
