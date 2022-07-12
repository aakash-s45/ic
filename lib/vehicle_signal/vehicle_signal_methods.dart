import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ic/vehicle_signal/vehicle_signal_config.dart';
import 'package:ic/vehicle_signal/vehicle_signal_path.dart';
import 'package:ic/vehicle_signal/vehicle_signal_provider.dart';

class VISS {
  static const requestId = "test-id";
  static void init(WidgetRef ref) {
    authorize(ref);

    subscribe(ref, VSPath.vehicleSpeed);
    subscribe(ref, VSPath.vehicleEngineRPM);
    subscribe(ref, VSPath.vehicleLeftIndicator);
    subscribe(ref, VSPath.vehicleRightIndicator);
    subscribe(ref, VSPath.vehicleFuelLevel);
    subscribe(ref, VSPath.vehicleCoolantTemp);
    subscribe(ref, VSPath.vehicleHazardLightOn);
    subscribe(ref, VSPath.vehicleHighBeamOn);
    subscribe(ref, VSPath.vehicleLowBeamOn);
    subscribe(ref, VSPath.vehicleSelectedGear);
    subscribe(ref, VSPath.vehiclePerformanceMode);
    subscribe(ref, VSPath.vehicleAmbientAirTemperature);
    subscribe(ref, VSPath.vehicleParkingLightOn);
  }

  static void update(WidgetRef ref) {
    get(ref, VSPath.vehicleSpeed);
    get(ref, VSPath.vehicleEngineRPM);
    get(ref, VSPath.vehicleLeftIndicator);
    get(ref, VSPath.vehicleRightIndicator);
    get(ref, VSPath.vehicleFuelLevel);
    get(ref, VSPath.vehicleCoolantTemp);
    get(ref, VSPath.vehicleHazardLightOn);
    get(ref, VSPath.vehicleHighBeamOn);
    get(ref, VSPath.vehicleLowBeamOn);
    get(ref, VSPath.vehicleSelectedGear);
    get(ref, VSPath.vehiclePerformanceMode);
    get(ref, VSPath.vehicleAmbientAirTemperature);
    get(ref, VSPath.vehicleParkingLightOn);
  }

  static void authorize(WidgetRef ref) {
    final channel = ref.read(channel_provider);
    Map<String, dynamic> map = {
      "action": "authorize",
      "tokens": VehicleSignalConfig.authToken,
      "requestId": requestId
    };
    channel.sink.add(jsonEncode(map));
  }

  static void get(WidgetRef ref, String path) {
    final channel = ref.read(channel_provider);
    Map<String, dynamic> map = {
      "action": "get",
      "tokens": VehicleSignalConfig.authToken,
      "path": path,
      "requestId": requestId
    };
    channel.sink.add(jsonEncode(map));
  }

  static void set(WidgetRef ref, String path, String value) {
    final channel = ref.read(channel_provider);
    Map<String, dynamic> map = {
      "action": "set",
      "tokens": VehicleSignalConfig.authToken,
      "path": path,
      "requestId": requestId
    };
    channel.sink.add(jsonEncode(map));
  }

  static void subscribe(WidgetRef ref, String path) {
    final channel = ref.read(channel_provider);
    Map<String, dynamic> map = {
      "action": "subscribe",
      "tokens": VehicleSignalConfig.authToken,
      "path": path,
      "requestId": requestId
    };
    channel.sink.add(jsonEncode(map));
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
