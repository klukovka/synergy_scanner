import 'package:flutter/material.dart';

class LoadMoreScrollListener extends StatefulWidget {
  final VoidCallback loadMore;
  final Widget child;

  const LoadMoreScrollListener({
    super.key,
    required this.child,
    required this.loadMore,
  });

  @override
  State<LoadMoreScrollListener> createState() => _LoadMoreScrollListenerState();
}

class _LoadMoreScrollListenerState extends State<LoadMoreScrollListener> {
  var lock = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 1000 &&
            !lock &&
            notification.metrics.extentTotal > 500) {
          widget.loadMore();
          lock = true;
        } else if (notification.metrics.extentAfter > 1000 && lock) {
          lock = false;
        }
        return true;
      },
      child: widget.child,
    );
  }
}
