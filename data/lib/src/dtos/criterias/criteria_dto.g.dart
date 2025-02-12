// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criteria_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CriteriaDto _$CriteriaDtoFromJson(Map<String, dynamic> json) => CriteriaDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      coefficient: (json['coefficient'] as num).toDouble(),
      markId: (json['mark_id'] as num?)?.toInt(),
      mark: (json['mark'] as num?)?.toInt(),
      partnerId: (json['partner_id'] as num?)?.toInt(),
    );
