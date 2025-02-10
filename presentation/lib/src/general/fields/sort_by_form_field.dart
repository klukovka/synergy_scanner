import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localizations/localizations.dart';

class SortByFormField extends StatelessWidget {
  final String name;
  final SortBy? initialValue;
  final List<SortBy> options;
  final String Function(SortBy item) getLabel;

  const SortByFormField({
    super.key,
    required this.name,
    required this.initialValue,
    required this.options,
    required this.getLabel,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderRadioGroup(
      name: name,
      wrapDirection: Axis.vertical,
      orientation: OptionsOrientation.vertical,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: context.strings.sortBy,
      ),
      options: options
          .map((item) => FormBuilderFieldOption<SortBy>(
                value: item,
                child: Text(getLabel(item)),
              ))
          .toList(),
    );
  }
}
