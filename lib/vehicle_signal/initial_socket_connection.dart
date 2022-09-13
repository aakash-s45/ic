// SPDX-License-Identifier: Apache-2.0

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/listen_stream.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_config.dart';

class InitialScreen extends ConsumerWidget {
  InitialScreen({Key? key, required this.client}) : super(key: key);
  final HttpClient client;
  late WebSocket socket;

  @override
  Widget build(BuildContext context, ref) {
    final sockConnect = ref.watch(sockConnectprovider(client));

    return sockConnect.when(
      data: (socket) {
        this.socket = socket;
        this.socket.pingInterval = const Duration(seconds: 2);
        return OnBoardingPage(client: client, socket: this.socket);
      },
      error: (e, stk) {
        print(e);
        Future.delayed(const Duration(milliseconds: 700), (() {
          ref.refresh(sockConnectprovider(client));
        }));
        return const Scaffold(
          backgroundColor: Colors.black,
          body: NoticeWidget(
            assetImageName: "images/server_error.png",
            text1: "Server Unavailable",
            text2: "Retrying to conncect!",
          ),
        );
      },
      loading: () => const Scaffold(
        backgroundColor: Colors.black,
        body: NoticeWidget(
          assetImageName: "images/server.png",
          text1: "Hi!",
          text2: "Connecting...!",
        ),
      ),
    );
  }
}

class NoticeWidget extends StatelessWidget {
  const NoticeWidget({
    Key? key,
    required this.assetImageName,
    required this.text1,
    required this.text2,
    this.loadingColor,
  }) : super(key: key);

  final String assetImageName;
  final String text1;
  final String text2;
  final Color? loadingColor;

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
        child: Flex(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      direction: Axis.vertical,
      children: [
        Flexible(
          child: SizedBox(
            height: 100,
            child:
                Image(image: AssetImage(assetImageName), fit: BoxFit.fitWidth),
          ),
        ),
        Flexible(
            child: Text(text1,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        Flexible(
            child: Text(text2,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
            child: LinearProgressIndicator(color: loadingColor ?? Colors.red),
          ),
        )
      ],
    ));
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height * 3 / 4,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40)),
          child: child,
        ),
      ),
    );
  }
}
