import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ic/provider.dart';
import 'package:ic/screen/guage_widget.dart';

class RPMGauge extends HookConsumerWidget {
  final double screenHeight;
  const RPMGauge({Key? key, required this.screenHeight}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rpm = ref.watch(rpmProvider);
    const double minRPM = 0;
    const double maxRPM = 8000;
    const Duration sweepDuration = Duration(milliseconds: 200);

    final animationController = useAnimationController(
      lowerBound: minRPM,
      upperBound: maxRPM,
    )..animateTo(rpm, duration: sweepDuration, curve: Curves.linearToEaseOut);
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomGuage(
              size: (300 * screenHeight) / 480,
              low: minRPM,
              high: maxRPM,
              mainValue: animationController.value,
              label: "rpm",
              zeroTickLabel: minRPM.toInt().toString(),
              maxTickLabel: maxRPM.toInt().toString(),
            ),
          );
        });
  }
}
