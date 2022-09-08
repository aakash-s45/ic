// SPDX-License-Identifier: Apache-2.0

class VehicleSignal {
  VehicleSignal({
    required this.speed,
    required this.rpm,
    required this.fuelLevel,
    required this.coolantTemp,
    required this.isLeftIndicator,
    required this.isRightIndicator,
    required this.selectedGear,
    required this.isLowBeam,
    required this.isHighBeam,
    required this.isHazardLightOn,
    required this.travelledDistance,
    required this.isParkingOn,
    required this.performanceMode,
    required this.ambientAirTemp,
    required this.cruiseControlSpeed,
    required this.isCruiseControlActive,
    required this.isCruiseControlError,
    required this.isMILon,
    required this.isTrunkLocked,
    required this.isTrunkOpen,
    required this.isBatteryCharging,
    //steering switches
    required this.vehicleDistanceUnit,
    required this.isSteeringCruiseEnable,
    required this.isSteeringCruiseSet,
    required this.isSteeringCruiseResume,
    required this.isSteeringCruiseCancel,
    required this.isSteeringLaneWarning,
    required this.isSteeringInfo,
    // map coordinates
    required this.currLat,
    required this.currLng,
    required this.desLat,
    required this.desLng,
  });
  final double speed;
  final double rpm;
  final double fuelLevel;
  final double coolantTemp;
  final double cruiseControlSpeed;
  final bool isLeftIndicator;
  final bool isRightIndicator;
  final String selectedGear;
  final String performanceMode;
  final String ambientAirTemp;
  final bool isLowBeam;
  final bool isHighBeam;
  final bool isParkingOn;
  final bool isHazardLightOn;
  final bool isTrunkOpen;
  final bool isTrunkLocked;
  final bool isMILon;
  final bool isCruiseControlActive;
  final bool isCruiseControlError;
  final bool isBatteryCharging;
  final double travelledDistance;

  final String vehicleDistanceUnit;
  final bool isSteeringCruiseEnable;
  final bool isSteeringCruiseSet;
  final bool isSteeringCruiseResume;
  final bool isSteeringCruiseCancel;
  final bool isSteeringLaneWarning;
  final bool isSteeringInfo;

  final double currLat;
  final double currLng;
  final double desLat;
  final double desLng;

  VehicleSignal copyWith({
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
    bool? isParkingOn,
    bool? isTrunkLocked,
    bool? isTrunkOpen,
    bool? isMILon,
    bool? isCruiseControlError,
    bool? isCruiseControlActive,
    bool? isBatteryCharging,
    double? travelledDistance,
    double? cruiseControlSpeed,
    // Steering
    String? vehicleDistanceUnit,
    bool? isSteeringCruiseEnable,
    bool? isSteeringCruiseSet,
    bool? isSteeringCruiseResume,
    bool? isSteeringCruiseCancel,
    bool? isSteeringLaneWarning,
    bool? isSteeringInfo,
    // map coordinates
    double? currLat,
    double? currLng,
    double? desLat,
    double? desLng,
  }) {
    return VehicleSignal(
      speed: speed ?? (this.speed),
      rpm: rpm ?? this.rpm,
      fuelLevel: fuelLevel ?? this.fuelLevel,
      coolantTemp: coolantTemp ?? this.coolantTemp,
      isLeftIndicator: isLeftIndicator ?? this.isLeftIndicator,
      isRightIndicator: isRightIndicator ?? this.isRightIndicator,
      selectedGear: selectedGear ?? this.selectedGear,
      isLowBeam: isLowBeam ?? this.isLowBeam,
      isHighBeam: isHighBeam ?? this.isHighBeam,
      isHazardLightOn: isHazardLightOn ?? this.isHazardLightOn,
      travelledDistance: travelledDistance ?? this.travelledDistance,
      isParkingOn: isParkingOn ?? this.isParkingOn,
      performanceMode: performanceMode ?? this.performanceMode,
      isTrunkLocked: isTrunkLocked ?? this.isTrunkLocked,
      isTrunkOpen: isTrunkOpen ?? this.isTrunkOpen,
      ambientAirTemp: ambientAirTemp ?? this.ambientAirTemp,
      isMILon: isMILon ?? this.isMILon,
      isCruiseControlActive:
          isCruiseControlActive ?? this.isCruiseControlActive,
      cruiseControlSpeed: cruiseControlSpeed ?? this.cruiseControlSpeed,
      isCruiseControlError: isCruiseControlError ?? this.isCruiseControlError,
      isBatteryCharging: isBatteryCharging ?? this.isBatteryCharging,
      isSteeringCruiseEnable:
          isSteeringCruiseEnable ?? this.isSteeringCruiseEnable,
      isSteeringCruiseSet: isSteeringCruiseSet ?? this.isSteeringCruiseSet,
      isSteeringCruiseResume:
          isSteeringCruiseResume ?? this.isSteeringCruiseResume,
      isSteeringCruiseCancel:
          isSteeringCruiseCancel ?? this.isSteeringCruiseCancel,
      isSteeringInfo: isSteeringInfo ?? this.isSteeringInfo,
      isSteeringLaneWarning:
          isSteeringLaneWarning ?? this.isSteeringLaneWarning,
      vehicleDistanceUnit: vehicleDistanceUnit ?? this.vehicleDistanceUnit,
      //
      currLat: currLat ?? this.currLat,
      currLng: currLng ?? this.currLng,
      desLat: desLat ?? this.desLat,
      desLng: desLng ?? this.desLng,
    );
  }
}
