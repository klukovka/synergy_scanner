import 'dart:typed_data';

import 'package:flutter/material.dart';

class CustomMemoryImage extends StatelessWidget {
  final BorderRadius borderRadius;
  final Uint8List bytes;
  final double? height;
  final double? width;

  const CustomMemoryImage({
    super.key,
    this.borderRadius = BorderRadius.zero,
    required this.bytes,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: MemoryImage(bytes),
        ),
      ),
    );
  }
}
