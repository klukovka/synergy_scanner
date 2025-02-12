import 'package:domain/domain.dart';

class Partner with TableItem<Partner> {
  @override
  final int id;
  final String name;
  final PartnerType type;
  final String? avatarUrl;
  final double? averageMark;
  final Mark? mark;

  Partner({
    required this.id,
    required this.name,
    required this.type,
    required this.avatarUrl,
    this.averageMark,
    this.mark,
  });

  @override
  Partner merge(Partner another) => copyWith(
        id: another.id,
        name: another.name,
        type: another.type,
        avatarUrl: another.avatarUrl,
        averageMark: another.averageMark,
        mark: another.mark,
      );

  Partner copyWith({
    int? id,
    String? name,
    PartnerType? type,
    String? avatarUrl,
    double? averageMark,
    Mark? mark,
  }) {
    return Partner(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      averageMark: averageMark ?? this.averageMark,
      mark: mark ?? this.mark,
    );
  }
}
