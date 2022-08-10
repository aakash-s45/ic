// ignore_for_file: file_names

import 'dart:math';
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
  final String apiKey =
      '5b3ce3597851110001cf624881b2435915874987965ce59e3b8de08a';
  final String pathParam = 'driving-car'; // Change it if you want

  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  Future getData() async {
    String uriStr =
        '$url$pathParam?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat';
    http.Response response = await http.get(Uri.parse(uriStr));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

Future getJsonData(
    double startLat, double startLng, double endLat, double endLng) async {
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
      var data = await network.getData();
      return data['features'][0]['geometry']['coordinates'];
    } catch (error) {
      print(error);
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
