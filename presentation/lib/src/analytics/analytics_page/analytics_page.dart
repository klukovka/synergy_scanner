import 'package:flutter/material.dart';
import 'package:presentation/src/analytics/analytics_page/widgets/criterias_stated_heat_map.dart';
import 'package:presentation/src/analytics/analytics_page/widgets/partners_rating_stated_histogram.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              PartnersRatingHistogram(),
              SizedBox(height: 8),
              CriteriasStatedHeatMap(),
            ],
          ),
        ),
      ),
    );
  }
}
