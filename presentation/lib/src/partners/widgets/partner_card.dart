import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/core/extensions/partner_type_extension.dart';
import 'package:presentation/src/general/images/circle_icon_preview.dart';
import 'package:presentation/src/general/rating/rating_view.dart';

class PartnerCard extends StatelessWidget {
  final Partner partner;
  final VoidCallback? onPressed;
  final Widget? trailing;

  const PartnerCard({
    super.key,
    this.onPressed,
    required this.partner,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: CircleIconPreview.user(
        imageUrl: partner.avatarUrl,
        radius: 28,
      ),
      title: RichText(
        text: TextSpan(
          text: partner.name,
          style: Theme.of(context).textTheme.bodyLarge,
          children: [
            TextSpan(
              text: ' (${partner.type.getDisplayText(context)})',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      subtitle: RatingView(rate: partner.averageMark ?? 0),
      trailing: trailing,
    );
  }
}
