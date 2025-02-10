import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/criterias/criterias_filter_page/criterias_filter_page.dart';
import 'package:presentation/src/general/fields/sort_by_form_field.dart';

class CriteriasSortByField extends StatelessWidget {
  final SortBy? initialValue;

  const CriteriasSortByField({
    super.key,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SortByFormField(
      name: CriteriasFilterPageFields.sortBy.name,
      initialValue: initialValue,
      options: const [SortBy.name, SortBy.coefficient],
      getLabel: (item) => switch (item) {
        SortBy.coefficient => context.strings.coefficient,
        SortBy.name => context.strings.name,
        _ => '',
      },
    );
  }
}
