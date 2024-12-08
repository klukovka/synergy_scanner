import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

abstract class BaseViewModel extends Equatable {
  @protected
  final Store<AppState> store;

  const BaseViewModel(this.store);

  void handleUnexpectedError({
    String? title,
    String? message,
    bool shouldCloseCurrentPage = false,
  }) {
    store.dispatch(
      OpenErrorDialogAction(
        title,
        message,
        shouldCloseCurrentPage: shouldCloseCurrentPage,
      ),
    );
  }

  void openPage(Destination destination) =>
      store.dispatch(OpenPageAction(destination));

  void close() => store.dispatch(ClosePageAction());

  void logout() => store.dispatch(LogoutAction());
}
