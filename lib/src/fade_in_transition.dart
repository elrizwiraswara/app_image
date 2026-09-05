import 'package:flutter/material.dart';

/// A widget that applies a fade-in animation to its child widget.
///
/// When [fadeInDuration] is zero, the child is shown immediately.
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

    _controller = AnimationController(
      duration: widget.fadeInDuration,
      vsync: this,
      value: widget.fadeInDuration == Duration.zero ? 1.0 : 0.0,
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.fadeInCurve,
    );

    if (widget.fadeInDuration != Duration.zero) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fadeInDuration == Duration.zero) {
      return widget.child;
    }

    return FadeTransition(
      opacity: _fadeInAnimation,
      child: widget.child,
    );
  }
}
