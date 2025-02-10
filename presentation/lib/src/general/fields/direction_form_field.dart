import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localizations/localizations.dart';

class DirectionFormField extends StatelessWidget {
  final String name;
  final Direction initialValue;

  const DirectionFormField({
    super.key,
    required this.name,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderRadioGroup(
      name: name,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: context.strings.direction,
      ),
      options: Direction.values
          .map((item) => FormBuilderFieldOption(
                value: item,
                child: Text(switch (item) {
                  Direction.asc => context.strings.acs,
                  Direction.desc => context.strings.desc,
                }),
              ))
          .toList(),
    );
  }
}
