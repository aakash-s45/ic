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
              // print(dp["value"].runtimeType);
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
                  vehicleSignal.update(isHighBeam: dp["value"]);
                  break;
                case VSPath.vehicleLowBeamOn:
                  if (dp["value"]) {
                    vehicleSignal.update(isHighBeam: false);
                    vehicleSignal.update(isLowBeam: true);
                    // VISS.set(ref, VSPath.vehicleHighBeamOn, "false");
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
                default:
              }
            }
          }
        }
      }
    }
    // if (dataMap.containsKey())
  }
}
