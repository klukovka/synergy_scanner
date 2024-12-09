import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/general/buttons/pop_up_button/pop_up_button.dart';

class AppUnexpectedErrorDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback onPressed;

  const AppUnexpectedErrorDialog({
    super.key,
    this.title,
    this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title ?? context.strings.unexpectedError;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
          tileMode: TileMode.clamp,
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Material(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 32, left: 50, right: 50),
                    child: Column(
                      children: [
                        Icon(MdiIcons.alert, size: 52),
                        const SizedBox(height: 8),
                        Offstage(
                          offstage: title.isEmpty,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Text(
                          message ?? context.strings.tryYourRequestLater,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PopUpButton.onSecondaryContainer(
                      onPressed: onPressed,
                      child: Text(
                        context.strings.close,
                        textAlign: TextAlign.center,
                      ),
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
