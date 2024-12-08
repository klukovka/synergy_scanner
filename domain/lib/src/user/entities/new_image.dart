import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class NewImage extends Equatable {
  final Uint8List bytes;
  final String extension;
  final String? mimeType;

  NewImage({
    required this.bytes,
    required this.extension,
    required this.mimeType,
  });

  @override
  List<Object?> get props => [bytes, mimeType, extension];
}
