import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/navigation/app_route_info_provider.dart';
import 'package:presentation/src/navigation/app_router_delegate.dart';
import 'package:presentation/src/navigation/parsing/app_route_parser.dart';
import 'package:presentation/src/navigation/parsing/routes/routes.dart';

class App extends StatefulWidget {
  final void Function(BuildContext context)? onInit;

  const App({
    super.key,
    this.onInit,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _backButtonDispatcher = RootBackButtonDispatcher();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onInit?.call(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light, // For iOS
        statusBarIconBrightness: Brightness.light, // For Android
      ),
      child: MaterialApp.router(
        title: 'Synergy Scanner',
        // localizationsDelegates: Localizations.localizationsDelegates,
        // supportedLocales: Localizations.supportedLocales,
        // locale: const Locale('en'),
        routerDelegate: AppRouterDelegate(store, routes),
        routeInformationParser: AppRouteParser(
          () => store.state.currentUserState.user,
        ),
        routeInformationProvider: AppRouteInformationProvider(
          initialRouteInformation: RouteInformation(
            uri: Uri.parse(
              WidgetsBinding.instance.platformDispatcher.defaultRouteName,
            ),
          ),
          store: store,
        ),
        backButtonDispatcher: _backButtonDispatcher,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
