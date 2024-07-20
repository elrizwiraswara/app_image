import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'fade_in_out_transition.dart';
import 'img_provider.dart';

/// A widget that displays an image from various sources, such as network, asset,
/// file, memory, or SVG. It includes options for a placeholder, error widget,
/// fade-in duration, and fade-in curve.
class AppImageWidget extends StatelessWidget {
  final dynamic image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeHolderWidget;
  final Widget? errorWidget;
  final Duration fadeInDuration;
  final Curve fadeInCurve;

  /// Constructor for the image widget.
  ///
  /// Parameters:
  /// - [image] is the source of the image, which can be a URL, asset path, file path, or memory.
  /// - [width] specifies the width of the image.
  /// - [height] specifies the height of the image.
  /// - [fit] determines how the image should be inscribed into the widget.
  /// - [placeHolderWidget] is the widget to display while the image is loading.
  /// - [errorWidget] is the widget to display if an error occurs while loading the image.
  /// - [fadeInDuration] specifies the duration for the fade-in effect.
  /// - [fadeInCurve] specifies the curve for the fade-in effect.
  const AppImageWidget({
    super.key,
    this.image,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeHolderWidget,
    this.errorWidget,
    required this.fadeInDuration,
    required this.fadeInCurve,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the type of image provider based on the image source.
    ImgProvider? provider = getImageProvider(image);

    print("$provider $image");

    // Display the appropriate image widget based on the provider type.
    if (provider == ImgProvider.networkImage) {
      return _networkImage();
    }

    if (provider == ImgProvider.assetImage) {
      return _assetImage();
    }

    if (provider == ImgProvider.fileImage) {
      return _fileImage();
    }

    if (provider == ImgProvider.memoryImage) {
      return _memoryImage();
    }

    if (provider == ImgProvider.svgImageNetwork) {
      return _svgImageNetwork();
    }

    if (provider == ImgProvider.svgImageFile) {
      return _svgImageFile();
    }

    if (provider == ImgProvider.svgImageAsset) {
      return _svgImageAsset();
    }

    // Return an error widget if no valid provider type is found.
    return _errorWidget();
  }

  // Widget for displaying a network image.
  Widget _networkImage() {
    return Image(
      image: NetworkImage(image),
      width: width,
      height: height,
      fit: fit,
      gaplessPlayback: true,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress?.cumulativeBytesLoaded == loadingProgress?.expectedTotalBytes) {
          return FadeInTransition(
            child: child,
            fadeInDuration: fadeInDuration,
            fadeInCurve: fadeInCurve,
          );
        }

        return _placeHolderWidget();
      },
      errorBuilder: (context, object, stack) {
        return _errorWidget();
      },
    );
  }

  // Widget for displaying an asset image.
  Widget _assetImage() {
    return Image(
      image: AssetImage(image),
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress?.cumulativeBytesLoaded == loadingProgress?.expectedTotalBytes) {
          return FadeInTransition(
            child: child,
            fadeInDuration: fadeInDuration,
            fadeInCurve: fadeInCurve,
          );
        }

        return _placeHolderWidget();
      },
      errorBuilder: (context, object, stack) {
        return _errorWidget();
      },
    );
  }

  // Widget for displaying a file image.
  Widget _fileImage() {
    return Image(
      image: FileImage(File(image)),
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress?.cumulativeBytesLoaded == loadingProgress?.expectedTotalBytes) {
          return FadeInTransition(
            child: child,
            fadeInDuration: fadeInDuration,
            fadeInCurve: fadeInCurve,
          );
        }

        return _placeHolderWidget();
      },
      errorBuilder: (context, object, stack) {
        return _errorWidget();
      },
    );
  }

  // Widget for displaying a memory image.
  Widget _memoryImage() {
    return Image(
      image: MemoryImage(image),
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress?.cumulativeBytesLoaded == loadingProgress?.expectedTotalBytes) {
          return FadeInTransition(
            child: child,
            fadeInDuration: fadeInDuration,
            fadeInCurve: fadeInCurve,
          );
        }

        return _placeHolderWidget();
      },
      errorBuilder: (context, object, stack) {
        return _errorWidget();
      },
    );
  }

  // Widget for displaying a network SVG image.
  Widget _svgImageNetwork() {
    return SvgPicture.network(
      image,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: (_) {
        return _placeHolderWidget();
      },
    );
  }

  // Widget for displaying a file SVG image.
  Widget _svgImageFile() {
    return SvgPicture.file(
      File(image),
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: (_) {
        return _placeHolderWidget();
      },
    );
  }

  // Widget for displaying an asset SVG image.
  Widget _svgImageAsset() {
    return SvgPicture.asset(
      image,
      width: width,
      height: height,
      fit: fit,
      placeholderBuilder: (_) {
        return _placeHolderWidget();
      },
    );
  }

  // Widget to display while the image is loading.
  Widget _placeHolderWidget() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate icon size based on the smaller of parent width or height
        double size = (constraints.maxWidth < constraints.maxHeight)
            ? constraints.maxWidth * 0.2 // 20% of the smaller dimension
            : constraints.maxHeight * 0.2;

        size = size > 50 ? 50 : size;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(),
            ),
          ],
        );
      },
    );
  }

  // Widget to display if an error occurs while loading the image.
  Widget _errorWidget() {
    if (errorWidget != null) {
      return errorWidget!;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate icon size based on the smaller of parent width or height
        double size = (constraints.maxWidth < constraints.maxHeight)
            ? constraints.maxWidth * 0.2 // 20% of the smaller dimension
            : constraints.maxHeight * 0.2;

        size = size > 50 ? 50 : size;

        return Center(
          child: Icon(
            Icons.broken_image_rounded,
            size: size,
            color: Theme.of(context).colorScheme.outline,
          ),
        );
      },
    );
  }
}
