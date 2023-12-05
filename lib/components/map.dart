import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _locationController;
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
    _getCurrentLocationAndSetInitialPosition();
  }

  Future<void> _getCurrentLocationAndSetInitialPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _goToPlace(position.latitude, position.longitude, {}, {});
    } catch (e) {
      print("Error getting current location: $e");
    }
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Maps'),
        backgroundColor: Colors.green[700],
      ),
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
                        // Replace the following line with your LocationService logic
                        // var directions = await LocationService().getDirections(_controllerOrigin.text, _controllerDestination.text);
                        // _goToPlace(directions['start_location']['lat'], directions['start_location']['lng'],
                        //     directions['bounds_ne'], directions['bounds_sw']);
                        // _setPolylines(directions['polyline_decoded']);
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
                Container(
                  child: GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    trafficEnabled: true,
                    markers: _markers,
                    polygons: _polygons,
                    polylines: _polylines,
                    mapType: MapType.normal,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(
                          0, 0), // Updated to dummy values; will be overwritten on obtaining the current location
                      zoom: 14.4746,
                    ),
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
                ),
                Positioned(
                  bottom: 30,
                  left: 240,
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high,
                      );

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
