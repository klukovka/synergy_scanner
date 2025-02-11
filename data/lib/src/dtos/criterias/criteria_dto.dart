import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/dtos/marks/mark_dto.dart';
import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'criteria_dto.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class CriteriaDto extends Dto<Criteria> {
  final int id;
  final String name;
  final double coefficient;
  final List<MarkDto>? marks;

  CriteriaDto({
    required this.id,
    required this.name,
    required this.coefficient,
    this.marks,
  });

  factory CriteriaDto.fromJson(Map<String, dynamic> json) =>
      _$CriteriaDtoFromJson(json);

  @override
  Criteria toDomain() => Criteria(
        id: id,
        name: name,
        coefficient: coefficient,
        marks: marks?.map((item) => item.toDomain()).toList(),
      );
}
