// ignore_for_file: prefer_const_constructors

import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:bootcamp_project/product/services/place_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RestaurantView extends StatefulWidget {
  const RestaurantView({super.key});

  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  double lat = 0;
  double long = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _initializeMap();
  }

  Future<void> _getCurrentLocation() async {
    try {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> _initializeMap() async {
    await _getCurrentLocation();
    PlacesService().searchNearbyPlaces(
      lat,
      long,
      'restaurant',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: TextFormField(
            controller: _searchController,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
              hintText: LocaleKeys.search.tr(),
              prefixIcon: Icon(
                Icons.search,
                size: 20,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 40,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
