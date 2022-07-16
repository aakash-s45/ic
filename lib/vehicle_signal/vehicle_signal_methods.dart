// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/vehicle_signal/vehicle_signal_config.dart';
import 'package:ic/vehicle_signal/vehicle_signal_path.dart';
import 'package:ic/vehicle_signal/vehicle_signal_provider.dart';

class VISS {
  static const requestId = "test-id";
  static void init(WebSocket socket) {
    authorize(socket);
    subscribe(socket, VSPath.vehicleSpeed);
    subscribe(socket, VSPath.vehicleEngineRPM);
    subscribe(socket, VSPath.vehicleLeftIndicator);
    subscribe(socket, VSPath.vehicleRightIndicator);
    subscribe(socket, VSPath.vehicleFuelLevel);
    subscribe(socket, VSPath.vehicleCoolantTemp);
    subscribe(socket, VSPath.vehicleHazardLightOn);
    subscribe(socket, VSPath.vehicleHighBeamOn);
    subscribe(socket, VSPath.vehicleLowBeamOn);
    subscribe(socket, VSPath.vehicleSelectedGear);
    subscribe(socket, VSPath.vehiclePerformanceMode);
    subscribe(socket, VSPath.vehicleAmbientAirTemperature);
    subscribe(socket, VSPath.vehicleParkingLightOn);
    subscribe(socket, VSPath.vehicleTrunkLocked);
    subscribe(socket, VSPath.vehicleTrunkOpen);
    subscribe(socket, VSPath.vehicleAmbientAirTemperature);
    subscribe(socket, VSPath.vehicleMIL);
    subscribe(socket, VSPath.vehicleCruiseControlError);
    subscribe(socket, VSPath.vehicleCruiseControlSpeedSet);
    subscribe(socket, VSPath.vehicleCruiseControlSpeedisActive);
    subscribe(socket, VSPath.vehicleBatteryChargingStatus);
  }

  static void update(WebSocket socket) {
    get(socket, VSPath.vehicleSpeed);
    get(socket, VSPath.vehicleEngineRPM);
    get(socket, VSPath.vehicleLeftIndicator);
    get(socket, VSPath.vehicleRightIndicator);
    get(socket, VSPath.vehicleFuelLevel);
    get(socket, VSPath.vehicleCoolantTemp);
    get(socket, VSPath.vehicleHazardLightOn);
    get(socket, VSPath.vehicleHighBeamOn);
    get(socket, VSPath.vehicleLowBeamOn);
    get(socket, VSPath.vehicleSelectedGear);
    get(socket, VSPath.vehiclePerformanceMode);
    get(socket, VSPath.vehicleAmbientAirTemperature);
    get(socket, VSPath.vehicleParkingLightOn);
    get(socket, VSPath.vehicleTrunkLocked);
    get(socket, VSPath.vehicleTrunkOpen);
    get(socket, VSPath.vehicleAmbientAirTemperature);
    get(socket, VSPath.vehicleMIL);
    get(socket, VSPath.vehicleCruiseControlError);
    get(socket, VSPath.vehicleCruiseControlSpeedSet);
    get(socket, VSPath.vehicleCruiseControlSpeedisActive);
    get(socket, VSPath.vehicleBatteryChargingStatus);
  }

