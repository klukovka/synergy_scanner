import 'package:clean_redux/clean_redux.dart' hide State;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/core/app_bar/mobile_app_bar.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/core/extensions/partner_type_extension.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification_builder.dart';
import 'package:presentation/src/general/buttons/bottom_loading_button.dart';
import 'package:presentation/src/general/fields/avatar_picker_form_field.dart';

enum CreatePartnerPageFormField {
  avatar,
  name,
  type;
}

class CreatePartnerPage extends StatefulWidget {
  const CreatePartnerPage({super.key});

  @override
  State<CreatePartnerPage> createState() => _CreatePartnerPageState();
}

class _CreatePartnerPageState extends State<CreatePartnerPage> {
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
        if (previousViewModel?.partnerId != newViewModel.partnerId &&
            newViewModel.partnerId != null) {
          _isLoading = false;
          newViewModel.close();
          //TODO: Open details
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
                            name: CreatePartnerPageFormField.avatar.name,
                            radius: 52,
                          ),
                          const SizedBox(height: 32),
                          FormBuilderTextField(
                            name: CreatePartnerPageFormField.name.name,
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
                          ),
                          const SizedBox(height: 12),
                          FormBuilderDropdown(
                            name: CreatePartnerPageFormField.type.name,
                            validator: (value) {
                              if (value == null) {
                                return context.strings.fieldRequired;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: context.strings.type,
                              prefixIcon: Icon(MdiIcons.heart),
                            ),
                            items: PartnerType.values
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item.getDisplayText(context)),
                                  ),
                                )
                                .toList(),
                          ),
                          const Spacer(),
                          BottomLoadingButton(
                            isLoading: _isLoading,
                            onPressed: () {
                              AutovalidateModeNotification(
                                AutovalidateMode.onUserInteraction,
                              ).dispatch(context);
                              if (_fbState?.saveAndValidate() ?? false) {
                                setState(() => _isLoading = true);
                                viewModel.createPartner(
                                  NewPartner(
                                    name: _fbValues[
                                        CreatePartnerPageFormField.name.name],
                                    type: _fbValues[
                                        CreatePartnerPageFormField.type.name],
                                    avatar: _fbValues[
                                        CreatePartnerPageFormField.avatar.name],
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
  final int? partnerId;
  final Failure? failure;

  _ViewModel(super.store)
      : partnerId =
            store.state.allTablesState.getTables<Partner>().selectedItemId,
        failure = store.state.partnersState.failure;

  void createPartner(NewPartner partner) {
    store.dispatch(CreatePartnerAction(partner));
  }

  @override
  List<Object?> get props => [partnerId, failure];
}
