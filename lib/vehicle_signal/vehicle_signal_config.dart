// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// test

class VehicleSignalConfig {
  static String authTokenPath = "assets/cert/jwt/all_read_write.json.token";
  static String hostname = "127.0.0.1";
  static int port = 8090;
  static String uri = "ws://${hostname}:${port}";
  static String s_uri = "wss://${hostname}:${port}";
  static String authToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJrdWtzYS52YWwiLCJpc3MiOiJFY2xpcHNlIEtVS1NBIERldiIsImFkbWluIjp0cnVlLCJpYXQiOjE1MTYyMzkwMjIsImV4cCI6MTc2NzIyNTU5OSwia3Vrc2EtdnNzIjp7IioiOiJydyJ9fQ.QQcVR0RuRJIoasPXYsMGZhdvhLjUalk4GcRaxhh3-0_j3CtVSZ0lTbv_Z3As5BfIYzaMlwUzFGvCVOq2MXVjRK81XOAZ6wIsyKOxva16zjbZryr2V_m3yZ4twI3CPEzJch11_qnhInirHltej-tGg6ySfLaTYeAkw4xYGwENMBBhN5t9odANpScZP_xx5bNfwdW1so6FkV1WhpKlCywoxk_vYZxo187d89bbiu-xOZUa5D-ycFkd1-1rjPXLGE_g5bc4jcQBvNBc-5FDbvt4aJlTQqjpdeppxhxn_gjkPGIAacYDI7szOLC-WYajTStbksUju1iQCyli11kPx0E66me_ZVwOX07f1lRF6D2brWm1LcMAHM3bQUK0LuyVwWPxld64uSAEsvSKsRyJERc7nZUgLf7COnUrrkxgIUNjukbdT2JVN_I-3l3b4YXg6JVD7Y5g0QYBKgXEFpZrDbBVhzo7PXPAhJD6-c3DcUQyRZExbrnFV56RwWuExphw8lYnbMvxPWImiVmB9nRVgFKD0TYaw1sidPSSlZt8Uw34VZzHWIZQAQY0BMjR33fefg42XQ1YzIwPmDx4GYXLl7HNIIVbsRsibKaJnf49mz2qnLC1K272zXSPljO11Ke1MNnsnKyUH7mcwEs9nhTsnMgEOx_TyMLRYo-VEHBDLuEOiBo";
}

final sockConnectprovider = FutureProvider.family<WebSocket, HttpClient>(
    (ref, client) => connect(client));

Future connectWebSoket() async {
  HttpClient client = await initializeClient();
  WebSocket socket = await connect(client);
  return [client, socket];
}

// load certificates and set context and returns http client
Future<HttpClient> initializeClient() async {
  ByteData dataCA = await rootBundle.load('assets/cert/CA.pem');
  ByteData dataCert = await rootBundle.load('assets/cert/Client.pem');
  ByteData dataKey = await rootBundle.load('assets/cert/Client.key');
  // ByteData dataServ = await rootBundle.load('assets/cert/Server.pem');

  SecurityContext ctx = SecurityContext.defaultContext;
  ctx.useCertificateChainBytes(dataCert.buffer.asUint8List());
  ctx.usePrivateKeyBytes(dataKey.buffer.asUint8List());
  ctx.setTrustedCertificatesBytes(dataCA.buffer.asUint8List());
  // ctx.setClientAuthoritiesBytes(dataCA.buffer.asUint8List());
  HttpClient client = HttpClient(context: ctx)
    ..findProxy = null
    ..badCertificateCallback = (cert, host, port) {
      return true;
    };
  return client;
}

// user VehicleSignalConfig.s_uri for secure websocket inplace of uri
// returns WebSocket after connection
Future<WebSocket> connect(HttpClient client) async {
  WebSocket socket =
      await WebSocket.connect(VehicleSignalConfig.s_uri, customClient: client);
  return socket;
}
