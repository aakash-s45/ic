// SPDX-License-Identifier: Apache-2.0

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_cluster_dashboard/screen/paints/guage_paint.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/guages/guage_props.dart';

class CustomGuage extends StatelessWidget {
  const CustomGuage({
    Key? key,
    required this.mainValue,
    required this.low,
    required this.high,
    required this.label,
    this.zeroTickLabel,
    this.maxTickLabel,
    this.distanceBWTicks,
    this.size,
    this.distLabelTop,
    this.distMainTop,
    this.distTicksBottom,
    this.inPrimaryColor,
    this.outPrimaryColor,
    this.secondaryColor,
  }) : super(key: key);

  final double mainValue;
  final double low;
  final double high;
  final String label;
  final String? zeroTickLabel;
  final String? maxTickLabel;
  final double? distanceBWTicks;
  final double? distTicksBottom;
  final double? distMainTop;
  final double? distLabelTop;
  final double? size;
  final Color? outPrimaryColor;
  final Color? inPrimaryColor;
  final Color? secondaryColor;

  @override
  Widget build(BuildContext context) {
    TextStyle tickStyle = TextStyle(
        color: Colors.white,
        fontSize: ((26 / 400) * (size ?? 400)),
        fontWeight: FontWeight.bold); //20
    TextStyle mainValueTextStyle = TextStyle(
        color: Colors.white,
        fontSize: ((85 / 400) * (size ?? 400)),
        fontWeight: FontWeight.bold); //65
    TextStyle labelTextStyle = TextStyle(
        color: Colors.white,
        fontSize: ((26 / 400) * (size ?? 400)),
        fontWeight: FontWeight.normal); //20
    return SizedBox(
      width: size ?? 400,
      height: size ?? 400,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Guage painter
          Positioned(
            top: 0,
            child: Transform.rotate(
              angle: (pi / 2) + (GuageProps.minorAngle * (pi / 360.0)),
              child: CustomPaint(
                size: Size(size ?? 400, size ?? 400),
                painter: GuagePainter(
                  low: low,
                  high: high,
                  currentSpeed: mainValue,
                  inPrimaryColor: inPrimaryColor,
                  outPrimaryColor: outPrimaryColor,
                  secondaryColor: secondaryColor,
                ),
              ),
            ),
          ),
          // Guage Label
          Positioned(
            top: distLabelTop ?? ((100 / 400) * (size ?? 400)),
            child: Text(label, style: labelTextStyle),
          ),
          // Guage Main Value
          Positioned(
            top: distMainTop ?? ((150 / 400) * (size ?? 400)),
            child: Text("${mainValue.toInt()}", style: mainValueTextStyle),
          ),
          // Guage Ticks value
          Positioned(
            bottom: distTicksBottom ?? ((80 / 400) * (size ?? 400)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(zeroTickLabel ?? "", style: tickStyle),
                SizedBox(
                    width: (size != null)
                        ? ((180 * size!) / 400)
                        : (distanceBWTicks ?? 180)),
                Text(maxTickLabel ?? "", style: tickStyle)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
