// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RightSignal extends HookConsumerWidget {
  final double screenHeight;
  const RightSignal({Key? key, required this.screenHeight}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      lowerBound: 0.9,
      upperBound: 1.1,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Image.asset(
            "images/right.png",
            color: Color.lerp(
                Colors.black,
                const Color.fromARGB(255, 99, 251, 104),
                animationController.value.floorToDouble()),
            width: 0.125 * screenHeight,
          );
        });
  }
}
