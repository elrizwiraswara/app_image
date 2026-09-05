import 'package:flutter/material.dart';

/// Builds a raster [Image] that fades in only on async first paint.
///
/// When the frame is available synchronously (ImageCache hit / remount), the
/// child is shown immediately — no placeholder flash and no fade blink.
Widget buildRasterImage({
  required ImageProvider image,
  required double? width,
  required double? height,
  required BoxFit fit,
  required Duration fadeInDuration,
  required Curve fadeInCurve,
  required Widget Function() placeHolderBuilder,
  required Widget Function() errorBuilder,
}) {
  return Image(
    image: image,
    width: width,
    height: height,
    fit: fit,
    gaplessPlayback: true,
    frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
      if (wasSynchronouslyLoaded || fadeInDuration == Duration.zero) {
        return child;
      }

      return Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          if (frame == null) placeHolderBuilder(),
          AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: fadeInDuration,
            curve: fadeInCurve,
            child: child,
          ),
        ],
      );
    },
    errorBuilder: (context, object, stack) => errorBuilder(),
  );
}
