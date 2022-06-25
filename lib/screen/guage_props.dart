import 'dart:math';
import 'package:flutter/material.dart';

class GuageProps {
  static double majorAngle = 260;
  static double majorAngleRad = 260 * (pi / 180);
  static double minorAngle = 360 - majorAngle;
  static Color bgColor = const Color.fromARGB(255, 0, 0, 0);
  static const leftLowColor = Color(0x000000ff);
  static const leftHighColor = Color(0x00ff0000);

  static double degToRad(double deg) => deg * (pi / 180.0);
  static const TextStyle gearIconStyle = TextStyle(
      color: Color.fromARGB(255, 84, 83, 83),
      fontSize: 20,
      fontWeight: FontWeight.bold);
  static const TextStyle activeGearIconStyle =
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
}
