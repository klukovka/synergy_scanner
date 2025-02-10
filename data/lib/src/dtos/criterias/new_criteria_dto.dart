import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_criteria_dto.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class NewCriteriaDto {
  final String name;
  final double coefficient;

  NewCriteriaDto({
    required this.name,
    required this.coefficient,
  });

  factory NewCriteriaDto.fromDomain(NewCriteria criteria) => NewCriteriaDto(
        name: criteria.name,
        coefficient: criteria.coefficient,
      );

  Map<String, dynamic> toJson() => _$NewCriteriaDtoToJson(this);
}
