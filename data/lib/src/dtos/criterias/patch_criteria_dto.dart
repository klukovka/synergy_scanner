import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patch_criteria_dto.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class PatchCriteriaDto {
  final String name;
  final double coefficient;

  PatchCriteriaDto({
    required this.name,
    required this.coefficient,
  });

  factory PatchCriteriaDto.fromDomain(PatchCriteria criteria) =>
      PatchCriteriaDto(
        name: criteria.name,
        coefficient: criteria.coefficient,
      );

  Map<String, dynamic> toJson() => _$PatchCriteriaDtoToJson(this);
}
