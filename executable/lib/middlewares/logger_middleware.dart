import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

class LoggerMiddleware extends MiddlewareClass<AppState> {
  LoggerMiddleware();

  @override
  call(Store<AppState> store, action, NextDispatcher next) {
    if (action is! LoadingStartAction && action is! LoadingEndAction) {
      if (kDebugMode) {
        print(action);
      }
    }

    if (action is FailedAction &&
        const String.fromEnvironment('ENV') != 'prod') {}
    return next(action);
  }
}
