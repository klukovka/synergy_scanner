import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/analytics/analytics_page/widgets/partners_histogram.dart';
import 'package:presentation/src/core/tables/table_view_model.dart';
import 'package:presentation/src/general/buttons/icon_circle_button.dart';
import 'package:presentation/src/general/loaders/styled_loader/styled_loader.dart';

class PartnersRatingHistogram extends StatelessWidget {
  const PartnersRatingHistogram({super.key});

  @override
  Widget build(BuildContext context) {
    int page = 0;
    int zoom = 5;
    return StatefulBuilder(
      builder: (context, setState) => StoreConnector(
        distinct: true,
        converter: TableViewModel<Partner, AnalyticsTablePointer>.new,
        builder: (context, viewModel) {
          final items = viewModel.items.skip(page * zoom).take(zoom).toList();
          return Column(
            children: [
              Text(
                context.strings.partnersRating,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconCircleButton.arrowBack(
                    onPressed: page == 0
                        ? null
                        : () {
                            if (page != 0) {
                              setState(() => page--);
                            }
                          },
                  ),
                  const SizedBox(width: 4),
                  IconCircleButton.arrowForward(
                    onPressed: viewModel.isLoading ||
                            (items.length < zoom &&
                                viewModel.items.length == viewModel.fullCount)
                        ? null
                        : () {
                            if (items.length < zoom) {
                              viewModel.downloadItems();
                            } else {
                              setState(() => page++);
                            }
                          },
                  ),
                  const Spacer(),
                  IconCircleButton.add(
                      onPressed: zoom == 3
                          ? null
                          : () {
                              setState(() => zoom--);
                            }),
                  const SizedBox(width: 4),
                  IconCircleButton.substract(
                      onPressed: zoom == 10
                          ? null
                          : () {
                              setState(() => zoom++);
                            }),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PartnersHistogram(items: items, zoom: zoom),
                    if (viewModel.isLoading)
                      const StyledLoader.onSecondaryContainer(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
