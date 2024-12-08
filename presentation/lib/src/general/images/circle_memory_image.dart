import 'dart:typed_data';

import 'package:flutter/material.dart';

class CircleMemoryImage extends StatefulWidget {
  final double radius;
  final Uint8List? imageBytes;
  final Widget placeholder;
  final Color? backgroundColor;

  const CircleMemoryImage({
    super.key,
    required this.placeholder,
    this.radius = 24,
    this.imageBytes,
    this.backgroundColor,
  });

  @override
  State<CircleMemoryImage> createState() => _CircleMemoryImageState();
}

class _CircleMemoryImageState extends State<CircleMemoryImage> {
  ImageProvider? _image;
  bool _hasError = false;

  @override
  void initState() {
    _image = widget.imageBytes == null ? null : MemoryImage(widget.imageBytes!);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CircleMemoryImage oldWidget) {
    if (widget.imageBytes != null &&
        widget.imageBytes != oldWidget.imageBytes) {
      final image = MemoryImage(widget.imageBytes!);
      precacheImage(image, context).then((value) {
        if (mounted) {
          setState(() {
            _image = image;
            _hasError = false;
          });
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final hasForegroundImage = _image != null && !_hasError;

    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: widget.backgroundColor ?? Colors.transparent,
      foregroundImage: hasForegroundImage ? _image : null,
      onForegroundImageError: hasForegroundImage
          ? (error, stackTrace) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() => _hasError = true);
                }
              });
            }
          : null,
      child: widget.imageBytes == null || _hasError ? widget.placeholder : null,
    );
  }
}
