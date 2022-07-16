// ignore_for_file: unused_field

import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -------------------------------------------------------------
final speedProvider = StateNotifierProvider<Speed, double>((ref) {
  return Speed();
});

class Speed extends StateNotifier<double> {
  // Speed() : super(0);
  late final Timer _timer;
  Speed() : super(0) {
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (_) {
      random();
    });
  }
  void increment() => state++;
  void random() {
    state = (1 + Random().nextDouble() * 240);
    // print(state);
  }
}

// -------------------------------------------------------------
final rpmProvider = StateNotifierProvider<RPM, double>((ref) {
  return RPM();
});

class RPM extends StateNotifier<double> {
  // RPM() : super(100);
  late final Timer _timer;
  RPM() : super(0) {
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (_) {
      random();
    });
  }
  void increment() => state++;
  void random() {
    state = (1 + Random().nextDouble() * 8000);
  }
}

// -------------------------------------------------------------
final engineHeatProvider = StateNotifierProvider<Heat, double>((ref) {
  return Heat();
});

class Heat extends StateNotifier<double> {
  late final Timer _timer;
  Heat() : super(0) {
    _timer = Timer(const Duration(seconds: 2), () {
      update(100);
    });
  }
  void update(double val) {
    state = val;
  }
}

// -------------------------------------------------------------
final fuelProvider = StateNotifierProvider<Fuel, double>((ref) {
  return Fuel();
});

class Fuel extends StateNotifier<double> {
  late final Timer _timer;

  Fuel() : super(0) {
    _timer = Timer(const Duration(seconds: 2), () {
      update(100);
    });
  }
  void update(double val) {
    state = val;
  }

  // void update();
}

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

// -------------------------------------------------------------
final turnSignalProvider =
    StateNotifierProvider<TurnSignalProvider, int>((ref) {
  return TurnSignalProvider();
});

class TurnSignalProvider extends StateNotifier<int> {
  late final Timer _timer;
  TurnSignalProvider() : super(TurnSignal.off) {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      random();
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void random() {
    state = (1 + Random().nextInt(4));
    // print(state);
  }
}

class TurnSignal {
  static int off = 1;
  static int left = 2;
  static int right = 3;
  static int both = 4;
}

// -------------------------------------------------------------
// final gearProvider = StateNotifierProvider<GearInfo, int>((ref) {
//   return GearInfo();
// });

// class GearInfo extends StateNotifier<int> {
//   late final Timer _timer;
//   GearInfo() : super(Gear.neutral) {
//     _timer = Timer.periodic(const Duration(seconds: 2), (_) {
//       random();
//     });
//   }
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   void random() {
//     state = (1 + Random().nextInt(4));
//   }
// }

class Gear {
  static String parking = "P";
  static String drive = "D";
  static String neutral = "N";
  static String reverse = "R";
}

// -------------------------------------------------------------
// final indicatorProvider = StateNotifierProvider<IndicatorInfo, int>((ref) {
//   return IndicatorInfo();
// });

// class IndicatorInfo extends StateNotifier<int> {
//   late final Timer _timer;
//   IndicatorInfo() : super(Gear.neutral) {
//     _timer = Timer.periodic(const Duration(seconds: 2), (_) {
//       random();
//     });
//   }
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   void random() {
//     state = (1 + Random().nextInt(4));
//   }
// }

// class Indicators {}
// -------------------------------------------------------------

// final dataProvider = FutureProvider(
//     (ref) => PlatformAssetBundle().load("assets/cert/Server.pem"));
