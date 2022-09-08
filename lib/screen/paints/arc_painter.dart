// SPDX-License-Identifier: Apache-2.0

import 'dart:math';
import 'package:flutter/material.dart';

class LeftPainter extends CustomPainter {
  LeftPainter(
      {required this.radi,
      required this.currentValue,
      required this.bottomPadding,
      required this.color});

  late final double radi;
  late final double currentValue;
  late final double bottomPadding;
  late final Color color;

  Offset getLeftPoints(Size size, double radius, double value) {
    final double diam = 2 * radius;
    final double arcHalfAngle = asin(size.height / diam); //thetha
    final double currentAngle = (arcHalfAngle * value) / 50; //alpha
    return Offset(
        (radi * cos(arcHalfAngle)) +
            (size.width) -
            (radi * cos(arcHalfAngle - currentAngle)),
        (radi * sin(arcHalfAngle)) + (radi * sin(arcHalfAngle - currentAngle)));
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset startPoint = getLeftPoints(size, radi, bottomPadding);

    final paint = Paint()
      ..color = const Color.fromARGB(255, 49, 48, 48)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = radi / 15;
    final paint2 = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = radi / 15;

    final path = Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      ..arcToPoint(Offset(size.width, 0), radius: Radius.circular(radi));
    canvas.drawPath(path, paint);
    final path2 = Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      ..arcToPoint(
          getLeftPoints(size, radi,
              bottomPadding + ((1 - (bottomPadding / 100)) * currentValue)),
          radius: Radius.circular(radi));
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class RightPainter extends CustomPainter {
  RightPainter(
      {required this.radi,
      required this.currentValue,
      required this.bottomPadding,
      required this.color});
  final double radi;
  final double currentValue;
  late final double bottomPadding;
  late final Color color;

  Offset getRightPoints(Size size, double radius, double value) {
    final double diam = 2 * radius;
    final double arcHalfAngle = asin(size.height / diam); //thetha
    final double currentAngle = (arcHalfAngle * value) / 50; //alpha
    return Offset(
        (radi * cos(arcHalfAngle - currentAngle)) - (radi * cos(arcHalfAngle)),
        (radi * sin(arcHalfAngle)) + (radi * sin(arcHalfAngle - currentAngle)));
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset startPoint = getRightPoints(size, radi, bottomPadding);
    final paint = Paint()
      ..color = const Color.fromARGB(255, 49, 48, 48)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = radi / 15;

    final paint2 = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = radi / 15;
    final path = Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      ..arcToPoint(
        const Offset(0, 0),
        radius: Radius.circular(radi),
        clockwise: false,
      );
    final path2 = Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      ..arcToPoint(
          getRightPoints(size, radi,
              bottomPadding + ((1 - (bottomPadding / 100)) * currentValue)),
          radius: Radius.circular(radi),
          clockwise: false);
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
