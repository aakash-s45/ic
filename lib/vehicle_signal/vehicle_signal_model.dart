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
    );
  }
}
