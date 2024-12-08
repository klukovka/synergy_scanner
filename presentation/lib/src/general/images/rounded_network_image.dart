import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:localizations/localizations.dart';
import 'package:presentation/src/general/images/custom_network_image.dart';

class RoundedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final bool isLoading;
  final bool useCachedImage;

  const RoundedNetworkImage({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.isLoading = false,
    this.useCachedImage = true,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = this.imageUrl;

    if (imageUrl != null && !isLoading && useCachedImage) {
      return Center(
        child: CustomNetworkImage(
          borderRadius: BorderRadius.circular(8),
          imageUrl: imageUrl,
          width: width,
          height: height,
        ),
      );
    }
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primary,
        image: imageUrl != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              )
            : null,
      ),
      child: isLoading
          ? SpinKitThreeBounce(
              color: Theme.of(context).colorScheme.onPrimary,
              size: 16,
            )
          : imageUrl == null
              ? Text(
                  context.strings.notAvailable,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : null,
    );
  }
}
