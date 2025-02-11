import 'package:flutter/material.dart';
import 'package:presentation/src/core/app_bar/mobile_app_bar.dart';
import 'package:presentation/src/partners/partner_details_page/widgets/partner_details_header.dart';
import 'package:presentation/src/partners/partner_details_page/widgets/partners_criterias_table_action_bar.dart';

class PartnerDetailsPage extends StatelessWidget {
  const PartnerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MobileAppBar(),
      body: Column(
        children: [
          PartnerDetailsHeader(),
          CriteriasTableActionBar(),
        ],
      ),
    );
  }
}
