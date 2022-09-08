// SPDX-License-Identifier: Apache-2.0

import 'dart:math';
import 'package:flutter/material.dart';

class GuageProps {
  static GuageColors normalModeColor = GuageColors(
    inPrimary: const Color.fromARGB(255, 67, 67, 67),
    outPrimary: const Color.fromARGB(255, 120, 120, 120),
    secondary: const Color.fromARGB(156, 226, 226, 200),
  );
  static GuageColors sportModeColor = GuageColors(
      inPrimary: Colors.deepPurple,
      outPrimary: Colors.blue,
      secondary: const Color.fromARGB(214, 202, 202, 202));
  static GuageColors ecoModeColor = GuageColors(
      inPrimary: const Color.fromARGB(255, 85, 165, 87),
      outPrimary: const Color.fromARGB(255, 40, 92, 42),
      secondary: const Color.fromARGB(202, 194, 238, 195));
  static double majorAngle = 260;
  static double majorAngleRad = 260 * (pi / 180);
  static double minorAngle = 360 - majorAngle;
  static Color bgColor = const Color.fromARGB(255, 0, 0, 0);
  static const leftLowColor = Color(0x000000ff);
  static const leftHighColor = Color(0x00ff0000);

  static double degToRad(double deg) => deg * (pi / 180.0);
  static TextStyle gearIconStyle(screenHeight) {
    return TextStyle(
        color: const Color.fromARGB(255, 84, 83, 83),
        fontSize: (20 * screenHeight) / 480,
        fontWeight: FontWeight.bold);
  }

  static TextStyle activeGearIconStyle(screenHeight) {
    return TextStyle(
        color: Colors.white,
        fontSize: (20 * screenHeight) / 480,
        fontWeight: FontWeight.bold);
  }
}

class GuageColors {
  Color? inPrimary;
  Color? outPrimary;
  Color? secondary;
  GuageColors({this.inPrimary, this.outPrimary, this.secondary});
}
