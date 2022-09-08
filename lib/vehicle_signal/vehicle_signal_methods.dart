// SPDX-License-Identifier: Apache-2.0

import 'dart:convert';
import 'dart:io';
import 'package:flutter_cluster_dashboard/cluster_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cluster_dashboard/map/networkPolyline.dart';
import 'package:flutter_cluster_dashboard/provider.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_path.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_provider.dart';
import 'package:latlong2/latlong.dart';

class VISS {
  static const requestId = "flutter-cluster-app";
  static void init(WebSocket socket, WidgetRef ref) {
    authorize(socket, ref);
    subscribe(socket, ref, VSPath.vehicleSpeed);
    subscribe(socket, ref, VSPath.vehicleEngineRPM);
    subscribe(socket, ref, VSPath.vehicleLeftIndicator);
    subscribe(socket, ref, VSPath.vehicleRightIndicator);
    subscribe(socket, ref, VSPath.vehicleFuelLevel);
    subscribe(socket, ref, VSPath.vehicleCoolantTemp);
    subscribe(socket, ref, VSPath.vehicleHazardLightOn);
    subscribe(socket, ref, VSPath.vehicleHighBeamOn);
    subscribe(socket, ref, VSPath.vehicleLowBeamOn);
    subscribe(socket, ref, VSPath.vehicleSelectedGear);
    subscribe(socket, ref, VSPath.vehiclePerformanceMode);
    subscribe(socket, ref, VSPath.vehicleAmbientAirTemperature);
    subscribe(socket, ref, VSPath.vehicleParkingLightOn);
    subscribe(socket, ref, VSPath.vehicleTrunkLocked);
    subscribe(socket, ref, VSPath.vehicleTrunkOpen);
    subscribe(socket, ref, VSPath.vehicleAmbientAirTemperature);
    subscribe(socket, ref, VSPath.vehicleMIL);
    subscribe(socket, ref, VSPath.vehicleCruiseControlError);
    subscribe(socket, ref, VSPath.vehicleCruiseControlSpeedSet);
    subscribe(socket, ref, VSPath.vehicleCruiseControlSpeedisActive);
    subscribe(socket, ref, VSPath.vehicleBatteryChargingStatus);

    //
    subscribe(socket, ref, VSPath.steeringCruiseEnable);
    subscribe(socket, ref, VSPath.steeringCruiseSet);
    subscribe(socket, ref, VSPath.steeringCruiseResume);
    subscribe(socket, ref, VSPath.steeringCruiseCancel);
    subscribe(socket, ref, VSPath.steeringInfo);
    subscribe(socket, ref, VSPath.steeringLaneDepWarn);
    subscribe(socket, ref, VSPath.vehicleDistanceUnit);
    //
    subscribe(socket, ref, VSPath.vehicleCurrLat);
    subscribe(socket, ref, VSPath.vehicleCurrLng);
    subscribe(socket, ref, VSPath.vehicleDesLat);
    subscribe(socket, ref, VSPath.vehicleDesLng);

    update(socket, ref);
  }

  static void update(WebSocket socket, WidgetRef ref) {
    get(socket, ref, VSPath.vehicleSpeed);
    get(socket, ref, VSPath.vehicleEngineRPM);
    get(socket, ref, VSPath.vehicleLeftIndicator);
    get(socket, ref, VSPath.vehicleRightIndicator);
    get(socket, ref, VSPath.vehicleFuelLevel);
    get(socket, ref, VSPath.vehicleCoolantTemp);
    get(socket, ref, VSPath.vehicleHazardLightOn);
    get(socket, ref, VSPath.vehicleHighBeamOn);
    get(socket, ref, VSPath.vehicleLowBeamOn);
    get(socket, ref, VSPath.vehicleSelectedGear);
    get(socket, ref, VSPath.vehiclePerformanceMode);
    get(socket, ref, VSPath.vehicleAmbientAirTemperature);
    get(socket, ref, VSPath.vehicleParkingLightOn);
    get(socket, ref, VSPath.vehicleTrunkLocked);
    get(socket, ref, VSPath.vehicleTrunkOpen);
    get(socket, ref, VSPath.vehicleAmbientAirTemperature);
    get(socket, ref, VSPath.vehicleMIL);
    get(socket, ref, VSPath.vehicleCruiseControlError);
    get(socket, ref, VSPath.vehicleCruiseControlSpeedSet);
    get(socket, ref, VSPath.vehicleCruiseControlSpeedisActive);
    get(socket, ref, VSPath.vehicleBatteryChargingStatus);
    get(socket, ref, VSPath.vehicleDistanceUnit);
    //
    get(socket, ref, VSPath.vehicleCurrLat);
    get(socket, ref, VSPath.vehicleCurrLng);
    get(socket, ref, VSPath.vehicleDesLat);
    get(socket, ref, VSPath.vehicleDesLng);
  }

