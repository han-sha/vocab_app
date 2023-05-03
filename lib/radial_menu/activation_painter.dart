import 'package:flutter/material.dart';

class ActivationPainter extends CustomPainter{
  final double radius;
  final Color color;
  final double startAngle;
  final double endAngle;
  final double thickness;
  final Paint activationPaint;

  ActivationPainter({
    this.radius,
    this.thickness,
    this.color,
    this.startAngle,
    this.endAngle
  }) : activationPaint = new Paint()
    ..color = color
    ..strokeWidth = thickness
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
        Rect.fromLTWH(
            -radius,
            -radius,
            radius * 2,
            radius * 2
        ),
        startAngle,
        endAngle - startAngle,
        false,
        activationPaint
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
    // TODO: implement shouldRepaint
  }

}