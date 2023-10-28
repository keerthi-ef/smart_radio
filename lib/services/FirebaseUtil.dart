import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:battery_info/model/android_battery_info.dart';
import 'package:geolocator/geolocator.dart';


Future<Map<String, dynamic>> fetchPlaylist() async {
  // skip if the battery level is less than 20%
  int? level = AndroidBatteryInfo().batteryLevel;

  if (level != null) {
    print("Battery level: $level");
    if (level < 20) {
      return {
        "greeting": "Battery level is less than 20%",
        "songs": []
      };
    }
  }

  // get the current location
  Position? position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  double lon = position.longitude;
  double lat = position.latitude;

  String url = "https://getplaylist-2iggftkaaq-uc.a.run.app/?lon=$lon&lat=$lat";
  print(url);

  final response = await http.get(Uri.parse(url));
  Map<String, dynamic> data = {};
  if (response.statusCode == 200) {
    data = json.decode(response.body);
    print("fetching playlist");
    return data;
  } else {
    // If the server did not return a 200 OK response, handle the error.
    print('Failed to load data: ${response.statusCode}');
  }

  return data;
}