// Import necessary packages and libraries
import 'dart:async';

import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/core/init/lang/locale_keys.g.dart';
import 'package:bootcamp_project/services/location_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewMap extends StatefulWidget {
  const NewMap({Key? key}) : super(key: key);

  @override
  State<NewMap> createState() => _NewMapState();
}

class _NewMapState extends State<NewMap> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _locationController;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(LocaleKeys.mapSearch.tr())),
      body: Stack(
        children: [
          FutureBuilder<Position>(
            future: LocationService().getCurrentLocation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                    zoom: 15.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _locationController = controller;
                    _controller.complete(controller);
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                style: TextStyle(color: CColor.black),
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  labelText: LocaleKeys.mapSearch.tr(),
                  labelStyle: TextStyle(color: CColor.black),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(8),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 240,
            child: FloatingActionButton.extended(
              onPressed: () async {
                Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high,
                );

                _locationController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 15.4746),
                ));
              },
              label: Text(LocaleKeys.map_findMe.tr()),
              icon: const Icon(Icons.gamepad_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
