import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_image_widget.dart';

/// A full-screen viewer for displaying a list of images.
/// Provides options for customizing the initial image index, placeholder widget,
/// error widget, fade-in duration, and fade-in curve.
class AppImageFullScreenViewer extends StatefulWidget {
  final int initialIndex;
  final List<dynamic> images;
  final Widget? placeHolderWidget;
  final Widget? errorWidget;
  final Duration fadeInDuration;
  final Curve fadeInCurve;

  /// Constructor for the full-screen image viewer.
  ///
  /// Parameters:
  /// - [initialIndex] specifies the initial image to display.
  /// - [images] is a list of images to be displayed.
  /// - [placeHolderWidget] is the widget to display while the image is loading.
  /// - [errorWidget] is the widget to display if an error occurs while loading the image.
  /// - [fadeInDuration] specifies the duration for the fade-in effect.
  /// - [fadeInCurve] specifies the curve for the fade-in effect.
  const AppImageFullScreenViewer({
    super.key,
    this.initialIndex = 0,
    required this.images,
    this.placeHolderWidget,
    this.errorWidget,
    required this.fadeInDuration,
    required this.fadeInCurve,
  });

  @override
  State<AppImageFullScreenViewer> createState() => _AppImageFullScreenViewerState();
}

class _AppImageFullScreenViewerState extends State<AppImageFullScreenViewer> {
  // PageController to manage the page view and handle page transitions.
  final _pageController = PageController();

  @override
  void initState() {
    // Jump to the initial index after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(widget.initialIndex);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.black,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        pageSnapping: true,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            panEnabled: true,
            scaleEnabled: true,
            trackpadScrollCausesScale: true,
            minScale: 0.1,
            maxScale: 5.0,
            child: AppImageWidget(
              image: widget.images[index],
              fit: BoxFit.contain,
              placeHolderWidget: widget.placeHolderWidget,
              errorWidget: widget.errorWidget,
              fadeInDuration: widget.fadeInDuration,
              fadeInCurve: widget.fadeInCurve,
            ),
          );
        },
      ),
    );
  }
}
