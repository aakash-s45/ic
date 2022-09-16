// SPDX-License-Identifier: Apache-2.0

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_cluster_dashboard/cluster_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sockConnectprovider = FutureProvider.family<WebSocket, HttpClient>(
    (ref, client) => connect(client, ref));

// load certificates and set context and returns http client
Future<HttpClient> initializeClient() async {
  ByteData dataCert = await rootBundle.load('assets/cert/Client.pem');
  ByteData dataKey = await rootBundle.load('assets/cert/Client.key');

  SecurityContext ctx = SecurityContext.defaultContext;
  ctx.useCertificateChainBytes(dataCert.buffer.asUint8List());
  ctx.usePrivateKeyBytes(dataKey.buffer.asUint8List());
  HttpClient client = HttpClient(context: ctx)
    ..findProxy = null
    ..badCertificateCallback = (cert, host, port) {
      return true;
    };
  return client;
}

Future<WebSocket> connect(HttpClient client, ref) async {
  final config = ref.read(clusterConfigStateprovider);
  WebSocket socket = await WebSocket.connect(
      "wss://${config.hostname}:${config.port}",
      customClient: client);
  return socket;
}
