import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/core/tables/table_refresh_indicator.dart';
import 'package:presentation/src/core/tables/table_view_model.dart';
import 'package:presentation/src/general/placeholders/empty_table_placeholder.dart';
import 'package:presentation/src/general/scroll/load_more_scroll_listener.dart';
import 'package:presentation/src/home/home_page_tab_type.dart';
import 'package:presentation/src/partners/widgets/partner_card.dart';

class PartnersTable extends StatelessWidget {
  const PartnersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: _ViewModel.new,
      ignoreChange: _ViewModel.ignoreChange,
      builder: (context, viewModel) {
        return LoadMoreScrollListener(
          loadMore: viewModel.downloadItems,
          child: TableRefreshIndicator<Partner, GeneralTablePointer>(
            builder: (context, iosRefreshIndicator) => CustomScrollView(
              slivers: [
                iosRefreshIndicator,
                if (viewModel.items.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyTablePlaceholder(
                      isLoading: viewModel.isLoading,
                      title: Text(context.strings.noPartnersFound),
                      subtitle: Text(
                        viewModel.filter.isEmpty
                            ? context.strings.addYourFirstPartner
                            : context.strings.changeYourSearchQuery,
                      ),
                      icon: Icon(HomePageTabType.partners.activeIconData),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => PartnerCard(
                        key: ValueKey(viewModel.items[index].id),
                        onPressed: () => viewModel.openPartnerPage(
                          viewModel.items[index].id,
                        ),
                        partner: viewModel.items[index],
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

class _ViewModel extends TableViewModel<Partner, GeneralTablePointer> {
  _ViewModel(super.store);

  static bool ignoreChange(AppState state) =>
      state.tablesState.getTable<Partner, GeneralTablePointer>().isLoading &&
      state.tablesState
          .getTable<Partner, GeneralTablePointer>()
          .items
          .isNotEmpty;

  void openPartnerPage(int id) {
    store.dispatch(SetSelectedIdAction<Partner>(id));
    openPage(Destination.partnerDetails);
  }
}
