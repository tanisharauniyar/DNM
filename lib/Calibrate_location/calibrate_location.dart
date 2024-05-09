import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'calibrate_location_logic.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  LatLng? googleplex;

  @override
  void initState() {
    final locationLogic = ref.read(calibratelocationLogic);
    locationLogic.location();
    final lat = double.tryParse(locationLogic.lat ?? '');
    final long = double.tryParse(locationLogic.long ?? '');
    if (lat != null && long != null) {
      googleplex = LatLng(lat, long);
    }
    super.initState();
  }

  // static const googleplex = LatLng(37.4223, -122.0839);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: googleplex ?? LatLng(0, 0),
            zoom: 14,
          ),
          onMapCreated: (GoogleMapController controller) {},
          markers: googleplex != null
              ? {
                  Marker(
                    markerId: const MarkerId('Current location'),
                    position: googleplex ?? LatLng(0, 0),
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
      ),
    );
  }
}