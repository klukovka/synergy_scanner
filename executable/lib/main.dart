import 'package:executable/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/presentation.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  final store = await Initializer().initialize();

  runApp(StoreProvider(store: store, child: const App()));
}
