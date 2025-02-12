// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerDto _$PartnerDtoFromJson(Map<String, dynamic> json) => PartnerDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      avatarUrl: json['avatar_url'] as String?,
      averageMark: (json['average_mark'] as num?)?.toDouble(),
      markId: (json['mark_id'] as num?)?.toInt(),
      mark: (json['mark'] as num?)?.toInt(),
      criteriaId: (json['criteria_id'] as num?)?.toInt(),
    );
