import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';

class AuthButtons extends StatelessWidget {
  const AuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                //TODO: Push to reset password
              },
              child: Text(context.strings.forgotPassword),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 14, right: 10),
                child: Text(
                  context.strings.dontHaveAccount,
                  textAlign: TextAlign.end,
                ),
              ),
              TextButton(
                onPressed: () => StoreProvider.of<AppState>(context).dispatch(
                  OpenPageAction(Destination.signUp),
                ),
                child: Text(context.strings.registerNow),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
