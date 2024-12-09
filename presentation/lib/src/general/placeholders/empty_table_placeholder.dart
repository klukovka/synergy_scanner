import 'package:flutter/material.dart';
import 'package:presentation/src/general/loaders/styled_loader/styled_loader.dart';

class EmptyTablePlaceholder extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget icon;
  final bool isLoading;

  const EmptyTablePlaceholder({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Visibility(
        visible: isLoading,
        replacement: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme(
              data: IconTheme.of(context).copyWith(color: color, size: 32),
              child: icon,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: color,
                        ),
                    child: title,
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: color,
                        ),
                    child: subtitle,
                  ),
                ],
              ),
            ),
          ],
        ),
        child: const StyledLoader.primary(size: 32),
      ),
    );
  }
}
