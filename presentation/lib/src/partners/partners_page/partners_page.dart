import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/partners/partners_page/widgets/partners_table.dart';
import 'package:presentation/src/partners/partners_page/widgets/partners_table_action_bar.dart';

class PartnersPage extends StatelessWidget {
  const PartnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Column(
          children: [
            PartnersTableActionBar(),
            Expanded(child: PartnersTable()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => StoreProvider.of<AppState>(context).dispatch(
          OpenPageAction(Destination.createPartner),
        ),
      ),
    );
  }
}
