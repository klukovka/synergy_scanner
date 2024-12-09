import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class NewPartner extends Equatable {
  final String name;
  final PartnerType type;
  final NewImage? avatar;

  NewPartner({
    required this.name,
    required this.type,
    required this.avatar,
  });

  @override
  List<Object?> get props => [name, type, avatar];
}
