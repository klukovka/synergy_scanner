import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/criterias/criterias_page/widgets/criterias_table.dart';
import 'package:presentation/src/criterias/criterias_page/widgets/criterias_table_action_bar.dart';

class CriteriasPage extends StatelessWidget {
  const CriteriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Column(
          children: [
            CriteriasTableActionBar(),
            Expanded(child: CriteriasTable()),
          ],
        ),
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
