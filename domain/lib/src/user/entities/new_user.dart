import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class NewUser extends Equatable {
  final String email;
  final String password;
  final String name;
  final NewImage? photo;

  NewUser({
    required this.email,
    required this.password,
    required this.name,
    required this.photo,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        name,
        photo,
      ];
}
