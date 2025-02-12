import 'package:equatable/equatable.dart';

class PatchCriteria extends Equatable {
  final String name;
  final double coefficient;

  PatchCriteria({
    required this.name,
    required this.coefficient,
  });

  @override
  List<Object> get props => [name, coefficient];
}
