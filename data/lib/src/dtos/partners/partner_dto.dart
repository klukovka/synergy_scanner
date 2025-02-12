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
  final int? markId;
  final int? mark;
  final int? criteriaId;

  PartnerDto({
    required this.id,
    required this.name,
    required this.type,
    required this.avatarUrl,
    required this.averageMark,
    required this.markId,
    required this.mark,
    required this.criteriaId,
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
        mark: markId != null && mark != null && criteriaId != null
            ? Mark(
                id: markId!,
                mark: mark!,
                criteriaId: criteriaId!,
                partnerId: id,
              )
            : null,
      );
}
