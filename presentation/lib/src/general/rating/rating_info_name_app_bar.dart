import 'package:flutter/material.dart';
import 'package:presentation/src/general/rating/rating_name_info_bar.dart';

class RatingInfoNameAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String name;
  final double? mark;

  const RatingInfoNameAppBar({
    super.key,
    required this.name,
    this.mark,
  });

  @override
  Widget build(BuildContext context) {
    return RatingNameInfoBar(
      name: name,
      mark: mark,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(132);
}
