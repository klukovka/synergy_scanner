import 'package:flutter/material.dart';
import 'package:presentation/src/general/rating/rating_view.dart';

class RatingNameInfoBar extends StatelessWidget {
  final String name;
  final double? mark;

  const RatingNameInfoBar({
    super.key,
    required this.name,
    required this.mark,
  });

  @override
  Widget build(BuildContext context) {
    final mark = this.mark;
    return Container(
      height: 100,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.headlineMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          if (mark != null)
            IconTheme(
              data: const IconThemeData(size: 24),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.titleLarge!,
                child: RatingView(
                  rate: mark,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
