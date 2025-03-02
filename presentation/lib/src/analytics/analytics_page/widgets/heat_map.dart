import 'dart:math';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:localizations/localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HeatMap extends StatelessWidget {
  final List<HeatMapData> items;

  const HeatMap({
    super.key,
    required this.items,
  });

  List<NumericMultiLevelLabel> _buildNumericLabels() {
    return List.generate(
      items.length,
      (index) => NumericMultiLevelLabel(
        start: index * 20 + 1,
        end: index * 20 + 20,
        text: items[index].criteria.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: const CategoryAxis(
        axisLine: AxisLine(width: 0),
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
      primaryYAxis: NumericAxis(
        opposedPosition: true,
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        labelStyle: const TextStyle(fontSize: 0),
        multiLevelLabelStyle:
            const MultiLevelLabelStyle(borderColor: Colors.transparent),
        multiLevelLabels: _buildNumericLabels(),
        multiLevelLabelFormatter: (details) => ChartAxisLabel(
          details.text,
          const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
      ),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.top,
        toggleSeriesVisibility: false,
        legendItemBuilder: (legendText, series, point, seriesIndex) {
          return Row(
            children: [
              const Text('0 '),
              const SizedBox(width: 5),
              SizedBox(
                  width: 150,
                  height: 20,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.4),
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.9),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  )),
              const SizedBox(width: 5),
              const Text('1'),
            ],
          );
        },
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: context.strings.correlation,
        animationDuration: 0,
        tooltipPosition: TooltipPosition.pointer,
        format: 'point.x : point.y',
      ),
      series: List.generate(items.length, (index) {
        return StackedBar100Series<HeatMapData, String>(
          dataSource: items,
          xValueMapper: (HeatMapData data, int _) => data.criteria.name,
          yValueMapper: (HeatMapData data, int _) =>
              _findValueByIndex(data, index),
          pointColorMapper: (HeatMapData data, int _) {
            final value = _findValueByIndex(data, index);
            return Theme.of(context).colorScheme.primary.withOpacity(
                  value < 0 ? 0 : min(value, 1),
                );
          },
          isVisibleInLegend: index == 0,
          animationDuration: 0,
          width: 1,
          borderWidth: 1,
          borderColor: Theme.of(context).colorScheme.primary,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.middle,
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          onCreateRenderer: (ChartSeries<HeatMapData, String> series) {
            return _HeatmapSeriesRenderer();
          },
        );
      }),
    );
  }

  double _findValueByIndex(HeatMapData data, int index) {
    final criteria = items[index].criteria;
    final correlation =
        data.correlation.firstWhereOrNull((item) => item.criteria == criteria);
    return correlation?.correlation ?? 1;
  }
}

class HeatMapData {
  final Criteria criteria;
  final List<CriteriaCorrelation> correlation;

  HeatMapData(
    this.criteria,
    this.correlation,
  );
}

class _HeatmapSeriesRenderer
    extends StackedBar100SeriesRenderer<HeatMapData, String> {
  _HeatmapSeriesRenderer();

  @override
  void populateDataSource(
      [List<ChartValueMapper<HeatMapData, num>>? yPaths,
      List<List<num>>? chaoticYLists,
      List<List<num>>? yLists,
      List<ChartValueMapper<HeatMapData, Object>>? fPaths,
      List<List<Object?>>? chaoticFLists,
      List<List<Object?>>? fLists]) {
    super.populateDataSource(
        yPaths, chaoticYLists, yLists, fPaths, chaoticFLists, fLists);

    // Always keep positive 0 to 101 range even set negative value.
    yMin = 0;
    yMax = 101;

    // Calculate heatmap segment top and bottom values.
    _computeHeatMapValues();
  }

  void _computeHeatMapValues() {
    if (xAxis == null || yAxis == null) {
      return;
    }

    if (yAxis!.dependents.isEmpty) {
      return;
    }

    // Get the number of series dependent on the yAxis.
    final int seriesLength = yAxis!.dependents.length;
    // Calculate the proportional height for each series
    // (as a percentage of the total height).
    final num yValue = 100 / seriesLength;
    // Loop through each dependent series to calculate top and bottom values for
    // the heatmap.
    for (int i = 0; i < seriesLength; i++) {
      // Check if the current series is a '_HeatmapSeriesRenderer'.
      if (yAxis!.dependents[i] is _HeatmapSeriesRenderer) {
        final _HeatmapSeriesRenderer current =
            yAxis!.dependents[i] as _HeatmapSeriesRenderer;

        // Skip processing if the series is not visible or has no data.
        if (!current.controller.isVisible || current.dataCount == 0) {
          continue;
        }

        // Calculate the bottom (stack) value for the current series.
        num stackValue = 0;
        stackValue = yValue * i;

        current.topValues.clear();
        current.bottomValues.clear();

        // Loop through the data points in the current series.
        final int length = current.dataCount;
        for (int j = 0; j < length; j++) {
          // Add the bottom value (stackValue) for the current data point.
          current.bottomValues.add(stackValue.toDouble());
          // Add the top value (stackValue + yValue) for the current data point.
          current.topValues.add((stackValue + yValue).toDouble());
        }
      }
    }
  }
}
