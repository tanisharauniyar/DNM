import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../utills/themes.dart';
import 'calibrate_location_logic.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  LatLng? googleplex;
  LatLng? savedLocation;
  double? distanceInMeters;
  bool isSnackBarVisible = false;

  @override
  void initState() {
    final locationLogic = ref.read(calibratelocationLogic);
    locationLogic.location();
    final lat = double.tryParse(locationLogic.lat ?? '');
    final long = double.tryParse(locationLogic.long ?? '');
    if (lat != null && long != null) googleplex = LatLng(lat, long);
    _goToTheLake();
    getCurrentLocation();
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: googleplex!,
          zoom: 14,
        ),
      ),
    );
  }

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      googleplex = LatLng(position.latitude, position.longitude);
      // Calculate distance after getting current location
      calculateDistance();
    });
  }

  calculateDistance() {
    if (googleplex != null && savedLocation != null) {
      distanceInMeters = Geolocator.distanceBetween(
          savedLocation!.latitude,
          savedLocation!.longitude,
          googleplex!.latitude,
          googleplex!.longitude);
    }
  }

  saveLocation() {
    savedLocation = LatLng(27.69, 85.39);
    calculateDistance();
    setState(() {
      isSnackBarVisible = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Location saved successfully!'),
      duration: Duration(seconds: 2),
      onVisible: () {
        setState(() {
          isSnackBarVisible = false;
        });
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 60.r,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Themes.darkGreenHeader,
          title: Text(
            "Outlet",
            style: TextStyle(color: Colors.white, fontSize: 65.r),
          ),
          actions: [
            InkWell(
              onTap: () {
                saveLocation();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.save,
                  size: 80.r,
                ),
              ),
            )
          ],
        ),
        body: googleplex == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: googleplex!,
                  zoom: 14,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: googleplex != null
                    ? {
                        Marker(
                          markerId: const MarkerId('Current location'),
                          position: savedLocation!,
                          icon: BitmapDescriptor.defaultMarker,
                          infoWindow: const InfoWindow(
                            title: 'Your Location',
                            snippet: 'This is your current location.',
                          ),
                        ),
                      }
                    : {},
                myLocationEnabled: true,
              ),
        bottomNavigationBar: Visibility(
          visible: !isSnackBarVisible && distanceInMeters != null,
          child: BottomAppBar(
            child: SizedBox(
              height: 50.0,
              child: Center(
                child: Text(
                  'Distance from saved location: ${distanceInMeters} meters',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}