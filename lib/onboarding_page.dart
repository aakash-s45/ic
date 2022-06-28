// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/screen/home.dart';
import 'package:ic/vehicle_signal/vehicle_signal_methods.dart';
import 'package:ic/vehicle_signal/vehicle_signal_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class OnBoardingPage extends ConsumerStatefulWidget {
  const OnBoardingPage({Key? key, required this.socket}) : super(key: key);
  final WebSocket socket;

  @override
  ConsumerState<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends ConsumerState<OnBoardingPage> {
  late final WebSocketChannel channel;
  // late final WebSocket socket;

  @override
  void initState() {
    super.initState();
    channel = ref.read(channel_provider);
    VISS.init(widget.socket);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.socket.listen(
        (data) {
          VISS.parseData(ref, data);
          print(data);
        },
        onError: (e, stk) => print(e.toString()),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.socket.close(123, "Restarting App!");
  }

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}
