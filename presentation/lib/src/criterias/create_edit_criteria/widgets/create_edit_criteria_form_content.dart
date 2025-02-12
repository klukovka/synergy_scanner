import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum CreateEditCriteriaPageFormField {
  name,
  coefficient;
}

class CreateEditCriteriaFormContent extends StatelessWidget {
  final Criteria? criteria;
  final Widget button;

  const CreateEditCriteriaFormContent({
    super.key,
    required this.button,
    this.criteria,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  FormBuilderTextField(
                    name: CreateEditCriteriaPageFormField.name.name,
                    initialValue: criteria?.name,
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
                  FormBuilderSlider(
                    name: CreateEditCriteriaPageFormField.coefficient.name,
                    initialValue: criteria?.coefficient ?? 0.5,
                    min: 0,
                    max: 1,
                    validator: (value) {
                      if (value == null) {
                        return context.strings.fieldRequired;
                      }
                      if (value == 0) {
                        return context.strings.valueShouldBeGraterThanZero;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: context.strings.coefficient,
                      prefixIcon: Icon(MdiIcons.heart),
                    ),
                  ),
                  const Spacer(),
                  button,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
