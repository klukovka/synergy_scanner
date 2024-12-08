import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localizations/localizations.dart';

class ImagesPickerField extends FormBuilderField<List<Uint8List>> {
  ImagesPickerField({
    super.key,
    required super.name,
    super.validator,
    List<Uint8List>? initialValue,
    InputDecoration decoration = const InputDecoration(),
    super.enabled,
    super.onChanged,
  }) : super(
          initialValue: initialValue ?? [],
          builder: (FormFieldState<List<Uint8List>> field) {
            final _FormBuilderImagePickerState state =
                field as _FormBuilderImagePickerState;
            return InputDecorator(
              decoration: decoration.copyWith(errorText: field.errorText),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: enabled ? state._pickImages : null,
                    child: Text(state.context.strings.pickImagesFromGallery),
                  ),
                  const SizedBox(height: 12),
                  if (field.value != null && field.value!.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      children: field.value!.map((imageData) {
                        return Image.memory(
                          imageData,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                    ),
                ],
              ),
            );
          },
        );

  @override
  FormBuilderFieldState<ImagesPickerField, List<Uint8List>> createState() =>
      _FormBuilderImagePickerState();
}

class _FormBuilderImagePickerState
    extends FormBuilderFieldState<ImagesPickerField, List<Uint8List>> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        final List<Uint8List> images = await Future.wait(
          pickedFiles.map((file) => file.readAsBytes()),
        );
        didChange(images);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
