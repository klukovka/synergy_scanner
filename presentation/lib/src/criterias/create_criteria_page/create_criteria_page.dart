import 'package:clean_redux/clean_redux.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:presentation/src/core/base_view_model.dart';

enum CreatePartnerPageFormField {
  avatar,
  name,
  type;
}

class CreateCriteriaPage extends StatefulWidget {
  const CreateCriteriaPage({super.key});

  @override
  State<CreateCriteriaPage> createState() => _CreateCriteriaPageState();
}

class _CreateCriteriaPageState extends State<CreateCriteriaPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  final bool _isLoading = false;

  FormBuilderState? get _fbState => _fbKey.currentState;
  Map<String, dynamic> get _fbValues => _fbState?.value ?? {};

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _ViewModel extends BaseViewModel {
  final int? partnerId;
  final Failure? failure;

  _ViewModel(super.store)
      : partnerId =
            store.state.tablesState.getTables<Criteria>().selectedItemId,
        failure = store.state.partnersState.failure;

  @override
  List<Object?> get props => [partnerId, failure];
}
