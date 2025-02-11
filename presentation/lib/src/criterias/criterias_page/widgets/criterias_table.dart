import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/tables/table_refresh_indicator.dart';
import 'package:presentation/src/core/tables/table_view_model.dart';
import 'package:presentation/src/general/placeholders/empty_table_placeholder.dart';
import 'package:presentation/src/general/scroll/load_more_scroll_listener.dart';
import 'package:presentation/src/home/home_page_tab_type.dart';

class CriteriasTable<T extends TablePointer> extends StatelessWidget {
  final Widget Function(BuildContext context, Criteria criteria) itemBuilder;

  const CriteriasTable({
    super.key,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: _ViewModel<T>.new,
      ignoreChange: (AppState state) => _ViewModel.ignoreChange<T>(state),
      builder: (context, viewModel) {
        return LoadMoreScrollListener(
          loadMore: viewModel.downloadItems,
          child: TableRefreshIndicator<Criteria, T>(
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
                      (context, index) => itemBuilder(
                        context,
                        viewModel.items[index],
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

class _ViewModel<T extends TablePointer> extends TableViewModel<Criteria, T> {
  _ViewModel(super.store);

  static bool ignoreChange<T extends TablePointer>(AppState state) =>
      state.tablesState.getTable<Criteria, T>().isLoading &&
      state.tablesState.getTable<Criteria, T>().items.isNotEmpty;
}
