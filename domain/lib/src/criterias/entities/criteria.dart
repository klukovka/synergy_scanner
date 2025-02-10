import 'package:domain/domain.dart';

class Criteria with TableItem<Criteria> {
  @override
  final int id;
  final String name;
  final double coefficient;

  Criteria({
    required this.id,
    required this.name,
    required this.coefficient,
  });

  @override
  Criteria merge(Criteria another) => copyWith(
        id: another.id,
        name: another.name,
        coefficient: another.coefficient,
      );

  Criteria copyWith({
    int? id,
    String? name,
    double? coefficient,
  }) {
    return Criteria(
      id: id ?? this.id,
      name: name ?? this.name,
      coefficient: coefficient ?? this.coefficient,
    );
  }
}
