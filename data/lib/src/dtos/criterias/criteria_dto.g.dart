// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criteria_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CriteriaDto _$CriteriaDtoFromJson(Map<String, dynamic> json) => CriteriaDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      coefficient: (json['coefficient'] as num).toDouble(),
      marks: (json['marks'] as List<dynamic>?)
          ?.map((e) => MarkDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
