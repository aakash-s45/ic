// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_cluster_dashboard/screen/paints/arc_painter.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_model.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_provider.dart';

class LeftArc extends HookConsumerWidget {
  final double screenHeight;
  const LeftArc({Key? key, required this.screenHeight}) : super(key: key);
  // final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VehicleSignal vehicle = ref.watch(vehicleSignalProvider);
    final animationController = useAnimationController(
      lowerBound: 0,
      upperBound: 100,
    )..animateTo(vehicle.coolantTemp,
        duration: const Duration(milliseconds: 1000));

    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return CustomPaint(
            size: Size(0, (220 * screenHeight) / 480),
            painter: LeftPainter(
              radi: (170 * screenHeight) / 480,
              currentValue: animationController.value,
              bottomPadding: 15,
              color: Color.lerp(Colors.yellow, Colors.red,
                      (animationController.value / 100)) ??
                  Colors.orange,
            ),
          );
        });
  }
}
