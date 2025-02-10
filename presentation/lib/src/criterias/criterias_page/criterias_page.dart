import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CriteriasPage extends StatelessWidget {
  const CriteriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('CriteriasPage'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => StoreProvider.of<AppState>(context).dispatch(
          OpenPageAction(Destination.createCriteria),
        ),
      ),
    );
  }
}
