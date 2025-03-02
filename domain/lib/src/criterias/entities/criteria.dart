import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

class Criteria extends Equatable with TableItem<Criteria> {
  @override
  final int id;
  final String name;
  final double coefficient;
  final Mark? mark;

  Criteria({
    required this.id,
    required this.name,
    this.coefficient = 0,
    this.mark,
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

  @override
  List<Object?> get props => [id, name, coefficient, mark];
}
