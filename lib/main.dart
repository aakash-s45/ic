import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ic/vehicle_signal/initial_socket_connection.dart';
import 'package:ic/vehicle_signal/vehicle_signal_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpClient client = await initializeClient();
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: InitialScreen(client: client),
      ),
    ),
  );
}
