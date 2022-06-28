import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ic/screen/guage_widget.dart';
import 'package:ic/vehicle_signal/vehicle_signal_model.dart';
import 'package:ic/vehicle_signal/vehicle_signal_provider.dart';

class SpeedGauge extends HookConsumerWidget {
  final double screenHeight;
  const SpeedGauge({Key? key, required this.screenHeight}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final VehicleSignal vehicle = ref.watch(vehicleSignalProvider);
    // final double cSpeed = ref.watch(speedProvider);

    const double minSpeed = 0;
    const double maxSpeed = 240;
    const Duration sweepDuration = Duration(milliseconds: 200);

    final animationController = useAnimationController(
      lowerBound: minSpeed,
      upperBound: maxSpeed,
    )..animateTo(vehicle.speed,
        duration: sweepDuration, curve: Curves.linearToEaseOut);

    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomGuage(
              size: (300 * screenHeight) / 480,
              low: minSpeed,
              high: maxSpeed,
              mainValue: animationController.value,
              label: "Km/h",
              zeroTickLabel: minSpeed.toInt().toString(),
              maxTickLabel: maxSpeed.toInt().toString(),
            ),
          );
        });
  }
}
