// ignore_for_file: unused_field

import 'dart:async';

import 'package:bootcamp_project/product/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

CameraPosition _kGooglePlex = const CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

class _MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _locationController;
  final TextEditingController _controllerSearch = TextEditingController();
  final TextEditingController _controllerOrigin = TextEditingController();
  final TextEditingController _controllerDestination = TextEditingController();

  final Set<Marker> _markers = <Marker>{};
  final Set<Polygon> _polygons = <Polygon>{};
  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;

  @override
  void initState() {
    super.initState();
    // _setMarker(const LatLng(37.42796133580664, -122.085749655962));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(Marker(markerId: const MarkerId('marker'), position: point));
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';

    _polygonIdCounter++;
    _polygons.add(Polygon(
        polygonId: PolygonId(polygonIdVal), strokeWidth: 2, fillColor: Colors.transparent, points: polygonLatLngs));
  }

  void _setPolylines(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polygonIdCounter';
    _polygonIdCounter++;

    _polylines.add(Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points.map((point) => LatLng(point.latitude, point.longitude)).toList()));
  }

  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();

  @override
  void dispose() {
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _controllerOrigin.dispose();
    _controllerDestination.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_secondFocusNode);
                      },
                      focusNode: _firstFocusNode,
                      style: const TextStyle(color: Colors.black),
                      controller: _controllerOrigin,
                      decoration: const InputDecoration(
                        hintText: 'Origin',
                      ),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    TextFormField(
                      onEditingComplete: () async {
                        FocusScope.of(context).unfocus();
                        var directions =
                            await LocationService().getDirections(_controllerOrigin.text, _controllerDestination.text);
                        _goToPlace(directions['start_location']['lat'], directions['start_location']['lng'],
                            directions['bounds_ne'], directions['bounds_sw']);

                        _setPolylines(directions['polyline_decoded']);
                      },
                      focusNode: _secondFocusNode,
                      style: const TextStyle(color: Colors.black),
                      controller: _controllerDestination,
                      decoration: const InputDecoration(
                        hintText: 'Destination',
                      ),
                      onChanged: (value) {
                        print(value);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  trafficEnabled: true,
                  markers: _markers,
                  polygons: _polygons,
                  polylines: _polylines,
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _locationController = controller;
                    _controller.complete(controller);
                  },
                  onTap: (point) {
                    setState(() {
                      polygonLatLngs.add(point);
                      _setPolygon();
                    });
                  },
                ),
                Positioned(
                  bottom: 30,
                  left: 240,
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      Position position = await LocationService().getCurrentLocation();

                      _locationController.animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
                    },
                    label: const Text("Find Me!"),
                    icon: const Icon(Icons.gamepad_outlined),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(double lat, double lng, Map<String, dynamic> boundNe, Map<String, dynamic> boundSw) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat, lng),
        zoom: 12,
      ),
    ));

    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(boundSw['lat'], boundSw['lng']), northeast: LatLng(boundNe['lat'], boundNe['lng'])),
        0));
    _setMarker(LatLng(lat, lng));
  }
}
