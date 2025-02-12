import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/criterias/criterias_page/widgets/criteria_card.dart';
import 'package:presentation/src/criterias/criterias_page/widgets/criterias_table.dart';
import 'package:presentation/src/criterias/criterias_page/widgets/criterias_table_action_bar.dart';

class CriteriasPage extends StatelessWidget {
  const CriteriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dispatch = StoreProvider.of<AppState>(context).dispatch;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CriteriasTableActionBar(),
            Expanded(
              child: CriteriasTable<GeneralTablePointer>(
                itemBuilder: (context, criteria) => CriteriaCard(
                  key: ValueKey(criteria.id),
                  onPressed: () {},
                  criteria: criteria,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => dispatch(
          OpenPageAction(Destination.createCriteria),
        ),
      ),
    );
  }
}
