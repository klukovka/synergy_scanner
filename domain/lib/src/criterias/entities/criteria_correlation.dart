import 'package:domain/domain.dart';

class CriteriaCorrelation {
  final Criteria criteria;
  final int occurrences;
  final double correlation;

  CriteriaCorrelation({
    required this.criteria,
    required this.occurrences,
    required this.correlation,
  });
}
