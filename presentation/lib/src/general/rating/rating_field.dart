import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

const _starCount = 5;

class RatingField extends StatelessWidget {
  final String name;
  final int? initialValue;
  final String? Function(int?)? validator;
  final double starIconSize;
  final void Function(int?)? onChanged;

  const RatingField({
    super.key,
    this.initialValue,
    this.starIconSize = 40,
    required this.name,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<int>(
      name: name,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      builder: (state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  _starCount,
                  (index) {
                    final currentValue = state.value ?? 0;
                    final isFilled = index < currentValue;
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        state.didChange(index + 1);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          isFilled ? Icons.star : Icons.star_border_outlined,
                          size: starIconSize,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Text(
                  state.errorText ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ),
          ],
        );
      },
    );
  }
}
