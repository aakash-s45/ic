import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ic/onboarding_page.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // assert(await addCertificate());
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: OnBoardingPage(),
        // home: Home(),
      ),
    ),
  );
}
