import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/criterias/criteria_details_page/widgets/criteria_details_options_button.dart';
import 'package:presentation/src/criterias/widgets/criteria_card.dart';

class CriteriaDetailsHeader extends StatelessWidget {
  final Criteria criteria;

  const CriteriaDetailsHeader({
    super.key,
    required this.criteria,
  });

  @override
  Widget build(BuildContext context) {
    return CriteriaCard(
      criteria: criteria,
      trailing: const CriteriaDetailsOptionsButton(),
    );
  }
}
