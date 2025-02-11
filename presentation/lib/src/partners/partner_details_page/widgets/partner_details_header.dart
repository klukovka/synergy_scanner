import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/partners/partner_details_page/widgets/partner_details_options_button.dart';
import 'package:presentation/src/partners/widgets/partner_card.dart';

class PartnerDetailsHeader extends StatelessWidget {
  final Partner partner;

  const PartnerDetailsHeader({
    super.key,
    required this.partner,
  });

  @override
  Widget build(BuildContext context) {
    return PartnerCard(
      partner: partner,
      trailing: const PartnerDetailsOptionsButton(),
    );
  }
}
