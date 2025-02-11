import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class PatchPartner extends Equatable {
  final String name;
  final PartnerType type;
  final NewImage? avatar;

  PatchPartner({
    required this.name,
    required this.type,
    required this.avatar,
  });

  @override
  List<Object?> get props => [name, type, avatar];
}
