import 'package:domain/domain.dart';

class CriteriasCorrelation {
  final Criteria criteria;
  final int occurrences;
  final double correlation;

  CriteriasCorrelation({
    required this.criteria,
    required this.occurrences,
    required this.correlation,
  });
}
