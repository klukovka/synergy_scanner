import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class UserDto extends Dto<User> {
  final String id;
  final String fullName;
  final String email;
  final String? avatarUrl;

  UserDto({
    required this.id,
    required this.fullName,
    required this.avatarUrl,
    required this.email,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  @override
  User toDomain() => User(
        id: id,
        fullname: fullName,
        avatarUrl: avatarUrl,
        email: email,
      );
}
