// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter_cluster_dashboard/screen/widgets/guages/guage_props.dart';

class GuagePainter extends CustomPainter {
  final double low, high;
  double currentSpeed;
  final Color? outPrimaryColor;
  final Color? inPrimaryColor;
  final Color? secondaryColor;
  GuagePainter({
    required this.low,
    required this.high,
    required this.currentSpeed,
    this.outPrimaryColor,
    this.inPrimaryColor,
    this.secondaryColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    double radius1 = radius - ((20 / 200) * (radius));
    double speedAngle =
        GuageProps.degToRad((GuageProps.majorAngle / high) * currentSpeed);

    final zeroTickPaint = Paint()
      ..strokeWidth = ((7 / 200) * (radius))
      ..shader = ui.Gradient.radial(center, radius1,
          [Colors.black, const Color.fromARGB(255, 244, 242, 231)], [1, 0.5]);
    final maxTickPaint = Paint()
      ..strokeWidth = ((7 / 200) * (radius))
      ..shader = ui.Gradient.radial(center, radius1,
          [Colors.black, const Color.fromARGB(255, 244, 242, 231)], [1, 0.5]);

    final speedPathStrokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = ((7 / 200) * (radius))
      ..shader = ui.Gradient.radial(
          center, radius1, [Colors.black, Colors.white], [0.6, 1]);

    final speedPathFillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.radial(center, radius1, [
        const ui.Color.fromARGB(0, 0, 0, 0),
        secondaryColor ?? const Color.fromARGB(156, 226, 226, 200)
      ], [
        0.8,
        1
      ]);

    final outerPathPaint = ui.Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.radial(
        center,
        radius,
        [
          Colors.black,
          outPrimaryColor ?? const Color.fromARGB(255, 120, 120, 120)
        ],
        [0.8, 0.9],
      );

    final innerPathPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.radial(center, radius1, [
        Colors.black,
        inPrimaryColor ?? const Color.fromARGB(255, 67, 67, 67)
      ], [
        0.65,
        0.9
      ]);

    final outerPathPaintRed = ui.Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.radial(
        center,
        radius,
        [Colors.black, const Color.fromARGB(255, 187, 59, 57)],
        [0.8, 0.9],
      );

    final innerPathPaintRed = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.radial(center, radius1,
          [Colors.black, const Color.fromARGB(255, 142, 35, 39)], [0.65, 0.9]);

    for (double i = 0; i < 13; i++) {
      double startAngle = GuageProps.degToRad(i * 20);
      double gapAngle = GuageProps.degToRad(19);

      var outerPath = Path();
      outerPath.addArc(Rect.fromCircle(center: center, radius: radius),
          startAngle, gapAngle);
      outerPath.lineTo(center.dx, center.dy);
      outerPath.close();

      var innerPath = Path();
      innerPath.addArc(Rect.fromCircle(center: center, radius: radius1),
          startAngle, gapAngle);
      innerPath.lineTo(center.dx, center.dy);
      innerPath.close();
      if (i >= 11) {
        canvas.drawPath(outerPath, outerPathPaintRed);
        canvas.drawPath(innerPath, innerPathPaintRed);
      } else {
        canvas.drawPath(outerPath, outerPathPaint);
        canvas.drawPath(innerPath, innerPathPaint);
      }
    }

    var speedStrokePath = Path();
    speedStrokePath.moveTo(center.dx, center.dy);
    speedStrokePath.addArc(
        Rect.fromCircle(center: center, radius: radius), 0, speedAngle);
    speedStrokePath.lineTo(center.dx, center.dy);

    var speedFillPath = Path();
    speedFillPath.addArc(
        Rect.fromCircle(center: center, radius: radius), 0, speedAngle);
    speedFillPath.lineTo(center.dx, center.dy);
    speedFillPath.close();

    canvas.drawPath(speedFillPath, speedPathFillPaint);
    canvas.drawPath(speedStrokePath, speedPathStrokePaint);
    canvas.drawLine(
        center,
        Offset(center.dx + (radius + ((3 / 200) * (radius))), center.dy),
        zeroTickPaint);
    canvas.drawLine(
        center,
        Offset(center.dx + (radius) * cos(GuageProps.majorAngleRad),
            center.dy + (radius) * sin(GuageProps.majorAngleRad)),
        maxTickPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
