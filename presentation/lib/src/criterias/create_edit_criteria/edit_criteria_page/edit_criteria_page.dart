import 'package:clean_redux/clean_redux.dart' hide State;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/app_bar/mobile_app_bar.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/criterias/create_edit_criteria/widgets/create_edit_criteria_form_content.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification_builder.dart';
import 'package:presentation/src/general/buttons/bottom_loading_button.dart';

class EditCriteriaPage extends StatefulWidget {
  const EditCriteriaPage({super.key});

  @override
  State<EditCriteriaPage> createState() => _EditCriteriaPageState();
}

class _EditCriteriaPageState extends State<EditCriteriaPage> {
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
        if (previousViewModel?.criteria != newViewModel.criteria &&
            newViewModel.criteria != null &&
            _isLoading) {
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
            child: CreateEditCriteriaFormContent(
              criteria: viewModel.criteria,
              button: BottomLoadingButton(
                isLoading: _isLoading,
                onPressed: () {
                  AutovalidateModeNotification(
                    AutovalidateMode.onUserInteraction,
                  ).dispatch(context);
                  if (_fbState?.saveAndValidate() ?? false) {
                    setState(() => _isLoading = true);
                    viewModel.editCriteria(
                      PatchCriteria(
                        name: _fbValues[
                            CreateEditCriteriaPageFormField.name.name],
                        coefficient: _fbValues[
                            CreateEditCriteriaPageFormField.coefficient.name],
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
  final Criteria? criteria;
  final Failure? failure;

  _ViewModel(super.store)
      : criteria = store.state.tablesState.getTables<Criteria>().selectedItem,
        failure = store.state.criteriasState.failure;

  void editCriteria(PatchCriteria criteria) {
    store.dispatch(UpdateCriteriaAction(criteria));
  }

  @override
  List<Object?> get props => [criteria, failure];
}
