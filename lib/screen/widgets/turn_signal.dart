// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TurnSignal extends HookConsumerWidget {
  final double screenHeight;
  final bool isLefton;
  final bool isRighton;
  const TurnSignal({
    Key? key,
    required this.screenHeight,
    required this.isLefton,
    required this.isRighton,
  }) : super(key: key);
  double calcPadding(double value, double height) {
    // values wrt to values at 720 height
    return (value * height) / 720;
  }

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
          return Padding(
            padding: EdgeInsets.fromLTRB(calcPadding(150, screenHeight), 0,
                calcPadding(150, screenHeight), 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/left.png",
                  color: (isLefton)
                      ? Color.lerp(
                          Colors.black,
                          const Color.fromARGB(255, 99, 251, 104),
                          animationController.value.floorToDouble())
                      : const Color.fromARGB(255, 49, 48, 48),
                  width: 0.125 * screenHeight,
                ),
                Image.asset(
                  "images/right.png",
                  color: (isRighton)
                      ? Color.lerp(
                          Colors.black,
                          const Color.fromARGB(255, 99, 251, 104),
                          animationController.value.floorToDouble())
                      : const Color.fromARGB(255, 49, 48, 48),
                  width: 0.125 * screenHeight,
                ),
              ],
            ),
          );
        });
  }
}
