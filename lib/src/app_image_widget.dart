import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_image_widget_io.dart'
    if (dart.library.js_interop) 'app_image_widget_web.dart';
import 'img_provider.dart';
import 'raster_image.dart';

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
    if (image == null || image == '') {
      return _placeHolderWidget();
    }

    // Determine the type of image provider based on the image source.
    ImgProvider? provider = getImageProvider(image);

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

  Widget _networkImage() {
    return buildRasterImage(
      image: NetworkImage(image),
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: fadeInDuration,
      fadeInCurve: fadeInCurve,
      placeHolderBuilder: _placeHolderWidget,
      errorBuilder: _errorWidget,
    );
  }

  Widget _assetImage() {
    return buildRasterImage(
      image: AssetImage(image),
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: fadeInDuration,
      fadeInCurve: fadeInCurve,
      placeHolderBuilder: _placeHolderWidget,
      errorBuilder: _errorWidget,
    );
  }

  Widget _fileImage() {
    return buildFileImage(
      image: image,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: fadeInDuration,
      fadeInCurve: fadeInCurve,
      placeHolderBuilder: _placeHolderWidget,
      errorBuilder: _errorWidget,
    );
  }

  Widget _memoryImage() {
    return buildRasterImage(
      image: MemoryImage(image),
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: fadeInDuration,
      fadeInCurve: fadeInCurve,
      placeHolderBuilder: _placeHolderWidget,
      errorBuilder: _errorWidget,
    );
  }

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

  Widget _svgImageFile() {
    return buildSvgFileImage(
      image: image,
      width: width,
      height: height,
      fit: fit,
      placeHolderBuilder: _placeHolderWidget,
    );
  }

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

  Widget _placeHolderWidget() {
    if (placeHolderWidget != null) {
      return placeHolderWidget!;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double size = (constraints.maxWidth < constraints.maxHeight)
            ? constraints.maxWidth * 0.2
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

  Widget _errorWidget() {
    if (errorWidget != null) {
      return errorWidget!;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double size = (constraints.maxWidth < constraints.maxHeight)
            ? constraints.maxWidth * 0.2
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
