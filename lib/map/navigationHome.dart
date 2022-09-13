// SPDX-License-Identifier: Apache-2.0

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cluster_dashboard/cluster_config.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cluster_dashboard/map/networkPolyline.dart';
import 'package:flutter_cluster_dashboard/provider.dart';
import 'package:flutter_cluster_dashboard/vehicle_signal/vehicle_signal_provider.dart';
import 'package:latlong2/latlong.dart';

class NavigationHome extends ConsumerStatefulWidget {
  const NavigationHome({Key? key}) : super(key: key);

  @override
  ConsumerState<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends ConsumerState<NavigationHome> {
  late Timer timerCurrLocation;
  Timer timerPolyline = Timer.periodic(const Duration(hours: 10), ((timer) {}));
  double pathStroke = 5;
  late MapController mapController;
  // randomly initialization of the variable
  LatLng src = LatLng(31.71, 76.95);
  LatLng markerLocation = LatLng(31.71, 76.95);

  @override
  void initState() {
    super.initState();
    mapController = MapController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var vehicle = ref.read(vehicleSignalProvider);
      var polylineDB = ref.read(polyLineStateProvider);
      final polylineDBNotifier = ref.read(polyLineStateProvider.notifier);
      final clusterConfig = ref.read(clusterConfigStateprovider);
      // timer for updating map center and zoom
      timerCurrLocation = Timer.periodic(const Duration(seconds: 2), (timer) {
        polylineDB = ref.read(polyLineStateProvider);

        vehicle = ref.read(vehicleSignalProvider);
        markerLocation = LatLng(vehicle.currLat, vehicle.currLng);
        // move and center
        mapController.move(LatLng(vehicle.currLat, vehicle.currLng), 15);

        // rotate
        double rotationDegree = 0;
        int n = polylineDB.currPolyLineList.length;
        if (polylineDB.currPolyLineList.isNotEmpty && n > 1) {
          rotationDegree = calcAngle(
              polylineDB.currPolyLineList[0], polylineDB.currPolyLineList[1]);

          rotationDegree = (rotationDegree.isNaN) ? 0 : rotationDegree;
        }
        // print("Rotation:$rotationDegree");
        mapController.rotate(-1 * rotationDegree);
      });

      // update polyline in polyline db
      if (polylineDB.currPolyLineList.isEmpty && clusterConfig.orsApiKey.isNotEmpty) {
        timerPolyline.cancel();
        timerPolyline =
            Timer.periodic(const Duration(seconds: 10), (timer) async {
          List data = await getJsonData(ref, vehicle.currLat, vehicle.currLng,
              vehicle.desLat, vehicle.desLng);
          List<LatLng> currList =
              data.map((element) => LatLng(element[1], element[0])).toList();
          polylineDBNotifier.update(currPolyLineList: currList);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timerCurrLocation.cancel();
    timerPolyline.cancel();
  }

  double tempangle = 0;
  @override
  Widget build(BuildContext context) {
    final currListProvider = ref.watch(polyLineStateProvider);
    List<LatLng> currPolyLineList = currListProvider.currPolyLineList;

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        rotation: 0,
        center: src,
        minZoom: 12,
        zoom: 12,
        maxZoom: 22.0,
        keepAlive: true,
      ),
      layers: [
        TileLayerOptions(
          maxZoom: 22,
          maxNativeZoom: 18,
          subdomains: ["a", "b", "c"],
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        if (currPolyLineList.isNotEmpty)
          PolylineLayerOptions(
            polylineCulling: false,
            polylines: [
              if (currPolyLineList.isNotEmpty)
                Polyline(
                  strokeWidth: pathStroke,
                  points: currPolyLineList,
                  color: Colors.blue,
                ),
            ],
          ),
        if (currPolyLineList.isNotEmpty)
          MarkerLayerOptions(
            rotate: true,
            markers: [
              Marker(
                point: markerLocation,
                width: 70,
                height: 70,
                builder: (context) => Image.asset(
                  "images/car.png",
                ),
              ),
            ],
          ),
      ],
    );
  }
}
