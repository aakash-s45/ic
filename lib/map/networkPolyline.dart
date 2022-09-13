// SPDX-License-Identifier: Apache-2.0

import 'dart:math';
import 'package:flutter_cluster_dashboard/cluster_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';

class NetworkHelper {
  NetworkHelper(
      {required this.startLng,
      required this.startLat,
      required this.endLng,
      required this.endLat});

  final String url = 'https://api.openrouteservice.org/v2/directions/';

  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  Future getData(WidgetRef ref) async {
    final config = ref.read(clusterConfigStateprovider);
    String uriStr =
        '$url${config.orsPathParam}?api_key=${config.orsApiKey}&start=$startLng,$startLat&end=$endLng,$endLat';
    http.Response response = await http.get(Uri.parse(uriStr));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print("Warning: API Response Code: ${response.statusCode}");
    }
  }
}

Future getJsonData(
  WidgetRef ref,
  double startLat,
  double startLng,
  double endLat,
  double endLng,
) async {
  if (startLat == endLat && startLng == endLng) {
    return [];
  } else {
    NetworkHelper network = NetworkHelper(
      startLat: startLat,
      startLng: startLng,
      endLat: endLat,
      endLng: endLng,
    );
    try {
      final apikey = ref.read(clusterConfigStateprovider).orsApiKey;
      if (apikey.isNotEmpty) {
        var data = await network.getData(ref);
        return data['features'][0]['geometry']['coordinates'];
      }
      else {
        return [];
      }
    } catch (error) {
      print('Warning: Something Wrong with openstreet API Key !');
      return [];
    }
  }
}

double calcAngle(LatLng a, LatLng b) {
  List<double> newA = convertCoord(a);
  List<double> newB = convertCoord(b);
  double slope = (newB[1] - newA[1]) / (newB[0] - newA[0]);
  // -1 * deg + 180
  return ((atan(slope) * 180) / pi);
}

List<double> convertCoord(LatLng coord) {
  double oldLat = coord.latitude;
  double oldLong = coord.longitude;
  double newLong = (oldLong * 20037508.34 / 180);
  double newlat =
      (log(tan((90 + oldLat) * pi / 360)) / (pi / 180)) * (20037508.34 / 180);
  return [newlat, newLong];
}
