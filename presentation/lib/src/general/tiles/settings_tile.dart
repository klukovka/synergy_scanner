import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.isActive,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            if (isActive) ...[
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
            ],
            if (!isActive) const SizedBox(width: 36),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
