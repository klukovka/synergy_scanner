import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:localizations/localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PartnersHistogram extends StatelessWidget {
  final List<Partner> items;
  final int zoom;

  const PartnersHistogram({
    super.key,
    required this.items,
    required this.zoom,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: context.strings.averageMark,
      ),
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: const NumericAxis(
        minimum: 0,
        maximum: 5,
        interval: 0.5,
      ),
      series: <CartesianSeries<Partner, String>>[
        ColumnSeries<Partner, String>(
          dataSource: items.length < zoom
              ? List.generate(zoom, (index) {
                  if (index < items.length) {
                    return items[index];
                  }
                  return Partner(
                    id: -1,
                    name: '      ',
                    type: PartnerType.ex,
                    avatarUrl: null,
                    averageMark: 0,
                  );
                })
              : items,
          xValueMapper: (Partner data, index) => data.name,
          yValueMapper: (Partner data, _) => data.averageMark,
          color: Theme.of(context).colorScheme.primary,
        )
      ],
    );
  }
}
