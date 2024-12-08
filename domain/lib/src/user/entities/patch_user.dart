import 'dart:typed_data';

class PatchUser {
  final String email;
  final String name;
  final Uint8List? photo;

  PatchUser({
    required this.email,
    required this.name,
    required this.photo,
  });
}
