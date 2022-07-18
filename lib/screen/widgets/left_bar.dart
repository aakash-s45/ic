import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ic/screen/paints/arc_painter.dart';
import 'package:ic/vehicle_signal/vehicle_signal_model.dart';
import 'package:ic/vehicle_signal/vehicle_signal_provider.dart';

class LeftArc extends HookConsumerWidget {
  final double screenHeight;
  const LeftArc({Key? key, required this.screenHeight}) : super(key: key);
  // final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VehicleSignal vehicle = ref.watch(vehicleSignalProvider);
    // final heat = ref.watch(engineHeatProvider);
    final animationController = useAnimationController(
      lowerBound: 0,
      upperBound: 100,
    )..animateTo(vehicle.coolantTemp,
        duration: const Duration(milliseconds: 1000));

    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return CustomPaint(
            size: Size(0, (250 * screenHeight) / 480),
            painter: LeftPainter(
              radi: (195 * screenHeight) / 480,
              currentValue: animationController.value,
              bottomPadding: 15,
              // bottomPadding: (12   * screenHeight) / 480,
              color: Color.lerp(Colors.yellow, Colors.red,
                      (animationController.value / 100)) ??
                  Colors.orange,
            ),
          );
        });
  }
}

// 0-------------1
// yellow  red