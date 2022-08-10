// ignore_for_file: non_constant_identifier_names

// add in vehicle object then in update function and then in copywith
// then go to methods to add there
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/vehicle_signal/vehicle_signal_config.dart';
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
    isSteeringCruiseEnable: false,
    isSteeringCruiseSet: false,
    isSteeringCruiseResume: false,
    isSteeringCruiseCancel: false,
    isSteeringInfo: false,
    isSteeringLaneWarning: false,
    vehicleDistanceUnit: 'km',
    currLat: HomeCoordinates.lat,
    currLng: HomeCoordinates.lng,
    srcLat: HomeCoordinates.lat,
    srcLng: HomeCoordinates.lng,
    desLat: HomeCoordinates.lat,
    desLng: HomeCoordinates.lng,
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
    //
    String? vehicleDistanceUnit,
    bool? isSteeringCruiseEnable,
    bool? isSteeringCruiseSet,
    bool? isSteeringCruiseResume,
    bool? isSteeringCruiseCancel,
    bool? isSteeringLaneWarning,
    bool? isSteeringInfo,
    //
    double? currLat,
    double? currLng,
    double? srcLat,
    double? srcLng,
    double? desLat,
    double? desLng,
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
      //
      isSteeringCruiseEnable: isSteeringCruiseEnable,
      isSteeringCruiseSet: isSteeringCruiseSet,
      isSteeringCruiseResume: isSteeringCruiseResume,
      isSteeringCruiseCancel: isSteeringCruiseCancel,
      isSteeringInfo: isSteeringInfo,
      isSteeringLaneWarning: isSteeringLaneWarning,
      vehicleDistanceUnit: vehicleDistanceUnit,
      //
      currLat: currLat,
      currLng: currLng,
      srcLat: srcLat,
      srcLng: srcLng,
      desLat: desLat,
      desLng: desLng,
    );
  }
}
