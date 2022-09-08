// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/guages/guage_props.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/guages/guage_widget.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_model.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_provider.dart';

class SpeedGauge extends HookConsumerWidget {
  final double screenHeight;
  final GuageColors? guageColor;
  const SpeedGauge({Key? key, required this.screenHeight, this.guageColor})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VehicleSignal vehicle = ref.watch(vehicleSignalProvider);

    const double minSpeed = 0;
    const double maxSpeed = 240;
    const Duration sweepDuration = Duration(milliseconds: 200);
    double speedScaling =
        (vehicle.vehicleDistanceUnit == "mi") ? 0.621504 : 1.0;

    final animationController = useAnimationController(
      lowerBound: minSpeed,
      upperBound: maxSpeed,
    )..animateTo(speedScaling * (vehicle.speed),
        duration: sweepDuration, curve: Curves.linearToEaseOut);

    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomGuage(
              size: (248 * screenHeight) / 480,
              low: minSpeed,
              high: maxSpeed,
              mainValue: animationController.value,
              label: (vehicle.vehicleDistanceUnit == "mi") ? "mph" : "Km/h",
              zeroTickLabel: minSpeed.toInt().toString(),
              maxTickLabel: maxSpeed.toInt().toString(),
              inPrimaryColor: guageColor?.inPrimary,
              outPrimaryColor: guageColor?.outPrimary,
              secondaryColor: guageColor?.secondary,
            ),
          );
        });
  }
}

final guageColorProvider = Provider.family<GuageColors, String>((ref, mode) {
  switch (mode) {
    case "normal":
      return GuageColors(inPrimary: Colors.red);
    case "sports":
      return GuageColors(inPrimary: Colors.blue);
    case "eco":
      return GuageColors(inPrimary: Colors.green);
    default:
      return GuageColors();
  }
});