  static void authorize(WebSocket socket, WidgetRef ref) {
    final config = ref.read(clusterConfigStateprovider);
    Map<String, dynamic> map = {
      "action": "authorize",
      "tokens": config.kuksaAuthToken,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void get(WebSocket socket, WidgetRef ref, String path) {
    final config = ref.read(clusterConfigStateprovider);
    Map<String, dynamic> map = {
      "action": "get",
      "tokens": config.kuksaAuthToken,
      "path": path,
      "requestId": requestId
    };
    socket.add(jsonEncode(map));
  }

  static void set(WebSocket socket, WidgetRef ref, String path, String value) {
    final config = ref.read(clusterConfigStateprovider);
    Map<String, dynamic> map = {
      "action": "set",
      "tokens": config.kuksaAuthToken,
      "path": path,
      "requestId": requestId,
      "value": value
    };
    socket.add(jsonEncode(map));
  }

  static void subscribe(WebSocket socket, WidgetRef ref, String path) {
    final config = ref.read(clusterConfigStateprovider);
    Map<String, dynamic> map = {
      "action": "subscribe",
      "tokens": config.kuksaAuthToken,
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
    final polylineDBNotifier = ref.read(polyLineStateProvider.notifier);
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
                  vehicleSignal.update(
                      cruiseControlSpeed: double.parse(dp['value']));
                  break;
                case VSPath.vehicleCruiseControlSpeedisActive:
                  vehicleSignal.update(isCruiseControlActive: dp['value']);
                  break;
                case VSPath.vehicleBatteryChargingStatus:
                  vehicleSignal.update(isBatteryCharging: dp['value']);
                  break;
                //
                case VSPath.steeringCruiseEnable:
                  if (dp['value']) {
                    if (vehicleSignal.state.isSteeringCruiseEnable) {
                      vehicleSignal.update(isSteeringCruiseEnable: false);
                      vehicleSignal.update(isSteeringCruiseSet: false);
                    } else {
                      vehicleSignal.update(isSteeringCruiseEnable: dp['value']);
                    }
                  }
                  break;
                case VSPath.steeringCruiseSet:
                  if (dp['value'] &&
                      vehicleSignal.state.isSteeringCruiseEnable) {
                    vehicleSignal.update(isSteeringCruiseSet: dp['value']);
                  }
                  break;
                case VSPath.steeringCruiseResume:
                  if (dp['value'] &&
                      vehicleSignal.state.isSteeringCruiseEnable) {
                    vehicleSignal.update(isSteeringCruiseSet: dp['value']);
                  }
                  break;
                case VSPath.steeringCruiseCancel:
                  if (dp['value']) {
                    vehicleSignal.update(isSteeringCruiseSet: false);
                  }
                  break;
                case VSPath.steeringInfo:
                  if (dp['value']) {
                    vehicleSignal.update(
                        isSteeringInfo: !vehicleSignal.state.isSteeringInfo);
                  }
                  break;
                case VSPath.steeringLaneDepWarn:
                  if (dp['value']) {
                    vehicleSignal.update(
                        isSteeringLaneWarning:
                            !(vehicleSignal.state.isSteeringLaneWarning));
                  }
                  break;
                case VSPath.vehicleDistanceUnit:
                  vehicleSignal.update(vehicleDistanceUnit: dp['value']);
                  break;
                //
                case VSPath.vehicleCurrLat:
                  vehicleSignal.update(currLat: double.parse(dp['value']));
                  break;
                case VSPath.vehicleCurrLng:
                  vehicleSignal.update(currLng: double.parse(dp['value']));
                  break;
                case VSPath.vehicleDesLat:
                  vehicleSignal.update(desLat: double.parse(dp['value']));
                  polylineDBNotifier.update(currPolyLineList: []);

                  break;
                case VSPath.vehicleDesLng:
                  vehicleSignal.update(desLng: double.parse(dp['value']));
                  polylineDBNotifier.update(currPolyLineList: []);
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

void updatePolyline(WidgetRef ref, vehicleSignal, polyLineState) {
  getJsonData(ref, vehicleSignal.state.currLat, vehicleSignal.state.currLng,
          vehicleSignal.state.desLat, vehicleSignal.state.desLng)
      .then((polylineList) {
    polyLineState.update(
        currPolyLineList: polylineList
            .map((element) => LatLng(element[1], element[0]))
            .toList());
  });
}
