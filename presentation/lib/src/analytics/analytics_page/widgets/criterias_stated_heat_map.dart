import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/analytics/analytics_page/widgets/criterias_heat_map.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/general/loaders/styled_loader/styled_loader.dart';

class CriteriasStatedHeatMap extends StatelessWidget {
  const CriteriasStatedHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: _ViewModel.new,
      builder: (context, viewModel) {
        return Column(
          children: [
            Text(
              context.strings.criteriasCorrelation,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                CriteriasHeatMap(items: viewModel.items ?? {}),
                if (viewModel.items == null)
                  const StyledLoader.onSecondaryContainer(),
              ],
            )
          ],
        );
      },
    );
  }
}

class _ViewModel extends BaseViewModel {
  final Map<Criteria, List<CriteriaCorrelation>>? items;

  _ViewModel(super.store) : items = store.state.criteriasState.correlations;

  @override
  List<Object?> get props => [items];
}
