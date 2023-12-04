import 'package:bootcamp_project/product/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({super.key});

  @override
  State<CurrentLocationScreen> createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController locationController;

  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(40.7128, -74.0060),
    zoom: 14.4746,
  );

  Set<Marker> markerList = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Current Location')),
        body: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          myLocationEnabled: true,
          markers: markerList,
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            locationController = controller;
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            Position position = await LocationService().getCurrentLocation();

            locationController.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
          },
          label: const Text('Find Me!'),
          icon: const Icon(Icons.gamepad_outlined),
        ));
  }
}
