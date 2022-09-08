// SPDX-License-Identifier: Apache-2.0

import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

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
class PolyLinesDB {
  final List<LatLng> currPolyLineList;
  final List<LatLng> polyLineList;
  PolyLinesDB({required this.currPolyLineList, required this.polyLineList});
  PolyLinesDB copyWith({
    List<LatLng>? currPolyLineList,
    List<LatLng>? polyLineList,
  }) {
    return PolyLinesDB(
      currPolyLineList: currPolyLineList ?? this.currPolyLineList,
      polyLineList: polyLineList ?? this.polyLineList,
    );
  }
}

class PolyLineNotifier extends StateNotifier<PolyLinesDB> {
  static final PolyLinesDB initialvalue = PolyLinesDB(
    currPolyLineList: [],
    polyLineList: [],
  );
  PolyLineNotifier() : super(initialvalue);
  void update({
    List<LatLng>? currPolyLineList,
    List<LatLng>? polyLineList,
  }) {
    state = state.copyWith(
      currPolyLineList: currPolyLineList,
      polyLineList: polyLineList,
    );
  }
}

final polyLineStateProvider =
    StateNotifierProvider<PolyLineNotifier, PolyLinesDB>(
  (ref) => PolyLineNotifier(),
);

// -------------------------------------------------------------

class Gear {
  static String parking = "P";
  static String drive = "D";
  static String neutral = "N";
  static String reverse = "R";
}

double calculateDistance(point1, point2) {
  double p = 0.017453292519943295;

  double halfCosLatDiff = cos((point2.latitude - point1.latitude) * p) / 2;
  double halfCosLngDiff = cos((point2.longitude - point1.longitude) * p) / 2;

  double dist = 0.5 - halfCosLatDiff + cos(point1.latitude * p) * cos(point2.latitude * p) * (0.5 - halfCosLngDiff);

  return 12742 * asin(sqrt(dist));
}
