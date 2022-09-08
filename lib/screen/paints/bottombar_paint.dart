// SPDX-License-Identifier: Apache-2.0

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
    final paint = Paint()
      ..color = const ui.Color.fromARGB(255, 36, 36, 36)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final paint2 = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
          Offset((x + width / 2), 0), Offset((x + width / 2), height), [
        const ui.Color.fromARGB(255, 25, 24, 24),
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
