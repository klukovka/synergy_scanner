import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'partner_dto.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class PartnerDto extends Dto<Partner> {
  final int id;
  final String name;
  final String type;
  final String? avatarUrl;
  final double? averageMark;

  PartnerDto({
    required this.id,
    required this.name,
    required this.type,
    required this.avatarUrl,
    required this.averageMark,
  });

  factory PartnerDto.fromJson(Map<String, dynamic> json) =>
      _$PartnerDtoFromJson(json);

  @override
  Partner toDomain() => Partner(
        id: id,
        name: name,
        type: PartnerType.fromString(type),
        avatarUrl: avatarUrl,
        averageMark: averageMark,
      );
}
