import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  Color color;
  TextDirection textDirection;
  late double offset;
  late double startingPosition;

  Painter(double startingIndex, int length, this.color, this.textDirection) {
    final span = 1.0 / length;
    offset = 0.2;
    double l = startingIndex + (span - offset) / 2;
    startingPosition = (textDirection == TextDirection.rtl) ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo((startingPosition - 0.1) * size.width, 0)
      ..cubicTo(
        (startingPosition + offset * 0.20) * size.width,
        size.height * 0.05,
        startingPosition * size.width,
        size.height * 0.70,
        (startingPosition + offset * 0.50) * size.width,
        size.height * 0.70,
      )
      ..cubicTo(
        (startingPosition + offset) * size.width,
        size.height * 0.70,
        (startingPosition + offset - offset * 0.20) * size.width,
        size.height * 0.05,
        (startingPosition + offset + 0.1) * size.width,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
