import 'package:equatable/equatable.dart';

class Chunk<T> extends Equatable {
  final int fullCount;
  final Set<T> values;

  Chunk({
    required this.fullCount,
    required this.values,
  });

  @override
  List<Object?> get props => [fullCount, values];
}
