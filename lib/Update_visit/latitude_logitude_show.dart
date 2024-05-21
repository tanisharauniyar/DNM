import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import '../utills/themes.dart';

class LatLong extends ConsumerStatefulWidget {
  const LatLong({super.key});

  @override
  ConsumerState<LatLong> createState() => _LatLongState();
}

String LocationMessage = 'location';
late String lat;
late String long;

class _LatLongState extends ConsumerState<LatLong> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200.r,
              width: 650.r,
              color: Themes.darkGreenHeader,
              child: Center(
                child: Text(
                  LocationMessage,
                  style: TextStyle(color: Colors.white, fontSize: 34.r),
                ),
              ),
            ),
            20.verticalSpace,
            InkWell(
              onTap: () {
                getcurrentlocation().then(
                  (value) {
                    lat = '${value.latitude}';
                    long = '${value.longitude}';
                    setState(() {
                      LocationMessage = 'Latitude:$lat , Longitude: $long';
                    });
                    livelocation();
                  },
                );
              },
              child: Center(
                child: Container(
                  height: 200.r,
                  width: 550.r,
                  color: Themes.darkGreenHeader,
                  child: Center(
                    child: Text(
                      'Get your current location ',
                      style: TextStyle(color: Colors.white, fontSize: 34.r),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  livelocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position position) {
        lat = position.latitude.toString();
        long = position.longitude.toString();
        setState(
          () {
            LocationMessage = 'Latitude:$lat , Longitude: $long';
          },
        );
      },
    );
  }

  Future<Position> getcurrentlocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Service Are Enabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            "Location are permanetly denied. we cannot request location");
      }
    }
    return Geolocator.getCurrentPosition();
  }
}