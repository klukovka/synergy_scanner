import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/app_bar/mobile_app_bar.dart';
import 'package:presentation/src/core/tables/table_view_model.dart';
import 'package:presentation/src/general/buttons/filter_buttons.dart';
import 'package:presentation/src/general/fields/direction_form_field.dart';
import 'package:presentation/src/general/fields/sort_by_form_field.dart';

enum CriteriasFilterPageFields {
  sortBy,
  direction,
}

class CriteriasFilterPage<T extends TablePointer> extends StatefulWidget {
  final List<SortBy> sortingOptions;

  const CriteriasFilterPage({
    super.key,
    required this.sortingOptions,
  });

  @override
  State<CriteriasFilterPage<T>> createState() => _CriteriasFilterPageState<T>();
}

class _CriteriasFilterPageState<T extends TablePointer>
    extends State<CriteriasFilterPage<T>> {
  final _fbKey = GlobalKey<FormBuilderState>();

  FormBuilderState? get _fbState => _fbKey.currentState;
  Map<String, dynamic> get _fbValues => _fbState?.value ?? {};

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: TableViewModel<Criteria, T>.new,
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.sortBy != newViewModel.sortBy) {
          _fbState?.patchValue({
            CriteriasFilterPageFields.sortBy.name: newViewModel.sortBy,
          });
        }

        if (previousViewModel?.direction != newViewModel.direction) {
          _fbState?.patchValue({
            CriteriasFilterPageFields.direction.name: newViewModel.direction,
          });
        }
      },
      builder: (context, viewModel) {
        final fields = [
          SortByFormField(
            name: CriteriasFilterPageFields.sortBy.name,
            initialValue: viewModel.sortBy,
            options: widget.sortingOptions,
            getLabel: (item) => switch (item) {
              SortBy.coefficient => context.strings.coefficient,
              SortBy.name => context.strings.name,
              SortBy.mark => context.strings.mark,
              _ => '',
            },
          ),
          DirectionFormField(
            name: CriteriasFilterPageFields.direction.name,
            initialValue: viewModel.direction,
          ),
        ];
        return Scaffold(
          appBar: const MobileAppBar(),
          body: FormBuilder(
            key: _fbKey,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => fields[index],
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: fields.length,
            ),
          ),
          bottomNavigationBar: FilterButtons(
            onResetPressed: () {
              _fbState?.patchValue({
                CriteriasFilterPageFields.sortBy.name: viewModel.sortBy,
                CriteriasFilterPageFields.direction.name: viewModel.direction,
              });
            },
            onApplyPressed: () {
              _fbState?.save();

              viewModel.setFilter(
                Filter(
                  sortBy: _fbValues[CriteriasFilterPageFields.sortBy.name],
                  direction:
                      _fbValues[CriteriasFilterPageFields.direction.name],
                  search: viewModel.filter.search,
                ),
              );
            },
            isLoading: viewModel.isLoading,
          ),
        );
      },
    );
  }
}
