// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_model.dart';

class Signals extends StatelessWidget {
  final VehicleSignal vehicle;
  final double screenHeight;
  static Color idleColor = const Color.fromARGB(194, 55, 53, 53);
  const Signals({
    Key? key,
    required this.screenHeight,
    required this.vehicle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runAlignment: WrapAlignment.spaceBetween,
      alignment: WrapAlignment.spaceEvenly,
      children: [
        (vehicle.isLowBeam)
            ? Image.asset("images/low-beam.png",
                color: Colors.green, width: (20 * screenHeight) / 480)
            : (vehicle.isHighBeam)
                ? Image.asset("images/high-beam.png",
                    color: Colors.green, width: (20 * screenHeight) / 480)
                : Image.asset("images/high-beam.png",
                    color: idleColor, width: (20 * screenHeight) / 480),
        Image.asset("images/hazard.png",
            color: (vehicle.isHazardLightOn) ? Colors.red : idleColor,
            width: (20 * screenHeight) / 480),
        Image.asset("images/parking.png",
            color: (vehicle.isParkingOn) ? Colors.green : idleColor,
            width: (20 * screenHeight) / 480),
        Image.asset("images/battery.png",
            color: (vehicle.isBatteryCharging) ? Colors.green : Colors.red,
            width: (20 * screenHeight) / 480),
        Image.asset("images/malfunction.png",
            color: (vehicle.isMILon) ? Colors.red : idleColor,
            width: (20 * screenHeight) / 480),
        //
        Image.asset("images/openDoor.png",
            color: (vehicle.isMILon) ? Colors.white : idleColor,
            width: (20 * screenHeight) / 480),

        Image.asset("images/seatBelt.png",
            color: (vehicle.isMILon) ? Colors.white : idleColor,
            width: (20 * screenHeight) / 480),

        //
        Image.asset("images/lane.png",
            color: (vehicle.isSteeringLaneWarning) ? Colors.white : idleColor,
            width: (25 * screenHeight) / 480),
        Image.asset("images/cruise.png",
            color: (vehicle.isSteeringCruiseEnable)
                ? (vehicle.isSteeringCruiseSet)
                    ? Colors.green
                    : Colors.orange
                : idleColor,
            width: (20 * screenHeight) / 480),
      ],
    );
  }
}
