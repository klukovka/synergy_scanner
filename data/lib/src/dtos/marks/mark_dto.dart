import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mark_dto.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MarkDto extends Dto<Mark> {
  final int id;
  final int mark;
  final int criteriaId;
  final int partnerId;

  MarkDto({
    required this.id,
    required this.mark,
    required this.criteriaId,
    required this.partnerId,
  });

  factory MarkDto.fromJson(Map<String, dynamic> json) =>
      _$MarkDtoFromJson(json);

  @override
  Mark toDomain() => Mark(
        id: id,
        mark: mark,
        criteriaId: criteriaId,
        partnerId: partnerId,
      );
}
