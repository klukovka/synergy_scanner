import 'package:executable/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/presentation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ygtsdlzrikejjwtosolm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlndHNkbHpyaWtlamp3dG9zb2xtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIxMjU5MTQsImV4cCI6MjA0NzcwMTkxNH0.oLGeyhrg4R6kHLIDzxgJbevdm7QD5eJOxyZv-UTjL9M',
  );
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  final store = await Initializer().initialize();

  runApp(StoreProvider(store: store, child: const App()));
}
