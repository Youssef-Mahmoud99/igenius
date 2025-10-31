import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Slide + Fade
class SlideFadeTransition extends CustomTransitionPage {
  SlideFadeTransition({
    required Widget child,
    Duration duration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
    Offset beginOffset = const Offset(1, 0),
  }) : super(
         child: child,
         transitionDuration: duration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final slideAnimation = Tween<Offset>(
             begin: beginOffset,
             end: Offset.zero,
           ).animate(CurvedAnimation(parent: animation, curve: curve));

           final fadeAnimation = Tween<double>(
             begin: 0.0,
             end: 1.0,
           ).animate(CurvedAnimation(parent: animation, curve: curve));

           return SlideTransition(
             position: slideAnimation,
             child: FadeTransition(opacity: fadeAnimation, child: child),
           );
         },
       );
}

/// Fade only
class FadeTransitionPage extends CustomTransitionPage {
  FadeTransitionPage({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
         child: child,
         transitionDuration: duration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return FadeTransition(opacity: animation, child: child);
         },
       );
}

/// Scale (Zoom In)
class ScaleTransitionPage extends CustomTransitionPage {
  ScaleTransitionPage({
    required Widget child,
    Duration duration = const Duration(milliseconds: 350),
  }) : super(
         child: child,
         transitionDuration: duration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return ScaleTransition(
             scale: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
             child: child,
           );
         },
       );
}

/// Rotation + Scale
class RotateScaleTransitionPage extends CustomTransitionPage {
  RotateScaleTransitionPage({
    required Widget child,
    Duration duration = const Duration(milliseconds: 500),
  }) : super(
         child: child,
         transitionDuration: duration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final rotate = Tween<double>(
             begin: -0.2,
             end: 0.0,
           ).animate(animation);
           final scale = Tween<double>(begin: 0.7, end: 1.0).animate(animation);

           return RotationTransition(
             turns: rotate,
             child: ScaleTransition(scale: scale, child: child),
           );
         },
       );
}
