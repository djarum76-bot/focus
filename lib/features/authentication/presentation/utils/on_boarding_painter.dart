import 'dart:math';

import 'package:flutter/material.dart';

class OnBoardingPainter extends CustomPainter {
  final Color color;

  OnBoardingPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double arcRadius = size.width * 1.12;
    const double strokeWidth = 2.0;

    // Adjust center to be at the bottom
    final Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height - arcRadius), radius: arcRadius);

    // Draw the arc starting from 0 degrees to 180 degrees (0 radians to pi radians)
    canvas.drawArc(
      rect.inflate(strokeWidth),
      0,
      pi,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}