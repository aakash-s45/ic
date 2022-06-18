import 'dart:math';
import 'package:flutter/material.dart';

class GuageProps {
  static double majorAngle = 260;
  static double majorAngleRad = 260 * (pi / 180);
  static double minorAngle = 360 - majorAngle;
  static Color bgColor = const Color.fromARGB(255, 0, 0, 0);

  static double degToRad(double deg) => deg * (pi / 180.0);
}
