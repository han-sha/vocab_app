import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttery_dart2/animations.dart';
import 'package:fluttery_dart2/layout.dart';

class PolarPosition extends StatelessWidget {
  final Offset origin;
  final PolarCoord coord;
  final Widget child;

  PolarPosition({
    this.origin = const Offset(0.0, 0.0),
    this.coord,
    this.child
  });

  /// x = radius * cos(angle)
  /// y = radius * sin(angle)
  @override
  Widget build(BuildContext context) {
    final radialPosition = Offset(
        origin.dx + (cos(coord.angle) * coord.radius),
        origin.dy + (sin(coord.angle) * coord.radius)
    );
    return CenterAbout(
        position: radialPosition,
        child: child
    );
  }
}