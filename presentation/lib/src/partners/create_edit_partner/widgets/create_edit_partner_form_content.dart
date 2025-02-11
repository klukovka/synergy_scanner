import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/core/extensions/partner_type_extension.dart';
import 'package:presentation/src/general/fields/avatar_picker_form_field.dart';

enum CreateEditPartnerPageFormField {
  avatar,
  name,
  type;
}

class CreateEditPartnerFormContent extends StatelessWidget {
  final Partner? partner;
  final Widget button;

  const CreateEditPartnerFormContent({
    super.key,
    this.partner,
    required this.button,
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
                  AvatarPickerFormField(
                    name: CreateEditPartnerPageFormField.avatar.name,
                    imageUrl: partner?.avatarUrl,
                    radius: 52,
                  ),
                  const SizedBox(height: 32),
                  FormBuilderTextField(
                    name: CreateEditPartnerPageFormField.name.name,
                    initialValue: partner?.name,
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
                  FormBuilderDropdown(
                    name: CreateEditPartnerPageFormField.type.name,
                    initialValue: partner?.type,
                    validator: (value) {
                      if (value == null) {
                        return context.strings.fieldRequired;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: context.strings.type,
                      prefixIcon: Icon(MdiIcons.heart),
                    ),
                    items: PartnerType.values
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item.getDisplayText(context)),
                          ),
                        )
                        .toList(),
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
