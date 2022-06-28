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
  });
  final double speed;
  final double rpm;
  final double fuelLevel;
  final double coolantTemp;
  final bool isLeftIndicator;
  final bool isRightIndicator;
  final String selectedGear;
  final String performanceMode;
  final bool isLowBeam;
  final bool isHighBeam;
  final bool isHazardLightOn;
  final bool isParkingOn;
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
    bool? isLowBeam,
    bool? isHighBeam,
    bool? isHazardLightOn,
    bool? isParkingOn,
    double? travelledDistance,
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
        performanceMode: performanceMode ?? this.performanceMode);
  }
}
