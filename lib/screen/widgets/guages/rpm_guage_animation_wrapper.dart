// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/guages/guage_props.dart';
import 'package:flutter_cluster_dashboard/screen/widgets/guages/guage_widget.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_model.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_provider.dart';

class RPMGauge extends HookConsumerWidget {
  final double screenHeight;
  final GuageColors? guageColor;
  const RPMGauge({Key? key, required this.screenHeight, this.guageColor})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VehicleSignal vehicle = ref.watch(vehicleSignalProvider);

    const double minRPM = 0;
    const double maxRPM = 8000;
    const Duration sweepDuration = Duration(milliseconds: 200);

    final animationController = useAnimationController(
      lowerBound: minRPM,
      upperBound: maxRPM,
    )..animateTo(vehicle.rpm,
        duration: sweepDuration, curve: Curves.linearToEaseOut);
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomGuage(
              size: (248 * screenHeight) / 480,
              low: minRPM,
              high: maxRPM,
              mainValue: animationController.value,
              label: "rpm",
              zeroTickLabel: minRPM.toInt().toString(),
              maxTickLabel: maxRPM.toInt().toString(),
              inPrimaryColor: guageColor?.inPrimary,
              outPrimaryColor: guageColor?.outPrimary,
              secondaryColor: guageColor?.secondary,
            ),
          );
        });
  }
}
