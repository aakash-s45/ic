// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/vehicle_signal/listen_stream.dart';
import 'package:ic/vehicle_signal/vehicle_signal_config.dart';

class InitialScreen extends ConsumerWidget {
  InitialScreen({Key? key, required this.client}) : super(key: key);
  final HttpClient client;
  late final WebSocket socket;

  @override
  Widget build(BuildContext context, ref) {
    final sockConnect = ref.watch(sockConnectprovider(client));

    return sockConnect.when(
      data: (socket) {
        this.socket = socket;
        return (this.socket != null)
            ? OnBoardingPage(socket: this.socket)
            : const Text("! can't connect !");
      },
      error: (e, stk) {
        ref.refresh(sockConnectprovider(client));
        return Container();
      },
      // Material(
      //   child: InkWell(
      //     onTap: () {
      //       ref.refresh(sockConnectprovider(client));
      //     },
      //     child: Container(
      //       width: 400,
      //       height: 400,
      //       color: Colors.white,
      //       child: const Center(child: Text("Tap any where to retry !")),
      //     ),
      //   ),
      // ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
