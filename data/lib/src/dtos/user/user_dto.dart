import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class UserDto extends Dto<User> {
  final String id;
  final String name;
  final String email;
  final String? photo;

  UserDto({
    required this.id,
    required this.name,
    required this.photo,
    required this.email,
  });

  @override
  User toDomain() => User(
        id: id,
        fullname: name,
        avatarUrl: photo,
        email: email,
      );
}
