import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class UserDto extends Dto<User> {
  final int id;
  final String name;
  final String? photo;

  UserDto({
    required this.id,
    required this.name,
    required this.photo,
  });

  @override
  User toDomain() => User(id: id, name: name, photo: photo);
}
