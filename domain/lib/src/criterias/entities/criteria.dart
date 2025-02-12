import 'package:domain/domain.dart';

class Criteria with TableItem<Criteria> {
  @override
  final int id;
  final String name;
  final double coefficient;
  final Mark? mark;

  Criteria({
    required this.id,
    required this.name,
    required this.coefficient,
    required this.mark,
  });

  @override
  Criteria merge(Criteria another) => copyWith(
        id: another.id,
        name: another.name,
        coefficient: another.coefficient,
        mark: another.mark,
      );

  Criteria copyWith({
    int? id,
    String? name,
    double? coefficient,
    Mark? mark,
  }) {
    return Criteria(
      id: id ?? this.id,
      name: name ?? this.name,
      coefficient: coefficient ?? this.coefficient,
      mark: mark ?? this.mark,
    );
  }
}
