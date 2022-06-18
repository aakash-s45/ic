import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class BottomBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    const double angle = 40;

    double x = height * tan((angle / 180) * pi);
    double y = height;

    final double width = size.width - 2 * x;
    final center = Offset(x + (width / 2), y / 2);
// 244 242 231
    final paint = Paint()
      ..color = ui.Color.fromARGB(255, 36, 36, 36)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final paint2 = Paint()
      // ..color = Color.fromARGB(255, 40, 40, 39)
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
          Offset((x + width / 2), 0), Offset((x + width / 2), height), [
        ui.Color.fromARGB(255, 25, 24, 24),
        Colors.black,
      ]);
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(x, size.height - y)
      ..lineTo(x + width, size.height - y)
      ..lineTo(size.width, size.height);

    final path2 = Path()
      ..moveTo(0, size.height)
      ..lineTo(x, size.height - y)
      ..lineTo(x + width, size.height - y)
      ..lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
