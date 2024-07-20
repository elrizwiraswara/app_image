import 'package:flutter/material.dart';

/// A widget that applies a fade-in animation to its child widget.
class FadeInTransition extends StatefulWidget {
  final Widget child;
  final Duration fadeInDuration;
  final Curve fadeInCurve;

  /// Constructor for the FadeInTransition widget.
  ///
  /// Parameters:
  /// - [child] is the widget to which the fade-in effect will be applied.
  /// - [fadeInDuration] specifies the duration of the fade-in effect.
  /// - [fadeInCurve] specifies the curve for the fade-in effect.
  const FadeInTransition({
    super.key,
    required this.child,
    required this.fadeInDuration,
    required this.fadeInCurve,
  });

  @override
  FadeInTransitionState createState() => FadeInTransitionState();
}

class FadeInTransitionState extends State<FadeInTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with the specified duration.
    _controller = AnimationController(
      duration: widget.fadeInDuration,
      vsync: this,
    );

    // Create a curved animation with the specified curve.
    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.fadeInCurve,
    );

    // Start the fade-in animation.
    _controller.forward();
  }

  @override
  void dispose() {
    // Dispose of the animation controller to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Apply the fade transition to the child widget.
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(_fadeInAnimation),
      child: widget.child,
    );
  }
}
