import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

final calibratelocationLogic =
    ChangeNotifierProvider<CalibrateLocationLogic>((ref) {
  return CalibrateLocationLogic();
});

class CalibrateLocationLogic extends ChangeNotifier {
  String? lat;
  String? long;
  String? locationMessage;
  // final locationController = Location();

  location() {
    livelocation();
    getCurrentLocation().then(
      (value) {
        lat = "${value.latitude}";
        long = "${value.longitude}";
        locationMessage = 'Latitude: $lat , logitude:$long';
        notifyListeners();
      },
    );
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location service are disabled.");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission are denied ");
      }
      notifyListeners();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permision are denied forever, we cannot request permission again.");
    }
    return await Geolocator.getCurrentPosition();
  }

  livelocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      print("--------------------------------------");
      print(position.latitude.toString());
      print(position.longitude.toString());
      print("--------------------------------------");
      locationMessage = 'Latitude: $lat , logitude:$long';
      notifyListeners();
    });
  }

  openmap(String lat, String long) async {
    String googleUrl =
        'http://www.google.com/maps/search/?api=1&query=$lat,$long';
    await canLaunchUrlString(googleUrl)
        ? await launchUrlString(googleUrl)
        : throw "could not launch $googleUrl";
  }
}