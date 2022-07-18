// ignore_for_file: non_constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/vehicle_signal/vehicle_signal_model.dart';

final vehicleSignalProvider =
    StateNotifierProvider<VehicleSignalNotifier, VehicleSignal>(
  (ref) => VehicleSignalNotifier(),
);

class VehicleSignalNotifier extends StateNotifier<VehicleSignal> {
  VehicleSignalNotifier() : super(_initialValue);
  static final VehicleSignal _initialValue = VehicleSignal(
    speed: 140,
    rpm: 7000,
    fuelLevel: 90,
    coolantTemp: 90,
    isLeftIndicator: false,
    isRightIndicator: false,
    selectedGear: "P",
    performanceMode: "normal",
    isHazardLightOn: false,
    isHighBeam: true,
    isLowBeam: false,
    isParkingOn: true,
    travelledDistance: 888,
    ambientAirTemp: '25',
    cruiseControlSpeed: 60,
    isCruiseControlActive: false,
    isCruiseControlError: false,
    isMILon: false,
    isTrunkLocked: true,
    isTrunkOpen: false,
    isBatteryCharging: true,
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
    String? ambientAirTemp,
    bool? isLowBeam,
    bool? isHighBeam,
    bool? isHazardLightOn,
    bool? isMILon,
    bool? isParkingOn,
    bool? isTrunkOpen,
    bool? isTrunkLocked,
    bool? isCruiseControlActive,
    bool? isCruiseControlError,
    bool? isBatteryCharging,
    double? travelledDistance,
    double? cruiseControlSpeed,
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
      isTrunkOpen: isTrunkOpen,
      isTrunkLocked: isTrunkLocked,
      isMILon: isMILon,
      ambientAirTemp: ambientAirTemp,
      isCruiseControlActive: isCruiseControlActive,
      isCruiseControlError: isCruiseControlError,
      cruiseControlSpeed: cruiseControlSpeed,
      isBatteryCharging: isBatteryCharging,
    );
  }
}
