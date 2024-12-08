import 'package:flutter/material.dart';

class BottomLoadingButton extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final VoidCallback onPressed;

  const BottomLoadingButton({
    super.key,
    required this.child,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: MediaQuery.paddingOf(context).bottom,
      ),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(4),
                child: CircularProgressIndicator(),
              )
            : child,
      ),
    );
  }
}
