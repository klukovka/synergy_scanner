import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/extensions/partner_type_extension.dart';
import 'package:presentation/src/partners/partners_filter_page/partners_filter_page.dart';

class PartnersTypeFilterField extends StatelessWidget {
  final List<PartnerType>? initialValue;

  const PartnersTypeFilterField({
    super.key,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderCheckboxGroup(
      name: PartnersFilterPageFields.types.name,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: context.strings.type,
      ),
      options: PartnerType.values
          .map((item) => FormBuilderFieldOption(
                value: item,
                child: Text(item.getDisplayText(context)),
              ))
          .toList(),
    );
  }
}
