import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'fade_in_transition.dart';

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
  return Image(
    image: FileImage(File(image)),
    width: width,
    height: height,
    fit: fit,
    gaplessPlayback: true,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress?.cumulativeBytesLoaded ==
          loadingProgress?.expectedTotalBytes) {
        return FadeInTransition(
          child: child,
          fadeInDuration: fadeInDuration,
          fadeInCurve: fadeInCurve,
        );
      }
      return placeHolderBuilder();
    },
    errorBuilder: (context, object, stack) {
      return errorBuilder();
    },
  );
}

Widget buildSvgFileImage({
  required String image,
  required double? width,
  required double? height,
  required BoxFit fit,
  required Widget Function() placeHolderBuilder,
}) {
  return SvgPicture.file(
    File(image),
    width: width,
    height: height,
    fit: fit,
    placeholderBuilder: (_) => placeHolderBuilder(),
  );
}
