import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/tables/table_view_model.dart';
import 'package:presentation/src/general/buttons/filter_button.dart';
import 'package:presentation/src/general/fields/search_field.dart';

class CriteriasTableActionBar extends StatelessWidget {
  const CriteriasTableActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: TableViewModel<Criteria, GeneralTablePointer>.new,
      builder: (context, viewModel) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: SearchField(
                hintText: context.strings.searchCriterias,
                isLoading: viewModel.isLoading,
                search: viewModel.search,
              ),
            ),
            const SizedBox(width: 16),
            FilterButton(
              isEmpty: viewModel.filter.isFilterByEmpty,
              onPressed: () => viewModel.openPage(Destination.criteriasFilters),
            ),
          ],
        ),
      ),
    );
  }
}
