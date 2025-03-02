import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/analytics/analytics_page/widgets/heat_map.dart';

class CriteriasHeatMap extends StatelessWidget {
  final Map<Criteria, List<CriteriaCorrelation>> items;

  const CriteriasHeatMap({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: items.length * 100),
        child: HeatMap(
            items: items.entries
                .map((entry) => HeatMapData(
                      entry.key,
                      entry.value,
                    ))
                .toList()),
      ),
    );
  }
}
