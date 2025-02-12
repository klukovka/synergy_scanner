import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/general/fields/sort_by_form_field.dart';
import 'package:presentation/src/partners/partners_filter_page/partners_filter_page.dart';

class PartnersSortByField extends StatelessWidget {
  final SortBy? initialValue;

  const PartnersSortByField({
    super.key,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SortByFormField(
      name: PartnersFilterPageFields.sortBy.name,
      initialValue: initialValue,
      options: const [SortBy.averageMark, SortBy.name, SortBy.type],
      getLabel: (item) => switch (item) {
        SortBy.averageMark => context.strings.averageMark,
        SortBy.name => context.strings.name,
        SortBy.type => context.strings.type,
        _ => '',
      },
    );
  }
}
