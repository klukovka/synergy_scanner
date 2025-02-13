import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/general/images/circle_icon_preview.dart';

class ProfileShortInfoView extends StatelessWidget {
  final User? user;
  const ProfileShortInfoView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleIconPreview.user(
          radius: 36,
          imageUrl: user?.avatarUrl,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.fullname ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                user?.email ?? '',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
