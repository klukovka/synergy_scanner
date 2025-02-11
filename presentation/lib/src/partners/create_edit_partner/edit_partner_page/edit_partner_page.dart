import 'package:clean_redux/clean_redux.dart' hide State;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/app_bar/mobile_app_bar.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification_builder.dart';
import 'package:presentation/src/general/buttons/bottom_loading_button.dart';
import 'package:presentation/src/partners/create_edit_partner/widgets/create_edit_partner_form_content.dart';

class EditPartnerPage extends StatefulWidget {
  const EditPartnerPage({super.key});

  @override
  State<EditPartnerPage> createState() => _EditPartnerPageState();
}

class _EditPartnerPageState extends State<EditPartnerPage> {
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
        if (previousViewModel?.partner != newViewModel.partner &&
            newViewModel.partner != null) {
          _isLoading = false;
          newViewModel.close();
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
        appBar: const MobileAppBar(),
        body: AutovalidateModeNotificationBuilder(
          builder: (context, autovalidateMode, child) => FormBuilder(
            key: _fbKey,
            autovalidateMode: autovalidateMode,
            child: CreateEditPartnerFormContent(
              partner: viewModel.partner,
              button: BottomLoadingButton(
                isLoading: _isLoading,
                onPressed: () {
                  AutovalidateModeNotification(
                    AutovalidateMode.onUserInteraction,
                  ).dispatch(context);
                  if (_fbState?.saveAndValidate() ?? false) {
                    setState(() => _isLoading = true);
                    viewModel.editPartner(
                      PatchPartner(
                        name:
                            _fbValues[CreateEditPartnerPageFormField.name.name],
                        type:
                            _fbValues[CreateEditPartnerPageFormField.type.name],
                        avatar: _fbValues[
                            CreateEditPartnerPageFormField.avatar.name],
                      ),
                    );
                  }
                },
                child: Text(context.strings.save),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewModel extends BaseViewModel {
  final Partner? partner;
  final Failure? failure;

  _ViewModel(super.store)
      : partner = store.state.tablesState.getTables<Partner>().selectedItem,
        failure = store.state.partnersState.failure;

  void editPartner(PatchPartner partner) {
    store.dispatch(UpdatePartnerAction(partner));
  }

  @override
  List<Object?> get props => [partner, failure];
}
