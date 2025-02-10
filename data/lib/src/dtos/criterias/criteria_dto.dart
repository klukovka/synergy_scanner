import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'criteria_dto.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class CriteriaDto extends Dto<Criteria> {
  final int id;
  final String name;
  final double coefficient;

  CriteriaDto({
    required this.id,
    required this.name,
    required this.coefficient,
  });

  factory CriteriaDto.fromJson(Map<String, dynamic> json) =>
      _$CriteriaDtoFromJson(json);

  @override
  Criteria toDomain() => Criteria(
        id: id,
        name: name,
        coefficient: coefficient,
      );
}
