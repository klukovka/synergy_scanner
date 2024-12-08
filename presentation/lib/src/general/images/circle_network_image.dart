import 'package:flutter/material.dart';

class CircleNetworkImage extends StatefulWidget {
  final double radius;
  final String? imageUrl;
  final Widget placeholder;
  final Color? backgroundColor;

  const CircleNetworkImage({
    super.key,
    required this.placeholder,
    this.radius = 24,
    this.imageUrl,
    this.backgroundColor,
  });

  @override
  State<CircleNetworkImage> createState() => _CircleNetworkImageState();
}

class _CircleNetworkImageState extends State<CircleNetworkImage> {
  ImageProvider? _image;
  bool _hasError = false;

  @override
  void initState() {
    _image = widget.imageUrl == null ? null : NetworkImage(widget.imageUrl!);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CircleNetworkImage oldWidget) {
    if (widget.imageUrl != null && widget.imageUrl != oldWidget.imageUrl) {
      final image = NetworkImage(widget.imageUrl!);
      precacheImage(image, context).then((value) {
        if (mounted) {
          setState(() {
            _image = image;
            _hasError = false;
          });
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final hasForegroundImage = _image != null && !_hasError;

    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: widget.backgroundColor ?? Colors.transparent,
      foregroundImage: hasForegroundImage ? _image : null,
      onForegroundImageError: hasForegroundImage
          ? (error, stackTrace) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() => _hasError = true);
                }
              });
            }
          : null,
      child: widget.imageUrl == null || _hasError ? widget.placeholder : null,
    );
  }
}
