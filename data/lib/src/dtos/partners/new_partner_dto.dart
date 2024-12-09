import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_partner_dto.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class NewPartnerDto {
  final String name;
  final String type;

  NewPartnerDto({
    required this.name,
    required this.type,
  });

  factory NewPartnerDto.fromDomain(NewPartner partner) => NewPartnerDto(
        name: partner.name,
        type: partner.type.key,
      );

  Map<String, dynamic> toJson() => _$NewPartnerDtoToJson(this);
}
