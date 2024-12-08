import 'dart:typed_data';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:presentation/src/general/images/avatar_picker.dart';

class AvatarPickerFormField extends FormBuilderField<Uint8List> {
  AvatarPickerFormField({
    super.key,
    required super.name,
    super.validator,
    super.onChanged,
    super.autovalidateMode,
    super.initialValue,
    String? imageUrl,
    double radius = 40,
  }) : super(
          builder: (state) => AvatarPicker(
            imageBytes: state.value,
            onPick: state.didChange,
            imageUrl: imageUrl,
            radius: radius,
          ),
        );
}
