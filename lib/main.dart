// SPDX-License-Identifier: Apache-2.0

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cluster_dashboard/cluster_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpClient client = await initializeClient();
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: GetConfig(client: client),
      ),
    ),
  );
}
