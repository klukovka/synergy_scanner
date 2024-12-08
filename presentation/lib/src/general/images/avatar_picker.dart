import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presentation/src/general/images/avatar.dart';

class AvatarPicker extends StatefulWidget {
  final Uint8List? imageBytes;
  final ValueChanged<Uint8List?> onPick;
  final String? imageUrl;
  final double radius;

  const AvatarPicker({
    super.key,
    required this.imageBytes,
    required this.onPick,
    this.imageUrl,
    this.radius = 40,
  });

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  static final imagePicker = ImagePicker();

  Future<Uint8List?> _pickImage() async {
    return imagePicker
        .pickImage(
          source: ImageSource.gallery,
          maxHeight: 440,
          maxWidth: 440,
        )
        .timeout(const Duration(minutes: 3))
        .then((file) async {
      if (file != null) {
        return await file.readAsBytes();
      }
      return null;
    });
  }

  Future<void> _onPressed() async {
    final image = await _pickImage();
    widget.onPick.call(image);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Avatar(
        radius: widget.radius,
        imageUrl: widget.imageUrl,
        imageBytes: widget.imageBytes,
      ),
    );
  }
}
