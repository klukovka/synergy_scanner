import 'package:domain/domain.dart';

class PatchUser {
  final String? email;
  final String? fullName;
  final NewImage? photo;

  PatchUser({
    required this.email,
    required this.fullName,
    required this.photo,
  });
}
