// ignore_for_file: non_constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/vehicle_signal/vehicle_signal_config.dart';
import 'package:ic/vehicle_signal/vehicle_signal_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// final channel_provider = Provider.family((ref, uri) => );
final channel_provider = Provider<WebSocketChannel>(
    (ref) => WebSocketChannel.connect(Uri.parse(VehicleSignalConfig.uri)));

final viss_stream = StreamProvider(((ref) {
  final channel = ref.watch(channel_provider);
  return channel.stream;
}));

final vehicleSignalProvider =
    StateNotifierProvider<VehicleSignalNotifier, VehicleSignal>(
  (ref) => VehicleSignalNotifier(),
);

class VehicleSignalNotifier extends StateNotifier<VehicleSignal> {
  VehicleSignalNotifier() : super(_initialValue);
  static final VehicleSignal _initialValue = VehicleSignal(
    speed: 240,
    rpm: 8000,
    fuelLevel: 100,
    coolantTemp: 100,
    isLeftIndicator: true,
    isRightIndicator: true,
    selectedGear: "P",
    performanceMode: "normal",
    isHazardLightOn: true,
    isHighBeam: true,
    isLowBeam: false,
    isParkingOn: false,
    travelledDistance: 888,
  );
  void update({
    double? speed,
    double? rpm,
    double? fuelLevel,
    double? coolantTemp,
    bool? isLeftIndicator,
    bool? isRightIndicator,
    String? selectedGear,
    String? performanceMode,
    bool? isLowBeam,
    bool? isHighBeam,
    bool? isHazardLightOn,
    bool? isParkingOn,
    double? travelledDistance,
  }) {
    state = state.copyWith(
      speed: speed,
      rpm: rpm,
      fuelLevel: fuelLevel,
      coolantTemp: coolantTemp,
      isLeftIndicator: isLeftIndicator,
      isRightIndicator: isRightIndicator,
      selectedGear: selectedGear,
      isLowBeam: isLowBeam,
      isHighBeam: isHighBeam,
      isHazardLightOn: isHazardLightOn,
      travelledDistance: travelledDistance,
      performanceMode: performanceMode,
      isParkingOn: isParkingOn,
    );
  }
}
