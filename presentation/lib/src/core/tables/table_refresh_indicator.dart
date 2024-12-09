import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/general/indicators/universal_refresh_indicator.dart';

class TableRefreshIndicator<T extends TableItem<T>, P extends TablePointer>
    extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    Widget iosSliverRefreshIndicator,
  ) builder;
  final double edgeOffset;

  const TableRefreshIndicator({
    super.key,
    required this.builder,
    this.edgeOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: _ViewModel<T, P>.new,
      builder: (context, viewModel) => UniversalRefreshIndicator(
        edgeOffset: edgeOffset,
        onRefresh: viewModel.refresh,
        isLoading: viewModel.isLoading,
        builder: builder,
      ),
    );
  }
}

class _ViewModel<T extends TableItem<T>, P extends TablePointer>
    extends BaseViewModel {
  final bool isLoading;

  _ViewModel(super.store)
      : isLoading = store.state.tablesState.getTable<T, P>().isLoading;

  void refresh() {
    store.dispatch(
      DownloadTableItemsAction<T, P>(append: false, clear: false),
    );
  }

  @override
  List<Object?> get props => [isLoading];
}
