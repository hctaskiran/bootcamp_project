// ignore_for_file: unused_field

import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:bootcamp_project/model/place_models.dart';
import 'package:bootcamp_project/services/location_services.dart';
import 'package:bootcamp_project/services/place_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  double lat = 0;
  double long = 0;
  final TextEditingController _searchController = TextEditingController();
  List<PlaceElement> nearbyPlaces = [];

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await LocationService().getCurrentLocation().then((value) {
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });
      fetchNearbyPlaces(lat, long);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: nearbyPlaces.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(nearbyPlaces[index].displayName.text),
                subtitle: Text(nearbyPlaces[index].formattedAddress.toString()),
              );
            }));
  }

  // _searchBar(searchController: _searchController),

  Future<void> fetchNearbyPlaces(double rlat, double rlong) async {
    try {
      final places = await PlacesService().searchNearbyPlaces(
        rlat,
        rlong,
        'cafe',
      );
      if (places != null && places.containsKey('places')) {
        setState(() {
          nearbyPlaces = places['places'].map<PlaceElement>((place) => PlaceElement.fromJson(place)).toList();
        });
      } else {
        print('Invalid response format');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}

class _searchBar extends StatelessWidget {
  _searchBar({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final _contentPadding = EdgeInsets.symmetric(vertical: 10);
  final _hintTextStyle = TextStyle(fontStyle: FontStyle.italic, fontSize: 12);
  final _formFieldStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _searchController,
      style: _formFieldStyle,
      decoration: InputDecoration(
        contentPadding: _contentPadding,
        hintStyle: _hintTextStyle,
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
    );
  }
}
