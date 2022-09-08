// SPDX-License-Identifier: Apache-2.0

import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class TopBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    const double angle = 40;

    double x = height * tan((angle / 180) * pi);
    double y = height;

    final double width = size.width - 2 * x;
    final paint = Paint()
      ..color = const ui.Color.fromARGB(255, 49, 47, 47)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final paint2 = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
          Offset((x + width / 2), 0),
          Offset((x + width / 2), height),
          [Colors.black, const ui.Color.fromARGB(255, 32, 31, 31)]);
    final path = Path()
      ..lineTo(x, y)
      ..lineTo(x + width, y)
      ..lineTo(size.width, 0);
    final path2 = Path()
      ..lineTo(x, y)
      ..lineTo(x + width, y)
      ..lineTo(size.width, 0);
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
