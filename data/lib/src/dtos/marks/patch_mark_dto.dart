import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patch_mark_dto.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class PatchMarkDto {
  final int mark;
  final int criteriaId;
  final int partnerId;

  PatchMarkDto({
    required this.mark,
    required this.criteriaId,
    required this.partnerId,
  });

  factory PatchMarkDto.fromDomain(PatchMark mark) => PatchMarkDto(
        mark: mark.mark,
        criteriaId: mark.criteriaId,
        partnerId: mark.partnerId,
      );

  Map<String, dynamic> toJson() => _$PatchMarkDtoToJson(this);
}
