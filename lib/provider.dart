import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -------------------------------------------------------------
final clockProvider = StateNotifierProvider<Clock, DateTime>((ref) {
  return Clock();
});

class Clock extends StateNotifier<DateTime> {
  late final Timer _timer;
  Clock() : super(DateTime.now()) {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      state = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class Gear {
  static String parking = "P";
  static String drive = "D";
  static String neutral = "N";
  static String reverse = "R";
}
