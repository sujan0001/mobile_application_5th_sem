import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Top orange wave
    paint.color = const Color(0xFFFF7043); // orange
    final topPath = Path()
      ..lineTo(0, size.height * 0.2)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.1,
        size.width,
        size.height * 0.2,
      )
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(topPath, paint);

    // Bottom teal corner
    paint.color = const Color(0xFF4DD0E1); // teal
    final tealPath = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width, size.height * 0.85)
      ..quadraticBezierTo(
        size.width * 0.7,
        size.height * 0.95,
        size.width * 0.5,
        size.height,
      )
      ..close();
    canvas.drawPath(tealPath, paint);

    // Bottom yellow circle
    paint.color = const Color(0xFFFFEB3B); // yellow
    canvas.drawCircle(
      Offset(size.width * 0.3, size.height * 0.95),
      80,
      paint,
    );

    // Bottom red circle
    paint.color = const Color(0xFFF44336); // red
    canvas.drawCircle(
      Offset(0, size.height * 0.95),
      100,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
