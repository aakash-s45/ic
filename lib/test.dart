import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/vehicle_signal/vehicle_signal_config.dart';

class MyTest extends ConsumerWidget {
  const MyTest({
    Key? key,
  }) : super(key: key);
  // final? sock;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var trusted = ref.watch(dataProvider);

    // var ctx = SecurityContext(withTrustedRoots: true);
    // ctx.setTrustedCertificates("assets/cert/Server.pem");
    // ctx.setClientAuthorities('assets/cert/CA.pem');
    // ctx.useCertificateChain('assets/cert/Client.pem');
    // ctx.usePrivateKey('assets/cert/Client.key');

    // context.setTrustedCertificatesBytes(trusted.buffer.asUint8List);

    Map<String, dynamic> map = {
      "action": "authorize",
      "tokens": VehicleSignalConfig.authToken,
      "requestId": "dasghj"
    };
    var strmap = jsonEncode(map);
    // var sockweb=WebSocketChannel()
    HttpClient client;

    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              ByteData dataCA = await rootBundle.load('assets/cert/CA.pem');
              ByteData dataCert =
                  await rootBundle.load('assets/cert/Client.pem');
              ByteData dataKey =
                  await rootBundle.load('assets/cert/Client.key');
              ByteData dataServ =
                  await rootBundle.load('assets/cert/Server.pem');

              SecurityContext ctx = SecurityContext(withTrustedRoots: true);
              ctx.useCertificateChainBytes(dataCert.buffer.asUint8List());
              ctx.usePrivateKeyBytes(dataKey.buffer.asUint8List());
              ctx.setTrustedCertificatesBytes(dataServ.buffer.asUint8List());
              ctx.setClientAuthoritiesBytes(dataCA.buffer.asUint8List());
              client = HttpClient(context: ctx);

              client.badCertificateCallback = (cert, host, port) {
                // List a = (cert.pem.codeUnits);
                // List b = dataServ.buffer.asUint8List();
                // print(a.length);
                // print(b.length);
                // print(a == b);

                // String b = (utf8.decode(dataServ.buffer.asUint8List()));
                // for (int i = 0; i < a.length; i++) {
                //   // if (a[i] != b[i]) print("${a[i]} -> ${b[i]}");
                // }
                // print(a == b);
                // print(cert.der);
                // return a == b;
                return false;
              };

              var sock = await WebSocket.connect("wss://localhost:8090",
                  customClient: client);
              sock.listen((event) {
                // print(event);
              });
              sock.add(strmap);
            },
            child: const Text('press')),
        Text("hello".toString()),
      ],
    );
  }
}
