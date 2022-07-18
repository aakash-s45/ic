import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:ic/screen/guage_props.dart';

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
          center,
          radius1,
          [Colors.black, const ui.Color.fromARGB(255, 244, 242, 232)],
          [0.6, 1]);

    final speedPathFillPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.radial(center, radius1, [
        const ui.Color.fromARGB(0, 0, 0, 0),
        secondaryColor ?? const Color.fromARGB(156, 254, 253, 169)
        // const Color.fromARGB(156, 254, 253, 169)
      ], [
        0.8,
        1
      ]);

    final outerPathPaint = ui.Paint()
      ..style = PaintingStyle.fill
      // ..color = const ui.Color.fromARGB(255, 233, 73, 71);
      ..shader = ui.Gradient.radial(
        center,
        radius,
        [
          Colors.black,
          outPrimaryColor ?? const ui.Color.fromARGB(255, 233, 73, 71)
        ],
        [0.8, 0.9],
        // [0.65, 0.9],
      );

    final innerPathPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.radial(center, radius1, [
        Colors.black,
        inPrimaryColor ?? const ui.Color.fromRGBO(168, 42, 47, 1)
      ], [
        0.65,
        0.9
      ]);

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

      canvas.drawPath(outerPath, outerPathPaint);
      canvas.drawPath(innerPath, innerPathPaint);
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
