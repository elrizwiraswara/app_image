import 'package:flutter/material.dart';

Widget buildFileImage({
  required String image,
  required double? width,
  required double? height,
  required BoxFit fit,
  required Duration fadeInDuration,
  required Curve fadeInCurve,
  required Widget Function() placeHolderBuilder,
  required Widget Function() errorBuilder,
}) {
  // File images are not supported on web
  return errorBuilder();
}

Widget buildSvgFileImage({
  required String image,
  required double? width,
  required double? height,
  required BoxFit fit,
  required Widget Function() placeHolderBuilder,
}) {
  // SVG file images are not supported on web
  return placeHolderBuilder();
}
