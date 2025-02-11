import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_mark_dto.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class NewMarkDto {
  final int mark;
  final int criteriaId;
  final int partnerId;

  NewMarkDto({
    required this.mark,
    required this.criteriaId,
    required this.partnerId,
  });

  factory NewMarkDto.fromDomain(NewMark mark) => NewMarkDto(
        mark: mark.mark,
        criteriaId: mark.criteriaId,
        partnerId: mark.partnerId,
      );

  Map<String, dynamic> toJson() => _$NewMarkDtoToJson(this);
}
