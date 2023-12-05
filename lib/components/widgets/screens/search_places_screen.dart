import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({super.key});

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 14.4746);
  late GoogleMapController searchController;

  Set<Marker> markerList = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search on Map'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markerList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              searchController = controller;
            },
          ),
        ],
      ),
    );
  }
}
