import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UniversalRefreshIndicator extends StatefulWidget {
  final VoidCallback onRefresh;
  final bool isLoading;
  final Widget Function(BuildContext contex, Widget iosSliverRefreshIndicator)
      builder;
  final double edgeOffset;

  const UniversalRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.isLoading,
    required this.builder,
    required this.edgeOffset,
  });

  @override
  State<StatefulWidget> createState() => _UniversalRefreshIndicatorState();
}

class _UniversalRefreshIndicatorState extends State<UniversalRefreshIndicator> {
  Completer<void>? _refreshCompleter;

  Future<void> refresh() {
    _refreshCompleter = Completer<void>();
    widget.onRefresh();
    return _refreshCompleter!.future.timeout(const Duration(seconds: 10));
  }

  @override
  void didUpdateWidget(covariant UniversalRefreshIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isLoading && !widget.isLoading) {
      _refreshCompleter?.complete();
      _refreshCompleter = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      edgeOffset: widget.edgeOffset,
      onRefresh: refresh,
      notificationPredicate: (notification) {
        if (defaultTargetPlatform == TargetPlatform.android) {
          return defaultScrollNotificationPredicate(notification);
        }

        return false;
      },
      child: widget.builder(
        context,
        defaultTargetPlatform == TargetPlatform.iOS
            ? CupertinoSliverRefreshControl(
                onRefresh: refresh,
                builder: (
                  context,
                  refreshState,
                  pulledExtent,
                  refreshTriggerPullDistance,
                  refreshIndicatorExtent,
                ) {
                  final double percentageComplete = clampDouble(
                    pulledExtent / refreshTriggerPullDistance,
                    0.0,
                    1.0,
                  );

                  const opacityCurve =
                      Interval(0.0, 0.35, curve: Curves.easeInOut);

                  return Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Positioned(
                          top: 16,
                          child: switch (refreshState) {
                            RefreshIndicatorMode.drag => Opacity(
                                opacity:
                                    opacityCurve.transform(percentageComplete),
                                child: CircularProgressIndicator(
                                  value: percentageComplete,
                                  strokeWidth: 2,
                                ),
                              ),
                            RefreshIndicatorMode.armed ||
                            RefreshIndicatorMode.refresh =>
                              const CircularProgressIndicator(strokeWidth: 2),
                            RefreshIndicatorMode.done =>
                              // When the user lets go, the standard transition is to shrink the spinner.
                              Opacity(
                                opacity: percentageComplete,
                                child: SizedBox(
                                  height: 32 * percentageComplete,
                                  width: 32 * percentageComplete,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2 * percentageComplete,
                                    value: 1,
                                  ),
                                ),
                              ),
                            RefreshIndicatorMode.inactive =>
                              // Anything else doesn't show anything.
                              const SizedBox.shrink()
                          },
                        ),
                      ],
                    ),
                  );
                },
              )
            : const SliverToBoxAdapter(child: SizedBox.shrink()),
      ),
    );
  }
}
