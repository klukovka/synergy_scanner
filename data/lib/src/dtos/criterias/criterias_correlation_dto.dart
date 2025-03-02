import 'package:json_annotation/json_annotation.dart';

part 'criterias_correlation_dto.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class CriteriasCorrelationDto {
  @JsonKey(name: 'criteria_id_1')
  final int criteriaId1;
  @JsonKey(name: 'criteria_name_1')
  final String criteriaName1;
  @JsonKey(name: 'criteria_id_2')
  final int criteriaId2;
  @JsonKey(name: 'criteria_name_2')
  final String criteriaName2;
  final int occurrences;
  final double correlation;

  CriteriasCorrelationDto({
    required this.criteriaId1,
    required this.criteriaName1,
    required this.criteriaId2,
    required this.criteriaName2,
    required this.occurrences,
    required this.correlation,
  });

  factory CriteriasCorrelationDto.fromJson(Map<String, dynamic> json) =>
      _$CriteriasCorrelationDtoFromJson(json);
}
