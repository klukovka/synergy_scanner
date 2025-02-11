import 'dart:ui';

import 'package:flutter/material.dart';

class RegularDialog extends StatelessWidget {
  final Widget? icon;
  final Widget? title;
  final Widget subtitle;
  final Widget? confirmAction;
  final Widget cancelAction;
  final BoxConstraints? constraints;

  const RegularDialog({
    super.key,
    this.icon,
    this.title,
    required this.subtitle,
    required this.cancelAction,
    this.confirmAction,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
          ),
          child: Material(
            child: ConstrainedBox(
              constraints: constraints ??
                  const BoxConstraints(
                    maxWidth: 320,
                  ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Offstage(
                          offstage: icon == null,
                          child: IconTheme(
                            data: const IconThemeData(
                              size: 36,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: icon,
                            ),
                          ),
                        ),
                        Offstage(
                          offstage: title == null,
                          child: DefaultTextStyle(
                            style: Theme.of(context).textTheme.bodyMedium!,
                            textAlign: TextAlign.center,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: title,
                            ),
                          ),
                        ),
                        DefaultTextStyle(
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall!,
                          child: subtitle,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(child: cancelAction),
                        if (confirmAction != null) ...[
                          VerticalDivider(
                            thickness: 1,
                            width: 1,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Expanded(child: confirmAction!),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
