import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ic/initial_socket_connection.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        // home: MyTest(),
        home: InitialScreen(),
      ),
    ),
  );
}





/*





*/