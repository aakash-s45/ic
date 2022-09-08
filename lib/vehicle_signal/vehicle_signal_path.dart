// SPDX-License-Identifier: Apache-2.0

class VSPath {
  static const String vehicleSpeed = "Vehicle.Speed";
  static const String vehicleEngineRPM =
      "Vehicle.Powertrain.CombustionEngine.Engine.Speed";
  static const String vehicleFuelLevel = "Vehicle.Powertrain.FuelSystem.Level";
  static const String vehicleCoolantTemp =
      "Vehicle.Powertrain.CombustionEngine.Engine.ECT";
  static const String vehicleLeftIndicator =
      "Vehicle.Body.Lights.IsLeftIndicatorOn";
  static const String vehicleRightIndicator =
      "Vehicle.Body.Lights.IsRightIndicatorOn";
  //Selected Gear output=> 0=Neutral, 1/2/..=Forward, -1/..=Reverse, 126=Park, 127=Drive
  static const String vehicleSelectedGear =
      "Vehicle.Powertrain.Transmission.SelectedGear";
  static const String vehicleLowBeamOn = "Vehicle.Body.Lights.IsLowBeamOn";
  static const String vehicleHighBeamOn = "Vehicle.Body.Lights.IsHighBeamOn";
  static const String vehicleParkingLightOn = "Vehicle.Body.Lights.IsParkingOn";
  static const String vehicleHazardLightOn = "Vehicle.Body.Lights.IsHazardOn";
  static const String vehicleTravelledDistance = "Vehicle.TravelledDistance";
  static const String vehicleTrunkLocked = "Vehicle.Body.Trunk.IsLocked";
  static const String vehicleTrunkOpen = "Vehicle.Body.Trunk.IsOpen";
  // \"normal\",\"sport\",\"economy\",\"snow\",\"rain\"]
  static const String vehiclePerformanceMode =
      "Vehicle.Powertrain.Transmission.PerformanceMode";
  static const String vehicleAmbientAirTemperature =
      "Vehicle.AmbientAirTemperature";
  static const String vehicleMIL = "Vehicle.OBD.Status.MIL";
  static const String vehicleCruiseControlError =
      "Vehicle.ADAS.CruiseControl.Error";
  static const String vehicleCruiseControlSpeedSet =
      "Vehicle.ADAS.CruiseControl.SpeedSet";
  static const String vehicleCruiseControlSpeedisActive =
      "Vehicle.ADAS.CruiseControl.IsActive";
  static const String vehicleBatteryChargingStatus =
      "Vehicle.Powertrain.Battery.Charging.Status";

  static const String steeringCruiseEnable =
      "Vehicle.Cabin.SteeringWheel.Switches.CruiseEnable";
  static const String steeringCruiseSet =
      "Vehicle.Cabin.SteeringWheel.Switches.CruiseSet";
  static const String steeringCruiseResume =
      "Vehicle.Cabin.SteeringWheel.Switches.CruiseResume";
  static const String steeringCruiseCancel =
      "Vehicle.Cabin.SteeringWheel.Switches.CruiseCancel";
  static const String steeringLaneDepWarn =
      "Vehicle.Cabin.SteeringWheel.Switches.LaneDepartureWarning";
  static const String steeringInfo =
      "Vehicle.Cabin.SteeringWheel.Switches.Info";
  static const String vehicleDistanceUnit =
      "Vehicle.Cabin.Infotainment.HMI.DistanceUnit";

  static const String vehicleCurrLat =
      "Vehicle.Cabin.Infotainment.Navigation.CurrentLocation.Latitude";
  static const String vehicleCurrLng =
      "Vehicle.Cabin.Infotainment.Navigation.CurrentLocation.Longitude";
  static const String vehicleDesLat =
      "Vehicle.Cabin.Infotainment.Navigation.DestinationSet.Latitude";
  static const String vehicleDesLng =
      "Vehicle.Cabin.Infotainment.Navigation.DestinationSet.Longitude";
}
