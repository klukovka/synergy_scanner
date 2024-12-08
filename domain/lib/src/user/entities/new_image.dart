import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class NewImage extends Equatable {
  final Uint8List bytes;
  final String filepath;
  final String mimeType;

  NewImage({
    required this.bytes,
    required String name,
    required String extension,
    required this.mimeType,
  }) : filepath = '$name.$extension';

  @override
  List<Object> get props => [bytes, filepath, mimeType];
}
