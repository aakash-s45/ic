import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ic/screen/paints/arc_painter.dart';
import 'package:ic/vehicle_signal/vehicle_signal_model.dart';
import 'package:ic/vehicle_signal/vehicle_signal_provider.dart';

class RightArc extends HookConsumerWidget {
  final double screenHeight;
  const RightArc({Key? key, required this.screenHeight}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VehicleSignal vehicle = ref.watch(vehicleSignalProvider);
    // final fuel = ref.watch(fuelProvider);
    final animationController = useAnimationController(
      lowerBound: 0,
      upperBound: 100,
    )..animateTo(vehicle.fuelLevel,
        duration: const Duration(milliseconds: 500));

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return CustomPaint(
          size: Size(0, (250 * screenHeight) / 480),
          painter: RightPainter(
              radi: (205 * screenHeight) / 480,
              currentValue: animationController.value,
              bottomPadding: 17,
              // bottomPadding: (15 * screenHeight) / 480,
              color: Color.lerp(Colors.red, Colors.green,
                      (animationController.value / 100)) ??
                  Colors.blue),
        );
      },
    );
  }
}
