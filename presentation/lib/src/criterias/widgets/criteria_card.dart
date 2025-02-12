import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class CriteriaCard extends StatelessWidget {
  final Criteria criteria;
  final VoidCallback? onPressed;
  final Widget? subtitle;
  final Widget? trailing;

  const CriteriaCard({
    super.key,
    this.onPressed,
    required this.criteria,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: RichText(
        text: TextSpan(
          text: criteria.name,
          style: Theme.of(context).textTheme.bodyLarge,
          children: [
            TextSpan(
              text: ' (${criteria.coefficient.toStringAsFixed(3)})',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
