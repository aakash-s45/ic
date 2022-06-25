import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ic/provider.dart';
import 'package:ic/screen/guage_widget.dart';

class SpeedGauge extends HookConsumerWidget {
  final double screenHeight;
  const SpeedGauge({Key? key, required this.screenHeight}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cSpeed = ref.watch(speedProvider);

    final animationController = useAnimationController(
      lowerBound: 0,
      upperBound: 240,
    )..animateTo(cSpeed,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.linearToEaseOut);

    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomGuage(
              size: (300 * screenHeight) / 480,
              low: 0,
              high: 240,
              mainValue: animationController.value,
              label: "Km/h",
              zeroTickLabel: "0",
              maxTickLabel: "240",
            ),
          );
        });
  }
}