  static void authorize(WebSocket socket) {
    Map<String, dynamic> map = {
      "action": "authorize",
      "tokens": VehicleSignalConfig.authToken,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void get(WebSocket socket, String path) {
    Map<String, dynamic> map = {
      "action": "get",
      "tokens": VehicleSignalConfig.authToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void set(WebSocket socket, String path, String value) {
    Map<String, dynamic> map = {
      "action": "set",
      "tokens": VehicleSignalConfig.authToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void subscribe(WebSocket socket, String path) {
    Map<String, dynamic> map = {
      "action": "subscribe",
      "tokens": VehicleSignalConfig.authToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static String? numToGear(int? number) {
    switch (number) {
      case -1:
        return 'R';
      case 0:
        return 'N';
      case 126:
        return 'P';
      case 127:
        return 'D';
      default:
        return null;
    }
  }

  static void parseData(WidgetRef ref, String data) {
    final vehicleSignal = ref.read(vehicleSignalProvider.notifier);
    Map<String, dynamic> dataMap = jsonDecode(data);
    if (dataMap["action"] == "subscription" || dataMap["action"] == "get") {
      if (dataMap.containsKey("data")) {
        if ((dataMap["data"] as Map<String, dynamic>).containsKey("dp") &&
            (dataMap["data"] as Map<String, dynamic>).containsKey("path")) {
          String path = dataMap["data"]["path"];
          Map<String, dynamic> dp = dataMap["data"]["dp"];
          if (dp.containsKey("value")) {
            if (dp["value"] != "---") {
              switch (path) {
                case VSPath.vehicleSpeed:
                  vehicleSignal.update(speed: double.parse(dp["value"]));
                  break;
                case VSPath.vehicleEngineRPM:
                  vehicleSignal.update(rpm: double.parse(dp["value"]));
                  break;
                case VSPath.vehicleFuelLevel:
                  vehicleSignal.update(fuelLevel: double.parse(dp["value"]));
                  break;
                case VSPath.vehicleCoolantTemp:
                  vehicleSignal.update(coolantTemp: double.parse(dp["value"]));
                  break;
                case VSPath.vehicleLeftIndicator:
                  vehicleSignal.update(isLeftIndicator: dp["value"]);
                  break;
                case VSPath.vehicleRightIndicator:
                  vehicleSignal.update(isRightIndicator: dp["value"]);
                  break;
                case VSPath.vehicleHighBeamOn:
                  if (dp["value"]) {
                    vehicleSignal.update(isHighBeam: true);
                    vehicleSignal.update(isLowBeam: false);
                  } else {
                    vehicleSignal.update(isHighBeam: dp["value"]);
                  }
                  break;
                case VSPath.vehicleParkingLightOn:
                  vehicleSignal.update(isParkingOn: dp["value"]);
                  break;
                case VSPath.vehicleLowBeamOn:
                  if (dp["value"]) {
                    vehicleSignal.update(isHighBeam: false);
                    vehicleSignal.update(isLowBeam: true);
                  } else {
                    vehicleSignal.update(isLowBeam: dp["value"]);
                  }
                  break;
                case VSPath.vehicleHazardLightOn:
                  vehicleSignal.update(isHazardLightOn: dp["value"]);
                  break;
                case VSPath.vehicleSelectedGear:
                  vehicleSignal.update(
                      selectedGear: numToGear(int.parse(dp["value"])));
                  break;
                case VSPath.vehiclePerformanceMode:
                  vehicleSignal.update(performanceMode: dp['value']);
                  break;
                case VSPath.vehicleTravelledDistance:
                  vehicleSignal.update(travelledDistance: dp['value']);
                  break;
                case VSPath.vehicleTrunkLocked:
                  vehicleSignal.update(isTrunkLocked: dp['value']);
                  break;
                case VSPath.vehicleTrunkOpen:
                  vehicleSignal.update(isTrunkOpen: dp['value']);
                  break;
                case VSPath.vehicleAmbientAirTemperature:
                  vehicleSignal.update(ambientAirTemp: dp['value']);
                  break;
                case VSPath.vehicleMIL:
                  vehicleSignal.update(isMILon: dp['value']);
                  break;
                case VSPath.vehicleCruiseControlError:
                  vehicleSignal.update(isCruiseControlError: dp['value']);
                  break;
                case VSPath.vehicleCruiseControlSpeedSet:
                  vehicleSignal.update(cruiseControlSpeed: dp['value']);
                  break;
                case VSPath.vehicleCruiseControlSpeedisActive:
                  vehicleSignal.update(isCruiseControlActive: dp['value']);
                  break;
                case VSPath.vehicleBatteryChargingStatus:
                  vehicleSignal.update(isBatteryCharging: dp['value']);
                  break;
                default:
                  print("$path Not Available yet!");
              }
            } else {
              print("ERROR:Value not available yet! Set Value of $path");
            }
          } else {
            print("ERROR:'value': Key not found!");
          }
        } else if ((!dataMap["data"] as Map<String, dynamic>)
            .containsKey("path")) {
          print("ERROR:'path':key not found !");
        } else if ((dataMap["data"] as Map<String, dynamic>)
            .containsKey("dp")) {
          print("ERROR:'dp':key not found !");
        }
      } else {
        print("ERROR:'data':key not found!");
      }
    }
  }
}
