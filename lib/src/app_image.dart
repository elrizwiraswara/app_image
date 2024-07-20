import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'app_image_full_screen_viewer.dart';
import 'app_image_widget.dart';
import 'img_provider.dart';

/// A widget that displays an image with various customization options, including
/// support for different image sources, placeholder and error widgets, fade-in effect,
/// and optional full-screen view.
class AppImage extends StatefulWidget {
  final dynamic image;
  final List<dynamic>? allImages;
  final ImgProvider? imgProvider;
  final BoxFit fit;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final Widget? errorWidget;
  final Widget? placeHolderWidget;
  final bool enableFullScreenView;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final BoxBorder? border;
  final BorderRadius? borderRadius;

  /// Constructor for the AppImage widget.
  ///
  /// Parameters:
  /// - [image] is the source of the image, which can be a URL, asset path, file path, or memory.
  /// - [allImages] is a list of images to display in full-screen view.
  /// - [imgProvider] specifies the image provider type.
  /// - [fit] determines how the image should be inscribed into the widget.
  /// - [fadeInDuration] specifies the duration for the fade-in effect.
  /// - [fadeInCurve] specifies the curve for the fade-in effect.
  /// - [errorWidget] is the widget to display if an error occurs while loading the image.
  /// - [placeHolderWidget] is the widget to display while the image is loading.
  /// - [enableFullScreenView] enables the full-screen view of the image when tapped.
  /// - [width] specifies the width of the image.
  /// - [height] specifies the height of the image.
  /// - [margin] specifies the margin around the image.
  /// - [backgroundColor] specifies the background color of the image container.
  /// - [border] specifies the border of the image container.
  /// - [borderRadius] specifies the border radius of the image container.
  const AppImage({
    super.key,
    required this.image,
    this.allImages,
    this.imgProvider,
    this.fit = BoxFit.cover,
    this.fadeInDuration = const Duration(milliseconds: 200),
    this.fadeInCurve = Curves.easeInOut,
    this.errorWidget,
    this.placeHolderWidget,
    this.enableFullScreenView = false,
    this.width,
    this.height,
    this.margin,
    this.backgroundColor,
    this.border,
    this.borderRadius,
  }) : assert(image == null || image is String || image is Uint8List);

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacacheImages();
    });
    super.initState();
  }

  /// Pre-caches the images to improve loading performance.
  void _precacacheImages() {
    ImgProvider? provider = getImageProvider(widget.image);

    if (provider == ImgProvider.networkImage) {
      precacheImage(NetworkImage(widget.image), context);
    }

    if (provider == ImgProvider.assetImage) {
      precacheImage(AssetImage(widget.image), context);
    }

    if (provider == ImgProvider.fileImage) {
      precacheImage(FileImage(File(widget.image)), context);
    }

    if (provider == ImgProvider.memoryImage) {
      precacheImage(MemoryImage(widget.image), context);
    }
  }

  /// Handles the tap event to open the full-screen image viewer.
  void _onTapImage() {
    if ((widget.allImages == null || widget.allImages!.isEmpty) && widget.image == '') {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AppImageFullScreenViewer(
          initialIndex: (widget.allImages?.isNotEmpty ?? false) ? widget.allImages!.indexOf(widget.image) : 0,
          images: widget.allImages ?? [widget.image],
          fadeInDuration: widget.fadeInDuration,
          fadeInCurve: widget.fadeInCurve,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enableFullScreenView ? _onTapImage : null,
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: widget.backgroundColor,
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          border: widget.border,
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
          child: AppImageWidget(
            image: widget.image,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            placeHolderWidget: widget.placeHolderWidget,
            errorWidget: widget.errorWidget,
            fadeInDuration: widget.fadeInDuration,
            fadeInCurve: widget.fadeInCurve,
          ),
        ),
      ),
    );
  }
}
