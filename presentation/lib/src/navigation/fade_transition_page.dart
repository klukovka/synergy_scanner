import 'package:flutter/material.dart';

class FadeTransitionPage extends Page<void> {
  final Widget child;

  const FadeTransitionPage({
    super.key,
    required this.child,
  });

  @override
  Route<void> createRoute(BuildContext context) => PageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 150),
        opaque: true,
      );
}
