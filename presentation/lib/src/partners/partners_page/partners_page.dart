import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/partners/partners_page/widgets/partners_table.dart';
import 'package:presentation/src/partners/partners_page/widgets/partners_table_action_bar.dart';
import 'package:presentation/src/partners/widgets/partner_card.dart';

class PartnersPage extends StatelessWidget {
  const PartnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dispatch = StoreProvider.of<AppState>(context).dispatch;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const PartnersTableActionBar(),
            Expanded(
              child: PartnersTable<GeneralTablePointer>(
                itemBuilder: (context, partner) => PartnerCard(
                  key: ValueKey(partner.id),
                  onPressed: () {
                    dispatch(SetSelectedIdAction<Partner>(partner.id));
                    dispatch(OpenPageAction(Destination.partnerDetails));
                  },
                  partner: partner,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => dispatch(
          OpenPageAction(Destination.createPartner),
        ),
      ),
    );
  }
}
