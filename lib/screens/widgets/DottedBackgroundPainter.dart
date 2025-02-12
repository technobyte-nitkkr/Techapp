import 'package:flutter/material.dart';

class DottedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.2) // White dots with opacity
      ..style = PaintingStyle.fill;

    const double spacing = 15.0; // Space between dots
    const double radius = 2.0; // Size of each dot

    for (double y = 10; y < size.height; y += spacing) {
      for (double x = 10; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
