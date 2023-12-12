import 'dart:math';

import 'package:flutter/material.dart';

class FocusPainter extends CustomPainter {
  final Color color;

  FocusPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double arcRadius = size.width / 1;
    const double strokeWidth = 2.0;
    final Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: arcRadius);

    canvas.drawArc(
      rect.inflate(strokeWidth),
      pi,
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