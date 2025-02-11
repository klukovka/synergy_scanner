import 'package:domain/domain.dart';

class Criteria with TableItem<Criteria> {
  @override
  final int id;
  final String name;
  final double coefficient;
  final List<Mark>? marks;

  Criteria({
    required this.id,
    required this.name,
    required this.coefficient,
    required this.marks,
  });

  Mark? get mark => marks?.firstOrNull();

  @override
  Criteria merge(Criteria another) => copyWith(
        id: another.id,
        name: another.name,
        coefficient: another.coefficient,
        marks: another.marks,
      );

  Criteria copyWith({
    int? id,
    String? name,
    double? coefficient,
    List<Mark>? marks,
  }) {
    return Criteria(
      id: id ?? this.id,
      name: name ?? this.name,
      coefficient: coefficient ?? this.coefficient,
      marks: marks ?? this.marks,
    );
  }
}
