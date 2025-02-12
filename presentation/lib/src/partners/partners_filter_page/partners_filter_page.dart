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
import 'package:presentation/src/partners/partners_filter_page/widgets/partners_type_filter_field.dart';

enum PartnersFilterPageFields {
  sortBy,
  direction,
  types,
}

class PartnersFilterPage<T extends TablePointer> extends StatefulWidget {
  final List<SortBy> sortingTypes;

  const PartnersFilterPage({
    super.key,
    required this.sortingTypes,
  });

  @override
  State<PartnersFilterPage<T>> createState() => _PartnersFilterPageState<T>();
}

class _PartnersFilterPageState<T extends TablePointer>
    extends State<PartnersFilterPage<T>> {
  final _fbKey = GlobalKey<FormBuilderState>();

  FormBuilderState? get _fbState => _fbKey.currentState;
  Map<String, dynamic> get _fbValues => _fbState?.value ?? {};

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: PartnersFiltersViewModel<T>.new,
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.sortBy != newViewModel.sortBy) {
          _fbState?.patchValue({
            PartnersFilterPageFields.sortBy.name: newViewModel.sortBy,
          });
        }

        if (previousViewModel?.types != newViewModel.types) {
          _fbState?.patchValue({
            PartnersFilterPageFields.types.name: newViewModel.types,
          });
        }

        if (previousViewModel?.direction != newViewModel.direction) {
          _fbState?.patchValue({
            PartnersFilterPageFields.direction.name: newViewModel.direction,
          });
        }
      },
      builder: (context, viewModel) {
        final fields = [
          SortByFormField(
            name: PartnersFilterPageFields.sortBy.name,
            initialValue: viewModel.sortBy,
            options: widget.sortingTypes,
            getLabel: (item) => switch (item) {
              SortBy.averageMark => context.strings.averageMark,
              SortBy.mark => context.strings.mark,
              SortBy.name => context.strings.name,
              SortBy.type => context.strings.type,
              _ => '',
            },
          ),
          DirectionFormField(
            name: PartnersFilterPageFields.direction.name,
            initialValue: viewModel.direction,
          ),
          PartnersTypeFilterField(
            initialValue: viewModel.types,
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
                PartnersFilterPageFields.sortBy.name: viewModel.sortBy,
                PartnersFilterPageFields.types.name: viewModel.types,
                PartnersFilterPageFields.direction.name: viewModel.direction,
              });
            },
            onApplyPressed: () {
              _fbState?.save();
              final List<PartnerType>? types =
                  _fbValues[PartnersFilterPageFields.types.name];
              viewModel.setFilter(
                Filter(
                  sortBy: _fbValues[PartnersFilterPageFields.sortBy.name],
                  direction: _fbValues[PartnersFilterPageFields.direction.name],
                  search: viewModel.filter.search,
                  filters: {
                    if (types != null)
                      FilterBy.type: types.map((item) => item.key).toList()
                  },
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

class PartnersFiltersViewModel<T extends TablePointer>
    extends TableViewModel<Partner, T> {
  PartnersFiltersViewModel(super.store);

  List<PartnerType>? get types =>
      filter.filters[FilterBy.type]?.map(PartnerType.fromString).toList();

  @override
  List<Object?> get props => [...super.props, types];
}
