import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/tables/table_refresh_indicator.dart';
import 'package:presentation/src/core/tables/table_view_model.dart';
import 'package:presentation/src/criterias/criterias_page/widgets/criteria_card.dart';
import 'package:presentation/src/general/placeholders/empty_table_placeholder.dart';
import 'package:presentation/src/general/scroll/load_more_scroll_listener.dart';
import 'package:presentation/src/home/home_page_tab_type.dart';

class CriteriasTable extends StatelessWidget {
  const CriteriasTable({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: _ViewModel.new,
      ignoreChange: _ViewModel.ignoreChange,
      builder: (context, viewModel) {
        return LoadMoreScrollListener(
          loadMore: viewModel.downloadItems,
          child: TableRefreshIndicator<Criteria, GeneralTablePointer>(
            builder: (context, iosRefreshIndicator) => CustomScrollView(
              slivers: [
                iosRefreshIndicator,
                if (viewModel.items.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyTablePlaceholder(
                      isLoading: viewModel.isLoading,
                      title: Text(context.strings.noCriteriasFound),
                      subtitle: Text(
                        viewModel.filter.isEmpty
                            ? context.strings.addYourFirstCriteria
                            : context.strings.changeYourSearchQuery,
                      ),
                      icon: Icon(HomePageTabType.criterias.activeIconData),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => CriteriaCard(
                        key: ValueKey(viewModel.items[index].id),
                        onPressed: () {},
                        criteria: viewModel.items[index],
                      ),
                      childCount: viewModel.items.length,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel extends TableViewModel<Criteria, GeneralTablePointer> {
  _ViewModel(super.store);

  static bool ignoreChange(AppState state) =>
      state.tablesState.getTable<Criteria, GeneralTablePointer>().isLoading &&
      state.tablesState
          .getTable<Criteria, GeneralTablePointer>()
          .items
          .isNotEmpty;
}
