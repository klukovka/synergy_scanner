import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/general/dialogs/app_unexpected_error_dialog.dart';

class UnexpectedErrorDialog extends StatelessWidget {
  const UnexpectedErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: _ViewModel.new,
      builder: (context, viewModel) {
        return AppUnexpectedErrorDialog(
          onPressed: viewModel.close,
          title: viewModel.title,
          message: viewModel.message,
        );
      },
    );
  }
}

class _ViewModel extends BaseViewModel {
  final String? title;
  final String? message;
  final int closedPagesCount;

  _ViewModel(super.store)
      : title = store.state.errorState.title,
        message = store.state.errorState.message,
        closedPagesCount =
            store.state.errorState.shouldCloseCurrentPage ? 2 : 1;

  @override
  void close() {
    store.dispatch(ClosePageAction(count: closedPagesCount));
  }

  @override
  List<Object?> get props => [title, message, closedPagesCount];
}
