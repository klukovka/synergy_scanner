// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criterias_correlation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CriteriasCorrelationDto _$CriteriasCorrelationDtoFromJson(
        Map<String, dynamic> json) =>
    CriteriasCorrelationDto(
      criteriaId1: (json['criteria_id_1'] as num).toInt(),
      criteriaName1: json['criteria_name_1'] as String,
      criteriaId2: (json['criteria_id_2'] as num).toInt(),
      criteriaName2: json['criteria_name_2'] as String,
      occurrences: (json['occurrences'] as num).toInt(),
      correlation: (json['correlation'] as num).toDouble(),
    );
