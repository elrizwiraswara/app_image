import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'raster_image.dart';

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
  return buildRasterImage(
    image: FileImage(File(image)),
    width: width,
    height: height,
    fit: fit,
    fadeInDuration: fadeInDuration,
    fadeInCurve: fadeInCurve,
    placeHolderBuilder: placeHolderBuilder,
    errorBuilder: errorBuilder,
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
