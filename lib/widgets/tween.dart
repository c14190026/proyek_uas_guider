// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ShakesAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final double begin_tween;
  final double end_tween;
  final Axis axis;
  final Curve curve;

  const ShakesAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.offset = 140.0,
    this.begin_tween = 1,
    this.end_tween = 0,
    this.axis = Axis.horizontal,
    this.curve = Curves.bounceOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      child: child,
      duration: duration,
      curve: curve,
      tween: Tween(begin: begin_tween, end: end_tween),
      builder: (context, value, child) {
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(
                  value * offset,
                  0.0,
                )
              : Offset(
                  0.0,
                  value * offset,
                ),
          child: child,
        );
      },
    );
  }
}