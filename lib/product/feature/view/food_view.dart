// ignore_for_file: prefer_const_constructors

import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:bootcamp_project/product/services/location_services.dart';
import 'package:bootcamp_project/product/services/place_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await LocationService().getCurrentLocation().then((value) {
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: _searchBar(searchController: _searchController),
        ),
        Expanded(
            child: FutureBuilder(
                future: PlacesService().searchNearbyPlaces(lat, long, 'restaurant'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index].toString()),
                        subtitle: Text(snapshot.data[index].toString()),
                      );
                    });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }))
      ],
    ));
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
