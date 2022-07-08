import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ic/screen/home.dart';
import 'package:ic/web_socket.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: MyTest(),
        // home: Home(),
      ),
    ),
  );
}
