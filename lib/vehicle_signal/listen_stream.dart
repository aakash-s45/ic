// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/screen/home.dart';
import 'package:ic/vehicle_signal/vehicle_signal_config.dart';
import 'package:ic/vehicle_signal/vehicle_signal_methods.dart';

class OnBoardingPage extends ConsumerStatefulWidget {
  const OnBoardingPage({Key? key, required this.client, required this.socket})
      : super(key: key);
  final WebSocket socket;
  final HttpClient client;

  @override
  ConsumerState<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends ConsumerState<OnBoardingPage> {
  late Timer _timer;
  // static const int open = 1;
  // static const int closed = 3;

  @override
  void initState() {
    super.initState();
    VISS.init(widget.socket);
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      // print(widget.socket.readyState);
      if (widget.socket.readyState == 3) {
        ref.refresh(sockConnectprovider(widget.client));
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.socket.listen(
        (data) {
          VISS.parseData(ref, data);
          // print(data);
        },
        onError: (e, stk) {
          print(e.toString());
          ref.refresh(sockConnectprovider(widget.client));
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    widget.socket.close(786887, "Connection lost with server!");
    // widget.socket.close(12368236471, "Restarting App!");
  }

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}
