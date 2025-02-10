import 'package:equatable/equatable.dart';

class NewCriteria extends Equatable {
  final String name;
  final double coefficient;

  NewCriteria({
    required this.name,
    required this.coefficient,
  });

  @override
  List<Object> get props => [name, coefficient];
}
