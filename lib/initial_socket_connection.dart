// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/onboarding_page.dart';
import 'package:ic/vehicle_signal/vehicle_signal_config.dart';

@immutable
class InitialScreen extends ConsumerWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final sockConnect = ref.watch(sockConnectprovider);
    return sockConnect.when(
      data: (socket) {
        return (socket != null)
            ? OnBoardingPage(socket: socket)
            : const Text("! can't connect !");
      },
      error: (e, stk) => Text(e.toString()),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
