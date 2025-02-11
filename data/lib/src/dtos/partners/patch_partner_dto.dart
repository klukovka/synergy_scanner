import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patch_partner_dto.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class PatchPartnerDto {
  final String name;
  final String type;

  PatchPartnerDto({
    required this.name,
    required this.type,
  });

  factory PatchPartnerDto.fromDomain(PatchPartner partner) => PatchPartnerDto(
        name: partner.name,
        type: partner.type.key,
      );

  Map<String, dynamic> toJson() => _$PatchPartnerDtoToJson(this);
}
